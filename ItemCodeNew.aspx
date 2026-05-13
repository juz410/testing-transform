<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ItemCodeNew.aspx.cs" Inherits="ItemCode.Sales_POS_ItemCode_ItemCodeNew" Async="true"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function confirmCallBackFn(arg) {
                if (arg == true) {
                    var oButton = document.getElementById("content_btnHidden");
                    oButton.click();
                }
            }

        </script>
    </telerik:RadScriptBlock>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" VisibleStatusbar="false" Behaviors="Close" ShowContentDuringLoad="false" ReloadOnShow="true" EnableShadow="false" Modal="true"></telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Width="100%">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxPanel ID="RadAjaxPanel1" LoadingPanelID="RadAjaxLoadingPanel1" runat="server" Width="100%">
        <table class="tableview" style="width: 100%">
            <tr>
                <td class="title" style="width: 12%">Item Group Type</td>
                <td style="width: 21%">
                    <telerik:RadComboBox ID="cmbItem_Type" Width="100%" DataValueField="ItemGrpID" DataTextField="ItemGrpDesc" EmptyMessage="Item Group Type" runat="server">
                    </telerik:RadComboBox>
                </td>
                <td class="title" style="width: 12%">Item Code</td>
                <td style="width: 21%">
                    <telerik:RadTextBox ID="txtItemCode" Text="" EmptyMessage="Item code" MaxLength="15" Width="100%" runat="server"></telerik:RadTextBox>
                </td>
                <td class="title" style="width: 12%">Description</td>
                <td style="width: 22%">
                    <telerik:RadTextBox ID="txtDesc" Text="" EmptyMessage="Description" MaxLength="50" Width="100%" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="title" style="width: 12%">SQL ACC Code</td>
                <td style="width: 21%">
                    <telerik:RadTextBox ID="txtSQLACCCode" Text="" EmptyMessage="SQL ACC Code" MaxLength="10" Width="100%" runat="server"></telerik:RadTextBox>
                </td>
                <td class="title" style="width: 12%">SQL ACC Tax Code</td>
                <td style="width: 21%">
                    <telerik:RadTextBox ID="txtTaxCode" Text="" EmptyMessage="SQL ACC Tax Code" MaxLength="10" Width="100%" runat="server"></telerik:RadTextBox>
                </td>
                <td class="title" style="width: 12%">Item Price</td>
                <td style="width: 21%">
                    <telerik:RadNumericTextBox ID="txtItemPrice" Width="100%" runat="server" EmptyMessage="Item Price" NumberFormat-DecimalDigits="2"></telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td class="title" style="width: 12%">System</td>
                <td style="width: 21%">
                    <telerik:RadButton ID="BtnWeb" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Web/Admin" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                    <telerik:RadButton ID="BtnLover" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Cuckoo Lover" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                    <telerik:RadButton ID="BtnLSD" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="LSD" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                    <telerik:RadButton ID="BtnWST" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="WonderStar" Skin="MetroTouch" GroupName="a"></telerik:RadButton>
                </td>
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
                <asp:HiddenField ID="HiddenFieldName" runat="server" />
                <asp:HiddenField ID="HiddenDay" runat="server" />
                <asp:HiddenField ID="HiddenMonth" runat="server" />
                <asp:HiddenField ID="HiddenYear" runat="server" />
            </tr>
            <tr>
                <td class="title">Remark</td>
                <td colspan="5">
                    <telerik:RadTextBox ID="txtRemark" runat="server" Width="100%" TextMode="MultiLine" Rows="3"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="title">Image</td>
                <td colspan="5">
                    <telerik:RadAsyncUpload ID="RadAsyncUpload1" PostbackTriggers="BtnSave" OnFileUploaded="RadAsyncUpload1_FileUploaded" AllowedFileExtensions="jpg,png,jpeg" MaxFileInputsCount="1" runat="server" MaxFileSize="3600000"></telerik:RadAsyncUpload>
                    <span style="font-size: 8pt; color: #545454; margin-top: 4px">Allowed file extension : .jpg,.jpeg,.png || File size : < 3.5MB || Width X Height Must Be 250 pixels</span>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <div style="margin-top: 20px; margin-bottom: 20px; text-align: center">
                        <telerik:RadButton ID="BtnSave" runat="server" Text="Save" OnClick="BtnSave_Click">
                            <Icon PrimaryIconCssClass="rbSave" />
                        </telerik:RadButton>
                        &nbsp;
                    <telerik:RadButton ID="BtnClear" runat="server" Text="Clear" OnClick="BtnClear_Click">
                        <Icon PrimaryIconCssClass="rbCancel" />
                    </telerik:RadButton>
                    </div>
                </td>
            </tr>
        </table>
    </telerik:RadAjaxPanel>
</asp:Content>

