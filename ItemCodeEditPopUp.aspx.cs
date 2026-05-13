using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using POS;
using Telerik.Web.UI;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using CommonCode;


namespace ItemCode
{
public partial class Sales_POS_ItemCode_ItemCodeEditPopUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string ItemCode = Request["ItemCode"].ToString();
            this.LoadItemCode(ItemCode);
            this.LoadList();
        }
    }

    private void LoadList()
    {
        POSManager pm = new POSManager();
        List<ItemGrpCodeMView> ItemGrpList = new List<ItemGrpCodeMView>();
        ItemGrpList = pm.GetItemGrpMaster();
        cmbItem_Type.DataSource = ItemGrpList;
        cmbItem_Type.DataBind();
    }
    private void LoadItemCode(string ItemCode)
    {
        ItemGrpCodeView ItemList = new ItemGrpCodeView();
        POSManager pm = new POSManager();
        ItemList = pm.getItemCode(ItemCode);
        hiddenItemGrpID.Value = ItemList.ItemGrpID.ToString();
        cmbItem_Type.Text = ItemList.ItemGrpName;
        txtItemCode.Text = ItemList.ItemCode;
        txtDesc.Text = ItemList.ItemDescription;
        txtSQLACCCode.Text = ItemList.SQLAccAccountCode;
        txtTaxCode.Text = ItemList.SQLAccTaxCode;
        txtItemPrice.Text = ItemList.UnitTotalPrice.ToString();
        txtUnitPrice.Text = ItemList.UnitPrice.ToString();
        txtUnitTax.Text = ItemList.UnitPriceTax.ToString();
        txtCurQty.Text = ItemList.Qty.ToString();
        txtRemark.Text = ItemList.ItemRemark;
        ImageID.ImageUrl = ItemList.DetItemID >= 132 ? @"https://admin.cuckoo.com.my" + ItemList.ImageUrl : ItemList.ImageUrl;
        if (ItemList.IsAllowWebBool == true && ItemList.IsAllowCLoverBool == true && ItemList.IsAllowLSDBool == true)
        {
            BtnWeb.Checked = true;
            BtnLover.Checked = true;
            BtnLSD.Checked = true;
        }
        else if (ItemList.IsAllowWebBool == true && ItemList.IsAllowCLoverBool == true)
        {
            BtnWeb.Checked = true;
            BtnLover.Checked = true;
        }
        else if (ItemList.IsAllowWebBool == true && ItemList.IsAllowLSDBool == true)
        {
            BtnWeb.Checked = true;
            BtnLSD.Checked = true;
        }
        else if (ItemList.IsAllowCLoverBool == true && ItemList.IsAllowLSDBool == true)
        {
            BtnLover.Checked = true;
            BtnLSD.Checked = true;
        }
        else if (ItemList.IsAllowWebBool == true)
            BtnWeb.Checked = true;
        else if (ItemList.IsAllowLSDBool == true)
            BtnLSD.Checked = true;
        else if (ItemList.IsAllowCLoverBool == true)
            BtnLover.Checked = true;

        if (ItemList.IsSelfPickUp == true)
            BtnYesSelfPickUp.Checked = true;
        else
            BtnNoSelfPickUp.Checked = true;

        if (ItemList.isDelivery == true)
            BtnYesDelivery.Checked = true;
        else
            BtnNoDelivery.Checked = true;

        if (ItemList.IsAllowWS == true)
            BtnWST.Checked = true;
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        if (RadAsyncUpload1.UploadedFiles.Count < 0)
            RadWindowManager1.RadAlert("<b>Please select file to upload.</b>", 450, 160, "No file selected", "callBackFn", null);

        Data.LoginInfo li = Utils.SystemSecurity.getSession(HttpContext.Current, "login") as Data.LoginInfo;
        if (li != null)
        {
            if (this.ValidRequireField())
            {
                DataSQL.POSItemGrpD POSItemGrpD = new DataSQL.POSItemGrpD();
                POSItemGrpD = this.GetEditData_SaveItemGrpD(POSItemGrpD, li);
                POSManager pm = new POSManager();
                if (pm.DoUpdateItemCodeGroupDetail(POSItemGrpD))
                {
                    string msg = "";
                    msg += "Item Code Successfully Update <br /><br />";
                    RadWindowManager1.RadAlert("<b>" + msg + "</b>", 450, 160, "Update Item Code", "callBackFn", null);
                    this.ClearField();

                }
                else
                    RadWindowManager1.RadAlert("<b>Failed to Save. Please try again later.</b>", 450, 160, "Failed To Save", "callBackFn", null);
            }
        }
    }
    private Boolean ValidRequireField()
    {
        Boolean valid = true;
        string msg = "";

        if (string.IsNullOrEmpty(txtDesc.Text.Trim()))
        {
            valid = false;
            msg += "* Please key the Item Desc<br />";
        }

        //if (BtnWeb.Checked == false && BtnLover.Checked == false && BtnLSD.Checked == false)
        //{
        //    valid = false;
        //    msg += "* Please select your web type.<br />";
        //}

        if (BtnLSD.Checked == true && (BtnWeb.Checked == true || BtnLover.Checked == true))
        {
            valid = false;
            msg += "* Item Code for LSD must be different with Web & Cuckoo Lover.<br />";
        }
        if (!valid)
            RadWindowManager1.RadAlert("<b>" + msg + "</b>", 450, 160, "New Item Code ", "callBackFn", null);
        return valid;
    }
    private void ClearField()
    {
        cmbItem_Type.Enabled = false;
        txtDesc.ReadOnly = true;
        txtUnitPrice.ReadOnly = true;
        txtUnitTax.ReadOnly = true;
        txtCurQty.ReadOnly = true;
        txtItemPrice.ReadOnly = true;
        txtSQLACCCode.ReadOnly = true;
        HiddenFieldName.Value = "";
        txtTaxCode.ReadOnly = true;
        BtnWeb.Enabled = false;
        BtnLover.Enabled = false;
        BtnLSD.Enabled = false;
        BtnYesSelfPickUp.Enabled = false;
        BtnNoSelfPickUp.Enabled = false;
        BtnYesDelivery.Enabled = false;
        BtnNoDelivery.Enabled = false;
        txtRemark.ReadOnly = true;
        cbEnabled.Enabled = false;
    }
    public DataSQL.POSItemGrpD GetEditData_SaveItemGrpD(DataSQL.POSItemGrpD POSItemGrpD, Data.LoginInfo li)
    {
        string NowYear = HiddenYear.Value;
        string NowMonth = HiddenMonth.Value;
        string NowDay = HiddenDay.Value;
        string targetFolder = "/CuckooWeb3/UserUpload/" + NowYear + "/" + NowMonth + "/" + NowDay + "/"; //Live use
        string ImageUrl = ImageID.ImageUrl;
        string ImageFullPath = ImageUrl.Replace("https://admin.cuckoo.com.my", " ");
        decimal UnitPrice = 0;
        decimal UnitTax = 0;
        decimal TotalPrice = 0;

        if (!string.IsNullOrEmpty(txtItemPrice.Text.Trim()))
        {
            TotalPrice = Decimal.Parse(txtItemPrice.Text.Trim());
            UnitPrice = (Decimal.Parse(TotalPrice.ToString()) / Decimal.Parse("1.00"));
            UnitTax = (TotalPrice - UnitPrice);
        }

        POSItemGrpD.ItemCode = txtItemCode.Text;
        POSItemGrpD.POSItemGrpID = cmbItem_Type.SelectedIndex > -1 ? short.Parse(cmbItem_Type.SelectedValue) : short.Parse(hiddenItemGrpID.Value);
        POSItemGrpD.ItemDesc = txtDesc.Text;
        POSItemGrpD.SQLAccAccountCode = txtSQLACCCode.Text;
        POSItemGrpD.SQLAccTaxCode = txtTaxCode.Text;
        POSItemGrpD.UnitPrice = Convert.ToDecimal(string.Format("{0:0.00}", UnitPrice));
        POSItemGrpD.UnitPriceTax = Convert.ToDecimal(string.Format("{0:0.00}", UnitTax));
        POSItemGrpD.UnitTotalPrice = TotalPrice;
        POSItemGrpD.ItemRemark = txtRemark.Text;
        POSItemGrpD.IsAllowLSD = BtnLSD.Checked == true ? true : false;
        POSItemGrpD.IsAllowWeb = BtnWeb.Checked == true ? true : false;
        POSItemGrpD.IsAllowCLover = BtnLover.Checked == true ? true : false;
        POSItemGrpD.IsSelfPickUp = BtnYesSelfPickUp.Checked == true ? true : false;
        POSItemGrpD.IsByDelivery = BtnYesDelivery.Checked == true ? true : false;
        POSItemGrpD.Enabled = cbEnabled.Checked == true ? true : false;
        POSItemGrpD.ImageFullPath = HiddenFieldName.Value != string.Empty ? targetFolder + HiddenFieldName.Value.ToString() : ImageFullPath.TrimStart();
        POSItemGrpD.IsAllowWS = BtnWST.Checked == true ? true : false;
        return POSItemGrpD;
    }
    protected async void RadAsyncUpload1_FileUploaded(object sender, Telerik.Web.UI.FileUploadedEventArgs e)
    {
        Data.LoginInfo li = Utils.SystemSecurity.getSession(HttpContext.Current, "login") as Data.LoginInfo;
        if (RadAsyncUpload1.UploadedFiles.Count > 0)
        {
            CloudServerManager.FileManagement cloudManager = new CloudServerManager.FileManagement();
            try
            {
                string NowYear = string.Format("{0:0000}", DateTime.Now.Year);
                string NowMonth = string.Format("{0:00}", DateTime.Now.Month);
                string NowDay = string.Format("{0:00}", DateTime.Now.Day);
                //if (!System.IO.Directory.Exists(Server.MapPath("/CuckooWeb3/UserUpload/" + NowYear + "/")))
                //    System.IO.Directory.CreateDirectory(Server.MapPath("/CuckooWeb3/UserUpload/" + NowYear + "/"));
                //if (!System.IO.Directory.Exists(Server.MapPath("/CuckooWeb3/UserUpload/" + NowYear + "/" + NowMonth + "/")))
                //    System.IO.Directory.CreateDirectory(Server.MapPath("/CuckooWeb3/UserUpload/" + NowYear + "/" + NowMonth + "/"));
                //if (!System.IO.Directory.Exists(Server.MapPath("/CuckooWeb3/UserUpload/" + NowYear + "/" + NowMonth + "/" + NowDay + "/")))
                //    System.IO.Directory.CreateDirectory(Server.MapPath("/CuckooWeb3/UserUpload/" + NowYear + "/" + NowMonth + "/" + NowDay + "/"));

                string targetFolder = "/CuckooWeb3/UserUpload/" + NowYear + "/" + NowMonth + "/" + NowDay + "/"; //Live use
                HiddenDay.Value = NowDay;
                HiddenMonth.Value = NowMonth;
                HiddenYear.Value = NowYear;

                string filename = DateTime.Now.ToString("yyyyMMddhhmmssfff") + "_" + e.File.FileName;
                HiddenFieldName.Value = filename;
                //e.File.SaveAs(Path.Combine(Server.MapPath(targetFolder), filename)); //Live & demo & debug use
                using (var formData = new MultipartFormDataContent())
                {
                    HttpContent filePathContent = new StringContent(targetFolder);
                    formData.Add(filePathContent, "filePath");
                    HttpContent fileStreamContent = new StreamContent(e.File.InputStream);
                    fileStreamContent.Headers.ContentType = new MediaTypeHeaderValue(e.File.ContentType);

                    // Add the HttpContent objects to the form data
                    formData.Add(fileStreamContent, "fileList", filename);
                    ResultJsonTemplate resultJsonTemplate = await cloudManager.fileUpload_formData(li.Username, formData);
                }
					
            }
            catch
            {
                RadWindowManager1.RadAlert("<b>Failed to upload. Please try again later.</b>", 450, 160, "Failed To Upload", "callBackFn", null);

            }
        }
    }

}

}
