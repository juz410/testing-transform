<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemCodeEditPopUp.aspx.cs" Inherits="ItemCode.Sales_POS_ItemCode_ItemCodeEditPopUp" Async="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Item Code Edit Info</title>
    <link href="../../../css/body.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
            <script type="text/javascript">
                function callBackFn(arg) {
                    //alert("this is the client-side callback function. The RadAlert returned: " + arg);
                    return false;
                }
            </script>
        </telerik:RadScriptBlock>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <telerik:RadWindowManager ID="RadWindowManager1" Width="900" Height="500" VisibleStatusbar="false" Behaviors="Close"
            ShowContentDuringLoad="false" Modal="true" ReloadOnShow="true" runat="server" EnableShadow="false" Style="z-index: 999999">
            <Windows>
                <telerik:RadWindow ID="WindowPopup" runat="server"></telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
        <div style="margin-top: 5px">
            <table class="tableview">
                <tr>
                    <td class="title">Item Code</td>
                    <td>
                        <telerik:RadTextBox ID="txtItemCode" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                    </td>
                    <td class="title">Item Group Type</td>
                    <asp:HiddenField ID="hiddenItemGrpID" runat="server" />
                    <td>
                        <telerik:RadComboBox ID="cmbItem_Type" Width="100%" DataValueField="ItemGrpID" DataTextField="ItemGrpDesc" EmptyMessage="Item Group Type" runat="server">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="title">Item Desc</td>
                    <td colspan="5">
                        <telerik:RadTextBox ID="txtDesc" Width="100%" BorderWidth="0" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title">Unit Price</td>
                    <td>
                        <telerik:RadTextBox ID="txtUnitPrice" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                    </td>
                    <td class="title">Unit Tax</td>
                    <td>
                        <telerik:RadTextBox ID="txtUnitTax" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title">Current Quantity</td>
                    <td>
                        <telerik:RadNumericTextBox ID="txtCurQty" Width="100%" runat="server" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                    </td>
                    <td class="title">Price</td>
                    <td>
                        <telerik:RadNumericTextBox ID="txtItemPrice" Width="100%" runat="server" NumberFormat-DecimalDigits="2"></telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title">SQL Acc Code</td>
                    <td>
                        <telerik:RadTextBox ID="txtSQLACCCode" Width="100%" BorderWidth="0" runat="server"></telerik:RadTextBox>
                    </td>
                    <td class="title">SQL Acc Tax Code</td>
                    <td>
                        <telerik:RadTextBox ID="txtTaxCode" Width="100%" BorderWidth="0" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title">System</td>
                    <asp:HiddenField ID="HiddenFieldName" runat="server" />
                    <asp:HiddenField ID="HiddenDay" runat="server" />
                    <asp:HiddenField ID="HiddenMonth" runat="server" />
                    <asp:HiddenField ID="HiddenYear" runat="server" />
                    <td colspan="5">
                        <telerik:RadButton ID="BtnWeb" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Web/Admin" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                        <telerik:RadButton ID="BtnLover" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Cuckoo Lover" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                        <telerik:RadButton ID="BtnLSD" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="LSD" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                        <telerik:RadButton ID="BtnWST" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="WonderStar" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 12%">Is Self Pick Up?</td>
                    <td style="width: 21%">
                        <telerik:RadButton ID="BtnYesSelfPickUp" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="Radio" Font-Size="10pt" runat="server" Text="Yes" Skin="MetroTouch" GroupName="b"></telerik:RadButton>
                        <telerik:RadButton ID="BtnNoSelfPickUp" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="Radio" Font-Size="10pt" runat="server" Text="No" Skin="MetroTouch" GroupName="b"></telerik:RadButton>
                    </td>
                    <td class="title" style="width: 12%">Is By Delivery?</td>
                    <td style="width: 21%">
                        <telerik:RadButton ID="BtnYesDelivery" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="Radio" Font-Size="10pt" runat="server" Text="Yes" Skin="MetroTouch" GroupName="c"></telerik:RadButton>
                        <telerik:RadButton ID="BtnNoDelivery" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="Radio" Font-Size="10pt" runat="server" Text="No" Skin="MetroTouch" GroupName="c"></telerik:RadButton>
                    </td>
                </tr>
                <tr>
                    <td class="title">Remark</td>
                    <td colspan="4">
                        <telerik:RadTextBox ID="txtRemark" Width="100%" runat="server" Rows="3" TextMode="MultiLine" ReadOnly="true"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title">Re-Upload Image</td>
                    <td colspan="4">
                        <asp:Image ID="ImageID" runat="server" Height="250px" Width="250px" ImageAlign="Middle" />
                        <telerik:RadAsyncUpload ID="RadAsyncUpload1" PostbackTriggers="btnEdit" OnFileUploaded="RadAsyncUpload1_FileUploaded" AllowedFileExtensions="jpg" MaxFileInputsCount="1" runat="server" MaxFileSize="3600000"></telerik:RadAsyncUpload>
                        <span style="font-size: 8pt; color: #545454; margin-top: 4px">Allowed file extension : .jpg || File size : < 3.5MB || Width X Height Must Be 250 pixels</span>
                    </td>
                </tr>
                <tr>
                    <td class="title">Enable?</td>
                    <td>
                        <telerik:RadCheckBox ID="cbEnabled" runat="server" AutoPostBack="false" Checked="true"></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td class="title"></td>
                    <td colspan="3" style="text-align: center">
                        <telerik:RadButton ID="btnEdit" runat="server" Text="Edit Item Code" OnClick="btnEdit_Click"></telerik:RadButton>
                    </td>
                </tr>
            </table>
        </div>
        <%--<div style="margin-top: 5px">
            <table class="tableview">
                <tr>
                    <td class="title" style="width: 1%">Item Code</td>
                    <td style="width: 21%">
                        <telerik:RadTextBox ID="txtItemCode" ReadOnly="true" EmptyMessage="Item code" MaxLength="15" Width="100%" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">Item Group Type</td>
                    <asp:HiddenField ID="hiddenItemGrpID" runat="server" />
                    <td style="width: 21%">
                        <telerik:RadComboBox ID="cmbItem_Type" Width="100%" DataValueField="ItemGrpID" DataTextField="ItemGrpDesc" EmptyMessage="Item Group Type" runat="server">
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">Description</td>
                    <td style="width: 22%">
                        <telerik:RadTextBox ID="txtDesc" Text="" EmptyMessage="Description" MaxLength="50" Width="100%" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">SQL ACC Code</td>
                    <td colspan="2">
                        <telerik:RadTextBox ID="txtSQLACCCode" Text="" EmptyMessage="SQL ACC Code" MaxLength="10" Width="100%" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">SQL ACC Tax Code</td>
                    <td colspan="2">
                        <telerik:RadTextBox ID="txtTaxCode" Text="" EmptyMessage="SQL ACC Tax Code" MaxLength="10" Width="100%" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">System</td>
                    <asp:HiddenField ID="HiddenFieldName" runat="server" />
                    <asp:HiddenField ID="HiddenDay" runat="server" />
                    <asp:HiddenField ID="HiddenMonth" runat="server" />
                    <asp:HiddenField ID="HiddenYear" runat="server" />
                    <td colspan="2">--%>
                        <%--<telerik:RadButton ID="BtnWeb" ButtonType="ToggleButton" Text="Web/Admin" ToggleType="CheckBox" GroupName="a" runat="server"></telerik:RadButton>
                        <telerik:RadButton ID="BtnLover" ButtonType="ToggleButton" Text="Cuckoo Lover" ToggleType="CheckBox" GroupName="a" runat="server"></telerik:RadButton>
                        <telerik:RadButton ID="BtnLSD" ButtonType="ToggleButton" Text=" LSD" ToggleType="CheckBox" GroupName="a" runat="server"></telerik:RadButton>--%>

                        <%-- <telerik:RadButton ID="BtnWeb"   AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Web/Admin"    Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                        <telerik:RadButton ID="BtnLover" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Cuckoo Lover" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                        <telerik:RadButton ID="BtnLSD"   AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="LSD"          Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">Item Price</td>
                    <td colspan="2">
                        <telerik:RadNumericTextBox ID="txtItemPrice" Width="100%" runat="server" EmptyMessage="Item Price" NumberFormat-DecimalDigits="2"></telerik:RadNumericTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">Remark</td>
                    <td colspan="5">
                        <telerik:RadTextBox ID="txtRemark" runat="server" Width="100%" TextMode="MultiLine" Rows="3"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td class="title" style="width: 1%">Image</td>
                    <td>
                        <asp:Image ID="ImageID" runat="server" Height="250px" Width="250px" ImageAlign="Middle" />
                        <telerik:RadAsyncUpload ID="RadAsyncUpload1" PostbackTriggers="btnEdit" OnFileUploaded="RadAsyncUpload1_FileUploaded" AllowedFileExtensions="jpg" MaxFileInputsCount="1" runat="server" MaxFileSize="3600000"></telerik:RadAsyncUpload>
                        <span style="font-size: 8pt; color: #545454; margin-top: 4px">Allowed file extension : .jpg || File size : < 3.5MB || Width X Height Must Be 250 pixels</span>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="5">
                        <telerik:RadCheckBox ID="cbEnabled" runat="server" AutoPostBack="false" Checked="true" Text="Enabled"></telerik:RadCheckBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" style="text-align: center">
                        <telerik:RadButton ID="btnEdit" runat="server" Text="Edit Item Code" OnClick="btnEdit_Click"></telerik:RadButton>
                    </td>
                </tr>
            </table>
        </div>--%>
    </form>
</body>
</html>
