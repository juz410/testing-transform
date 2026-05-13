<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemCodeViewPopUp.aspx.cs" Inherits="Sales_POS_ItemCode_ItemCodeViewPopUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Item Code View Info</title>
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
        <div style="margin-top: 5px">
            <table class="tableview">
                <tr>
                    <td style="width: 80%">
                        <table class="tableview" style="margin-top: -90px">
                            <tr>
                                <td class="title">Item Code</td>
                                <td>
                                    <telerik:RadTextBox ID="txtItemCode" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                                </td>
                                <td class="title">Item Group Type</td>
                                <td>
                                    <telerik:RadTextBox ID="txtItemGroupCode" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="title">Item Desc</td>
                                <td colspan="5">
                                    <telerik:RadTextBox ID="txtItemDesc" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
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
                                    <telerik:RadTextBox ID="txtCurQty" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                                </td>
                                <td class="title">Price</td>
                                <td>
                                    <telerik:RadTextBox ID="txtTotalPrice" Width="100%" runat="server" ReadOnly="true"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="title">SQL Acc Code</td>
                                <td>
                                    <telerik:RadTextBox ID="txtSQLAccCode" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                                </td>
                                <td class="title">SQL Acc Tax Code</td>
                                <td>
                                    <telerik:RadTextBox ID="txtSQLAccTaxCode" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="title">System</td>
                                <td colspan="5">
                                    <telerik:RadButton ID="BtnWeb" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Web/Admin" Skin="MetroTouch" GroupName="a" Enabled="false"></telerik:RadButton>
                                    <telerik:RadButton ID="BtnLover" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="Cuckoo Lover" Skin="MetroTouch" GroupName="a" Enabled="false"></telerik:RadButton>
                                    <telerik:RadButton ID="BtnLSD" AutoPostBack="true" ButtonType="ToggleButton" ToggleType="CheckBox" Font-Size="10pt" runat="server" Text="LSD" Skin="MetroTouch" GroupName="a" Enabled="false"></telerik:RadButton>
                                </td>
                            </tr>
                            <tr>
                                <td class="title">Is Self Pick Up</td>
                                <td colspan="1">
                                    <telerik:RadButton ID="ChkSelfPickUp" ButtonType="ToggleButton" ToggleType="CheckBox" runat="server" Skin="MetroTouch" Enabled="false"></telerik:RadButton>
                                </td>
                                <td class="title">Is By Delivery</td>
                                <td>
                                    <telerik:RadButton ID="ChkDelivery" ButtonType="ToggleButton" ToggleType="CheckBox" runat="server" Skin="MetroTouch" Enabled="false"></telerik:RadButton>
                                </td>
                            </tr>

                            <tr>
                                <td class="title">Remark</td>
                                <td colspan="4">
                                    <telerik:RadTextBox ID="txtRemark" Width="100%" runat="server" Rows="3" TextMode="MultiLine" ReadOnly="true"></telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 20%">
                        <table class="tableview">
                            <tr>
                                <td>
                                    <asp:Image ID="ImageID" runat="server" Height="250px" Width="250px" ImageAlign="Middle" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
