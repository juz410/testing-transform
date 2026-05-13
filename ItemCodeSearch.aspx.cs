using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using POS;
using System.Globalization;
using Telerik.Web.UI;


public partial class Sales_POS_ItemCode_ItemCodeSearch : System.Web.UI.Page
{
    DateTime defaultDate = DateTime.ParseExact("01/01/1900", "MM/dd/yyyy", CultureInfo.InvariantCulture);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            LoadList();
        }
        else
        {
            WindowAction.VisibleOnPageLoad = false;
            WindowPopup.VisibleOnPageLoad = false;
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
    protected void btnProceed_Click(object sender, EventArgs e)
    {
        string action = cmbAction.SelectedValue;
        string selection = hiddenSelection.Value;

        if (action == "Adjust")
        {
            WindowPopup.NavigateUrl = "~/Sales/POS/ItemCode/ItemCodeAdjustmentEntry.aspx?ItemCode=" + selection;
            WindowPopup.VisibleOnPageLoad = true;
        }
        else if (action == "View")
        {
            WindowPopup.NavigateUrl = "~/Sales/POS/ItemCode/ItemCodeViewPopUp.aspx?ItemCode=" + selection;
            WindowPopup.VisibleOnPageLoad = true;
        }
        else if (action == "Edit")
        {
            WindowPopup.NavigateUrl = "~/Sales/POS/ItemCode/ItemCodeEditPopUp.aspx?ItemCode=" + selection;
            WindowPopup.VisibleOnPageLoad = true;
        }
    }
    protected void RadGrid_ItemCode_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        this.ItemCodeListBind(this.RadGrid_ItemCode.CurrentPageIndex);
    }
    private void ItemCodeListBind(int CurrentPageIndex)
    {
        int pageindex = this.RadGrid_ItemCode.CurrentPageIndex = CurrentPageIndex;
        int pageSize = this.RadGrid_ItemCode.PageSize;

        POSManager psm = new POSManager();
        List<ItemGrpCodeView> resultList = new List<ItemGrpCodeView>();

        string ItemCode = "";
        string ItemDesc = "";
        List<string> ItemTypeList = new List<string>();
        //List<string> DivisionList = new List<string>();
        List<string> NEList = new List<string>();
        List<string> LSDList = new List<string>();

        if (!string.IsNullOrEmpty(txtItemCode.Text.Trim())) ItemCode = txtItemCode.Text.Trim().ToUpper();
        foreach (RadComboBoxItem itm in cmbItem_Type.CheckedItems) ItemTypeList.Add(itm.Value);
        foreach (RadComboBoxItem itm in cmbIsNE.CheckedItems)
            NEList.Add(itm.Value);
        foreach (RadComboBoxItem itm in cmbIsLSD.CheckedItems)
            LSDList.Add(itm.Value);
        if (!string.IsNullOrEmpty(txtItemDesc.Text.Trim())) ItemDesc = txtItemDesc.Text.Trim().ToUpper();
        //foreach (RadComboBoxItem itm in this.cmbDivision.CheckedItems)
        //    DivisionList.Add(itm.Value);

        resultList = psm.getItemCodeList(ItemCode, ItemDesc, ItemTypeList, NEList, LSDList,null,pageindex, pageSize);
        RadGrid_ItemCode.VirtualItemCount = resultList.Count == 0 ? 0 : resultList[0].TotalCount;
        RadGrid_ItemCode.DataSource = resultList;
    }
    protected void RadGrid_ItemCode_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "Action")
        {
            GridDataItem itm = (GridDataItem)e.Item;
            string ItemCode = itm.GetDataKeyValue("ItemCode").ToString();
            txtSelection.Text = ItemCode;
            hiddenSelection.Value = ItemCode.Trim().ToString();
            cmbAction.SelectedIndex = 0;
            WindowAction.VisibleOnPageLoad = true;
        }
        else if (e.CommandName == "Search")
        {
            RadGrid_ItemCode.CurrentPageIndex = 0;
            RadGrid_ItemCode.VirtualItemCount = 0;
            this.ItemCodeListBind(0);
            RadGrid_ItemCode.Rebind();
        }
        else if (e.CommandName == "Clear")
        {
            this.ClearField();
        }
        else if (e.CommandName == "ExportList")
        {
            if (RadGrid_ItemCode.Items.Count > 0)
            {
                this.DoExport();
            }
            else
            {
                RadWindowManager1.RadAlert("<b>No record to export.</b>", 450, 160, "No Item To Export", "callBackFn", null);
            }
        }

    }
    private void DoExport()
    {
        RadGrid_ItemCode.CurrentPageIndex = 0;
        RadGrid_ItemCode.ExportSettings.IgnorePaging = true;
        RadGrid_ItemCode.ExportSettings.OpenInNewWindow = true;
        RadGrid_ItemCode.ExportSettings.FileName = "ItemCodeList";
        RadGrid_ItemCode.ExportSettings.Excel.Format = GridExcelExportFormat.Biff;
        RadGrid_ItemCode.HeaderStyle.Font.Underline = true;
        RadGrid_ItemCode.HeaderStyle.Font.Bold = true;
        RadGrid_ItemCode.HeaderStyle.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FFFFFF");
        RadGrid_ItemCode.HeaderStyle.BackColor = System.Drawing.ColorTranslator.FromHtml("#DCDCDC");
        RadGrid_ItemCode.ExportSettings.Excel.AutoFitImages = true;
        RadGrid_ItemCode.ExportSettings.ExportOnlyData = true;
        RadGrid_ItemCode.MasterTableView.ExportToExcel();

    }
    private void ClearField()
    {
        txtItemCode.Text = "";
        txtItemDesc.Text = "";
        cmbItem_Type.ClearCheckedItems();
    }
}