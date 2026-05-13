using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using POS;

namespace ItemCode
{
public partial class Sales_POS_ItemCode_ItemCodeViewPopUp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string ItemCode = Request["ItemCode"].ToString();
            this.LoadItemCode(ItemCode);
        }
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
            txtRemark.Text = R.ItemRemark;
            txtCurQty.Text = R.Qty.ToString();
            txtUnitPrice.Text = R.UnitPrice.ToString();
            txtUnitTax.Text = R.UnitPriceTax.ToString();
            txtTotalPrice.Text = R.UnitTotalPrice.ToString();
            ImageID.ImageUrl = R.DetItemID >= 136 ? @"https://admin.cuckoo.com.my" + R.ImageUrl : R.ImageUrl;
            txtItemGroupCode.Text = R.ItemGrpName;
            if (R.IsAllowWeb == 1 && R.IsAllowCLover == 1 && R.IsAllowLSD == 1)
            {
                BtnWeb.Checked = true;
                BtnLover.Checked = true;
                BtnLSD.Checked = true;
            }
            else if (R.IsAllowWeb == 1 && R.IsAllowCLover == 1)
            {
                BtnWeb.Checked = true;
                BtnLover.Checked = true;
            }
            else if (R.IsAllowWeb == 1 && R.IsAllowLSD == 1)
            {
                BtnWeb.Checked = true;
                BtnLSD.Checked = true;
            }
            else if (R.IsAllowCLover == 1 && R.IsAllowLSD == 1)
            {
                BtnLover.Checked = true;
                BtnLSD.Checked = true;
            }
            else if (R.IsAllowWeb == 1)
                BtnWeb.Checked = true;
            else if (R.IsAllowLSD == 1)
                BtnLSD.Checked = true;
            else if (R.IsAllowCLover == 1)
                BtnLover.Checked = true;
            txtSQLAccCode.Text = R.SQLAccAccountCode;
            txtSQLAccTaxCode.Text = R.SQLAccTaxCode;

            if (R.IsSelfPickUp == true)
                ChkSelfPickUp.Checked = true;
            else
                ChkSelfPickUp.Checked = false;

            if (R.isDelivery == true)
                ChkDelivery.Checked = true;
            else
                ChkDelivery.Checked = false;
        }
    }
}

}
