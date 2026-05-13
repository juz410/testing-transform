using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Miscellaneous;
using System.Globalization;
using Telerik.Web.UI;
using POS;
using CommonCode;

public partial class Sales_POS_ItemCode_ItemCodeAdjustmentEntry : System.Web.UI.Page
{
    DateTime defaultDate = DateTime.ParseExact("01/01/1900", "MM/dd/yyyy", CultureInfo.InvariantCulture);
    protected void Page_Load(object sender, EventArgs e)
    {
        Data.LoginInfo li = Utils.SystemSecurity.getSession(HttpContext.Current, "login") as Data.LoginInfo;
        if (!Page.IsPostBack)
        {
            string ItemCode = Request["ItemCode"].ToString();
            this.LoadItemCode(ItemCode);
        }
    }

    private void LoadReasonStockInList()
    {
        CodeManager cm = new CodeManager();
        List<CodeView> ReasonList = new List<CodeView>();
        ReasonList = cm.GetReasonCode(11);
        cmbReason.DataSource = ReasonList.Where(itm=>itm.CodeID == 106 || itm.CodeID == 107).ToList();
        cmbReason.DataBind();
    }
    private void LoadReasonStockOutList()
    {
        CodeManager cm = new CodeManager();
        List<CodeView> ReasonList = new List<CodeView>();
        ReasonList = cm.GetReasonCode(11);
        cmbReason.DataSource = ReasonList.Where(itm => itm.CodeID != 106).ToList();
        cmbReason.DataBind();
    }
    private void LoadItemCode(string ItemCode)
    {
        List<ItemGrpCodeView> ItemList = new List<ItemGrpCodeView>();
        POSManager pm = new POSManager();
        ItemList = pm.getItemCodeList(ItemCode, "", null,null,null,null, 0, 0);
        var R = ItemList.FirstOrDefault();
        if (R != null)
        {
            txtItemCode.Text = R.ItemCode;
            txtItemDesc.Text = R.ItemDescription;
            txtCurQty.Text = R.Qty.ToString();

        }
    }
    protected void BtnClear_Click(object sender, EventArgs e)
    {
        this.ClearField();

    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
         string ItemCode = Request["ItemCode"].ToString();
         Data.LoginInfo li = Utils.SystemSecurity.getSession(HttpContext.Current, "login") as Data.LoginInfo;
         if (li != null)
         {
             if (this.ValidRequiredField())
             {
                 DataSQL.ItemAdjM ItemAdjMaster = new DataSQL.ItemAdjM();
                 ItemAdjMaster = this.GetSaveData_ItemAdjMaster(ItemAdjMaster, li);

                 DataSQL.ItemAdjD ItemAdjDetail = new DataSQL.ItemAdjD();
                 ItemAdjDetail = this.GetSaveData_ItemAdjDetail(ItemAdjDetail, li);

                 POSManager pm = new POSManager();
                 if (pm.DoSaveItemCodeAdjustment(ItemAdjMaster, ItemAdjDetail))
                 {
                     string msg = "";
                     msg += "Item Code Adjustment Successfully Saved <br /><br />";
                     msg += "Adjustment Number: " + ItemAdjMaster.ItemAdjNo + "<br />";
                     RadWindowManager1.RadAlert("<b>" + msg + "</b>", 450, 160, "Item Code Adjustment", "callBackFn", null);
                     this.ClearField();
                     this.LoadItemCode(ItemCode);
                 }
                 else
                     RadWindowManager1.RadAlert("<b>Failed to Save. Please try again later.</b>", 450, 160, "Failed To Save", "callBackFn", null);
             }
             
         }
         else
             RadWindowManager1.RadAlert("<b>Your login session was expired.<br />Please relogin to Cuckoo Web System.</b>", 450, 160, "Session Expired", "callBackFn", null);

    }
    private void ClearField()
    {
        cmbAdjType.ClearSelection();
        cmbReason.ClearSelection();
        txtQuantity.Text = "";
        txtRemark.Text = "";
        cmbReason.Items.Clear();
    }
    private Boolean ValidRequiredField()
    {
        Boolean valid = true;
        string message = "";

        if (cmbAdjType.SelectedIndex < 0)
        {
            valid = false;
            message += "* Please select adjustment type.<br />";
        }

        if (cmbReason.SelectedIndex < 0)
        {
            valid = false;
            message += "* Please select adjustment reason.<br />";
        }


        if (string.IsNullOrEmpty(txtQuantity.Text.Trim()))
        {
            valid = false;
            message += "* Please key the Quantity<br />";
        }
        else
        {
            if ( Int16.Parse(txtQuantity.Text.Trim())< 0)
            {
                valid = false;
                message += "* Mininum Qty must 1 or more than 1<br />";
            }
        }

        if (cmbAdjType.SelectedIndex > -1 && (!string.IsNullOrEmpty(txtQuantity.Text.Trim())))
        {
            if (cmbAdjType.SelectedValue == "119")
            {
                Int16 CurQty = Int16.Parse(txtCurQty.Text);
                Int16 AdjQty = Int16.Parse(txtQuantity.Text);

                if (CurQty - AdjQty < 0)
                {
                    valid = false;
                    message += "* Current Quantity cannot below zero.Please re-key your quantity.<br />";
                }
            }
        }

        if (!string.IsNullOrEmpty(txtRemark.Text.Trim()))
        {

            if (txtRemark.Text.Trim().Length > 250)
            {
                valid = false;
                message += "* Remarks cannot exceed 250 characters.<br />";
            }
        }


        if (!valid)
            RadWindowManager1.RadAlert("<b>" + message + "</b>", 480, 160, "Item Adjustment Summary", "callBackFn", null);
        return valid;

    }
    private DataSQL.ItemAdjM GetSaveData_ItemAdjMaster(DataSQL.ItemAdjM ItemAdjMaster, Data.LoginInfo li)
    {

        ItemAdjMaster.ItemAdjNo = "";//Update Later
        ItemAdjMaster.ItemAdjTypeID = byte.Parse(cmbAdjType.SelectedValue);
        ItemAdjMaster.ReasonID = byte.Parse(cmbReason.SelectedValue);
        ItemAdjMaster.StatusID = 2;
        ItemAdjMaster.Remark = txtRemark.Text.Trim();
        ItemAdjMaster.Creator = li.UserID;
        ItemAdjMaster.CreateDate = DateTime.Now;
        ItemAdjMaster.Updator = 0;
        ItemAdjMaster.UpdateDate = defaultDate;
        return ItemAdjMaster;
    }
    private DataSQL.ItemAdjD GetSaveData_ItemAdjDetail(DataSQL.ItemAdjD ItemAdjDetail, Data.LoginInfo li)
    {
        byte itemNo = 1;
        ItemAdjDetail.ItemAdjNo = "";//Update Later
        ItemAdjDetail.ItemNo = itemNo;
        ItemAdjDetail.ItemCode = txtItemCode.Text;
        ItemAdjDetail.ItemDesc = txtItemDesc.Text;
        ItemAdjDetail.Qty = Int16.Parse(txtQuantity.Text);
  
        return ItemAdjDetail;
    }
    protected void cmbAdjType_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        cmbReason.ClearSelection();
        cmbReason.Text = string.Empty;

        if (cmbAdjType.SelectedValue == "118")
        {
            this.LoadReasonStockInList();
        }
        else
        {
            this.LoadReasonStockOutList();
        }
    }
}