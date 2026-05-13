using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using POS;

namespace ItemCode
{
public partial class Sales_POS_ItemCode_ItemBankStockMonitoringEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            RadGrid_ItemBank.DataSource = "";
            RadGrid_ItemBank.DataBind();
            this.defaultValue();
        }
    }
    private void defaultValue()
    {
        mypStockMonth.SelectedDate = DateTime.Now.AddMonths(-1);
    }
    protected void RadGrid_ItemBank_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = e.Item as GridDataItem;
            RadNumericTextBox textBox = (RadNumericTextBox)item.FindControl("txtQty");

            Boolean IsClosed = Boolean.Parse(item.GetDataKeyValue("IsClose").ToString());
            if (IsClosed == true)
            {
                textBox.Enabled = false;
            }
            else if (IsClosed == false)
            {
                textBox.Enabled = true;
            }

        }

    }
    protected void RadGrid_ItemBank_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        this.ItemStkListBind(this.RadGrid_ItemBank.CurrentPageIndex);
    }
    private void ItemStkListBind(int CurrentPageIndex)
    {
        POSManager pm = new POSManager();
        List<ItemBankStockCardView> ResultList = new List<ItemBankStockCardView>();

        byte StockMonth = 0;
        Int16 StockYear = 0;

        if (!string.IsNullOrEmpty(mypStockMonth.SelectedDate.ToString()))
        {
            StockMonth = byte.Parse(mypStockMonth.SelectedDate.Value.Month.ToString());
            StockYear = Int16.Parse(mypStockMonth.SelectedDate.Value.Year.ToString());
        }

        ResultList = pm.GetItemBankAllList(StockMonth, StockYear, 0, 0);
        RadGrid_ItemBank.DataSource = ResultList;
        RadGrid_ItemBank.DataBind();


    }
    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        string msg = "";
        msg += "Item Month :" + mypStockMonth.SelectedDate.Value.Month.ToString() + "<br />";
        msg += "Item Year :" + mypStockMonth.SelectedDate.Value.Year.ToString() + "<br />";
        msg += "Are you sure want to close it as your final stock quantity figure ?<br />";
        RadWindowManager1.RadConfirm("<b>" + msg + "</b>", "confirmCallBackFn", 550, 200, null, "Comfirm Final Item Figure ?");
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Data.LoginInfo li = Utils.SystemSecurity.getSession(HttpContext.Current, "login") as Data.LoginInfo;
        if (li != null)
        {
                List<DataSQL.ItemBankCardRaw> ItemBankCardRawList = new List<DataSQL.ItemBankCardRaw>();
                ItemBankCardRawList = this.GetSaveData_itemBankCardRawList(ItemBankCardRawList, li);

                POSManager pm = new POSManager();
                if (pm.DoUpdateItemBankCardRaw(ItemBankCardRawList))
                {
                    RadWindowManager1.RadAlert("<b>Item Bank Update Successfully.</b>", 450, 160, "Item Bank Count Monitoring Entry", "callBackFn", null);
                    ItemStkListBind(0);
                }
                else
                {
                    RadWindowManager1.RadAlert("<b>Failed to Update. Please try again later.</b>", 450, 160, "Failed To Update", "callBackFn", null);
                }           
        }
    }
    private List<DataSQL.ItemBankCardRaw> GetSaveData_itemBankCardRawList(List<DataSQL.ItemBankCardRaw> ItemCardRawList, Data.LoginInfo li)
    {
        foreach (GridDataItem itm in RadGrid_ItemBank.Items)
        {
            RadNumericTextBox textBox = (RadNumericTextBox)itm.FindControl("txtQty");
            string Loccode = itm.GetDataKeyValue("LocCode").ToString();
            string ItemCode = itm.GetDataKeyValue("ItemCode").ToString();
            string Category = itm.GetDataKeyValue("Category").ToString();
            string ItemMonth = itm.GetDataKeyValue("ItemMonth").ToString();
            string ItemYear = itm.GetDataKeyValue("ItemYear").ToString();

            int Qty = 0;
            if (!string.IsNullOrEmpty(textBox.Text.Trim())) Qty = Int16.Parse(textBox.Text.Trim());

            //New Process
            DataSQL.ItemBankCardRaw det = new DataSQL.ItemBankCardRaw();
            det.Location = Loccode;
            det.ItemBankCategory = Category;
            det.ItemBankCode = ItemCode;
            det.ItemBankMonth = byte.Parse(ItemMonth);
            det.ItemBankYear = Int16.Parse(ItemYear);
            det.ItemBankCount = Qty;
            ItemCardRawList.Add(det);    
        }
        return ItemCardRawList;
    }
    private DataSQL.ItemBankCardRawMaster GetSaveData_ItemCardRawMaster(DataSQL.ItemBankCardRawMaster ItemCardRawMaster, Data.LoginInfo li)
    {
        ItemCardRawMaster.Location = "HQ";
        ItemCardRawMaster.ItemBankMonth = byte.Parse(mypStockMonth.SelectedDate.Value.Month.ToString());
        ItemCardRawMaster.ItemBankYear = Int16.Parse(mypStockMonth.SelectedDate.Value.Year.ToString());
        ItemCardRawMaster.IsClose = true;
        ItemCardRawMaster.Creator = li.UserID;
        ItemCardRawMaster.CreateDate = DateTime.Now;
        return ItemCardRawMaster;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        RadGrid_ItemBank.CurrentPageIndex = 0;
        RadGrid_ItemBank.VirtualItemCount = 0;
        this.ItemStkListBind(0);
        RadGrid_ItemBank.Rebind();
        this.CheckCloseStock();
        Panel1.Visible = true;
        btnClear.Visible = true;
    }
    private void CheckCloseStock()
    {
        POSManager wm = new POSManager();
        List<DataSQL.ItemBankCardRawMaster> ResultList = new List<DataSQL.ItemBankCardRawMaster>();

        string LocCode = "HQ";
        byte StockMonth = 0;
        Int16 StockYear = 0;

        if (!string.IsNullOrEmpty(mypStockMonth.SelectedDate.ToString()))
        {
            StockMonth = byte.Parse(mypStockMonth.SelectedDate.Value.Month.ToString());
            StockYear = Int16.Parse(mypStockMonth.SelectedDate.Value.Year.ToString());
        }
        ResultList = wm.IsCloseItemBankStockCardRaw(LocCode, StockMonth, StockYear);
        if (ResultList.Count > 0)
        {
            RadWindowManager1.RadAlert("<b>This location already closed.Update Qty record are not allowed.</b>", 480, 160, "Item Bank Count Monitoring Entry", "callBackFn", null);
            btnSave.Visible = false;
            btnConfirm.Visible = false;
        }
        else
        {
            btnSave.Visible = true;
            btnConfirm.Visible = true;
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        btnSearch.Visible = true;
        btnClear.Visible = false;
        Panel1.Visible = false;
    }
    protected void btnHidden_Click(object sender, EventArgs e)
    {
        Data.LoginInfo li = Utils.SystemSecurity.getSession(HttpContext.Current, "login") as Data.LoginInfo;
        if (li != null)
        {
                DataSQL.ItemBankCardRawMaster ItemCardRawMaster = new DataSQL.ItemBankCardRawMaster();
                ItemCardRawMaster = this.GetSaveData_ItemCardRawMaster(ItemCardRawMaster, li);

                POSManager pm = new POSManager();
                if (pm.DoConfirmItemCardRawFigure(ItemCardRawMaster))
                {
                    RadWindowManager1.RadAlert("<b>Item Bank Successfully submit as final figure.</b>", 450, 160, "Item Bank Count Monitoring Entry", "callBackFn", null);
                    btnConfirm.Visible = false;
                    btnSave.Visible = false;
                    ItemStkListBind(0);
                }
                else
                {
                    RadWindowManager1.RadAlert("<b>Failed to Submit. Please try again later.</b>", 450, 160, "Failed To Submit", "callBackFn", null);
                }
            
        }
    }
}

}
