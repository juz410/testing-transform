using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using POS;
using System.Globalization;
using Telerik.Web.UI;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using CommonCode;


public partial class Sales_POS_ItemCode_ItemCodeNew : System.Web.UI.Page
{
    DateTime defaultDate = DateTime.ParseExact("01/01/1900", "MM/dd/yyyy", CultureInfo.InvariantCulture);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            LoadList();
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

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        if (RadAsyncUpload1.UploadedFiles.Count > 0)
        {
           

            Data.LoginInfo li = Utils.SystemSecurity.getSession(HttpContext.Current, "login") as Data.LoginInfo;
            if (li != null)
            {
                if (this.ValidRequireField())
                {
                    DataSQL.POSItemGrpD SaveItemGrpD = new DataSQL.POSItemGrpD();
                    SaveItemGrpD = this.GetSaveData_SaveItemGrpD(SaveItemGrpD, li);
                    POSManager pm = new POSManager();
                    if (pm.DoSaveItemCodeGroupDetail(SaveItemGrpD))
                    {
                        string msg = "";
                        msg += "New Item Code Successfully Saved <br /><br />";
                        RadWindowManager1.RadAlert("<b>" + msg + "</b>", 450, 160, "New Item Code", "callBackFn", null);
                        this.ClearField();
                    }
                    else
                        RadWindowManager1.RadAlert("<b>Failed to Save. Please try again later.</b>", 450, 160, "Failed To Save", "callBackFn", null);
                }
            }
        }
        else
        {
            RadWindowManager1.RadAlert("<b>Please select file to upload.</b>", 450, 160, "No file selected", "callBackFn", null);
        }
    }
    private DataSQL.POSItemGrpD GetSaveData_SaveItemGrpD(DataSQL.POSItemGrpD SaveItemGrpD, Data.LoginInfo li)
    {

        Int16 ItemGrpID=0;
        string ItemCode="";
        string ItemDesc="";
        string ItemRemark="";
        decimal UnitPrice=0;
        decimal UnitTax = 0;
        decimal TotalPrice=0;
        string SQLAccCode="";
        string SQLAccTaxCode="";
        Boolean Web=false;
        Boolean Cuckoo =false;
        Boolean LSD = false;
        Boolean WST = false;

       if (cmbItem_Type.SelectedIndex >-1)
            ItemGrpID = Int16.Parse(cmbItem_Type.SelectedValue.ToString());

        if (!string.IsNullOrEmpty(txtItemCode.Text.Trim()))
            ItemCode=txtItemCode.Text.Trim();
        
       if (!string.IsNullOrEmpty(txtDesc.Text.Trim()))
            ItemDesc=txtDesc.Text.Trim();

       if (!string.IsNullOrEmpty(txtRemark.Text.Trim()))
            ItemRemark = txtRemark.Text.Trim();

        if(!string.IsNullOrEmpty(txtItemPrice.Text.Trim()))
        {
            TotalPrice=Decimal.Parse(txtItemPrice.Text.Trim());
            UnitPrice = (Decimal.Parse(TotalPrice.ToString()) / Decimal.Parse("1.00"));
            UnitTax = (TotalPrice - UnitPrice);
        }

        if(BtnWeb.Checked)
            Web=true;

        if (BtnLover.Checked)
            Cuckoo = true;

        if (BtnLSD.Checked)
            LSD = true;

        if (BtnWST.Checked)
            WST = true;
        
        if (!string.IsNullOrEmpty(txtSQLACCCode.Text.Trim()))
            SQLAccCode = txtSQLACCCode.Text.Trim();

        if (!string.IsNullOrEmpty(txtTaxCode.Text.Trim()))
            SQLAccTaxCode = txtTaxCode.Text.Trim();

        string NowYear = HiddenYear.Value;
        string NowMonth = HiddenMonth.Value;
        string NowDay = HiddenDay.Value;

        string targetFolder = "/CuckooWeb3/UserUpload/" + NowYear + "/" + NowMonth + "/" + NowDay + "/"; //Live use

        SaveItemGrpD.POSItemGrpID = ItemGrpID;
        SaveItemGrpD.ItemCode = ItemCode;
        SaveItemGrpD.ItemDesc = ItemDesc;
        SaveItemGrpD.ItemRemark = ItemRemark;
        SaveItemGrpD.Enabled = true;
        SaveItemGrpD.UnitPrice = Convert.ToDecimal(string.Format("{0:0.00}", UnitPrice));
        SaveItemGrpD.UnitPriceTax = Convert.ToDecimal(string.Format("{0:0.00}", UnitTax));
        SaveItemGrpD.UnitTotalPrice = TotalPrice;
        SaveItemGrpD.ImageFullPath = targetFolder + HiddenFieldName.Value.ToString();
        SaveItemGrpD.IsAllowWeb = Web;
        SaveItemGrpD.IsAllowCLover = Cuckoo;
        SaveItemGrpD.IsAllowLSD = LSD;
        SaveItemGrpD.SQLAccAccountCode = SQLAccCode;
        SaveItemGrpD.SQLAccTaxCode = SQLAccTaxCode;
        SaveItemGrpD.IsSelfPickUp = BtnYesSelfPickUp.Checked ? true : false;
        SaveItemGrpD.IsByDelivery = BtnYesDelivery.Checked ? true : false;
        SaveItemGrpD.IsAllowWS = WST;
        return SaveItemGrpD;
    }
    private Boolean ValidRequireField()
    {
        Boolean valid = true;
        string msg = "";

        if (cmbItem_Type.SelectedIndex < 0)
        {
            valid = false;
            msg += "* Please select your Item Group Type.<br />";
        }

        if (string.IsNullOrEmpty(txtItemCode.Text.Trim()))
        {
            valid = false;
            msg += "* Please key the Item Code<br />";
        }


        if (string.IsNullOrEmpty(txtDesc.Text.Trim()))
        {
            valid = false;
            msg += "* Please key the Item Desc<br />";
        }

      
         if (cmbItem_Type.SelectedIndex >-1 &&  (!string.IsNullOrEmpty(txtItemCode.Text.Trim())))
         {
            string GrpItem = cmbItem_Type.SelectedValue.ToString();
            string ItemCode=txtItemCode.Text.Trim();
            POSManager pm = new POSManager();
            List<ItemGrpCodeView> resultList = new List<ItemGrpCodeView>();
            resultList = pm.CheckIsItemCodeExit(GrpItem,ItemCode);

             var qry = resultList.FirstOrDefault();

             if (qry != null)
             {
                 valid = false;
                 msg += "* Item Code :" + ItemCode + "<br/> This Item Code are exist. <br />";
             }
         }

         if (BtnWeb.Checked == false && BtnLover.Checked == false && BtnLSD.Checked == false)
         {
             valid = false;
             msg += "* Please select your web type.<br />";
         }


         if (BtnLSD.Checked == true && (BtnWeb.Checked == true || BtnLover.Checked == true))
         {
             valid = false;
             msg += "* Item Code for LSD must be different with Web & Cuckoo Lover.<br />";
         }
         if (BtnYesSelfPickUp.Checked == false && BtnNoSelfPickUp.Checked == false)
         {
             valid = false;
             msg += "* Please select Is Self Pick Up? whether Yes or No.<br />";
         }

         if (BtnYesDelivery.Checked == false && BtnNoDelivery.Checked == false)
         {
             valid = false;
             msg += "* Please select Is By Delivery? whether Yes or No.<br />";
         }

         //if (BtnYesSelfPickUp.Checked == true && BtnNoSelfPickUp.Checked == true)
         //{
         //    valid = false;
         //    msg += "* May only choose one for Is Self Pick Up? either Yes or No.<br />";
         //}

        if (!valid)
            RadWindowManager1.RadAlert("<b>" + msg + "</b>", 450, 160, "New Item Code ", "callBackFn", null);
        return valid;
    }
    private void ClearField()
    {
        cmbItem_Type.ClearSelection();
        txtItemCode.Text = "";
        txtDesc.Text = "";
        txtItemPrice.Text = "";
        txtRemark.Text = "";
        txtSQLACCCode.Text = "";
        txtTaxCode.Text = "";
        HiddenFieldName.Value = "";
        BtnLover.Checked = false;
        BtnWeb.Checked = false;
        BtnLSD.Checked = false;
        BtnYesSelfPickUp.Checked = false;
        BtnNoSelfPickUp.Checked = false;
        BtnYesDelivery.Checked = false;
        BtnNoDelivery.Checked = false;
    }
    protected void BtnClear_Click(object sender, EventArgs e)
    {
        this.ClearField();
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

                string filename =  DateTime.Now.ToString("yyyyMMddhhmmssfff") + "_" + e.File.FileName;
                HiddenFieldName.Value=filename;
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