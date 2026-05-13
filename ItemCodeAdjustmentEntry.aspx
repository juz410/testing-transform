<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemCodeAdjustmentEntry.aspx.cs" Inherits="Sales_POS_ItemCode_ItemCodeAdjustmentEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Do Item Adjustment</title>
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
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" VisibleStatusbar="false" Behaviors="Close" ShowContentDuringLoad="false" ReloadOnShow="true" EnableShadow="false" Modal="true"></telerik:RadWindowManager>
         <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server"></telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Width="100%">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Width ="100%" LoadingPanelID ="RadAjaxLoadingPanel1">
       <div style="margin-top:5px">
          <table class="tableview">
               <tr><td class="title" style="width:12%">Item Code</td> 
                  <td style="width:38%">
                     <telerik:RadTextBox ID="txtItemCode" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                         </td>
                         <td class="title" style="width:12%">Item Desc</td>
                        <td style="width:38%">
                             <telerik:RadTextBox ID="txtItemDesc" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                         </td>
                     </tr>
                   <tr><td class="title" >Adjustment Type</td>
                         <td >
                            <telerik:RadComboBox ID="cmbAdjType" Width="150px" EmptyMessage="Adjustment Type"  runat="server" AutoPostBack="true" OnSelectedIndexChanged="cmbAdjType_SelectedIndexChanged">
                             <Items>
                            <telerik:RadComboBoxItem Value="118" Text="Stock In" />
                            <telerik:RadComboBoxItem Value="119" Text="Stock Out" />
                            </Items>
                           </telerik:RadComboBox>
                         </td>       
                  <td class="title" >Reason Type</td>
                        <td >
                        <telerik:RadComboBox ID="cmbReason" DataTextField="Description" Width="200px" DataValueField="CodeID"  EmptyMessage="Adjustment Reason" runat="server" AutoPostBack="true"> 
                       </telerik:RadComboBox>
                      </td>       
                  </tr>
                <tr><td class="title">Current Quantity</td> 
                  <td>
                     <telerik:RadTextBox ID="txtCurQty" Width="100%" ReadOnly="true" BorderWidth="0" runat="server"></telerik:RadTextBox>
                         </td>
                         <td class="title">Quantity</td>
                        <td>
                             <telerik:RadNumericTextBox ID="txtQuantity" Width="100%"  EmptyMessage=" Adjustment Quantity" NumberFormat-DecimalDigits="0"  runat="server"></telerik:RadNumericTextBox>
                         </td>
                     </tr>
               <tr><td class="title" >Remark</td>
                     <td colspan ="4">
                         <telerik:RadTextBox ID="txtRemark" Width="100%"  runat="server" Rows ="3" TextMode="MultiLine"></telerik:RadTextBox>
                     </td>
                 </tr>
                <tr><td colspan="4">
                <div style="margin-top:20px;margin-bottom:20px;text-align:center">
                    <telerik:RadButton ID="BtnSave" runat="server" Text="Save" OnClick="BtnSave_Click">
                        <Icon PrimaryIconCssClass="rbSave" />
                    </telerik:RadButton> &nbsp;
                    <telerik:RadButton ID="BtnClear" runat="server" Text="Clear" OnClick="BtnClear_Click">
                        <Icon PrimaryIconCssClass="rbCancel" />
                    </telerik:RadButton>
                   </div>
                </td></tr>
          </table>
       </div>
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
