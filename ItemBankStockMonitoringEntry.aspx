<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeBehind="ItemBankStockMonitoringEntry.aspx.cs" Inherits="ItemCode.Sales_POS_ItemCode_ItemBankStockMonitoringEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" Runat="Server">
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
   <telerik:RadWindowManager ID="RadWindowManager1" Width="900" Height="500" VisibleStatusbar="false"  Behaviors="Close" ShowContentDuringLoad="false" Modal="true" ReloadOnShow="true" runat="server" EnableShadow="false" Style="z-index:7200">
</telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Silk">
</telerik:RadAjaxLoadingPanel>
       <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        </telerik:RadAjaxManagerProxy>
      <div>
        <table style="width:100%"><tr><th class="caption">Item Bank Stock Monitoring Entry</th></tr></table>
    </div>
      <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1" Width ="100%">
    <div style="margin-top:10px">
        <table class="tableview">
            <tr>
                  <td class="title" style="width:12%">Stock Month</td><asp:Button ID="btnHidden"  runat="server" style="visibility:hidden;width:1px" Text="" OnClick="btnHidden_Click" />
                  <td style="width:88%">
                    <telerik:RadMonthYearPicker ID="mypStockMonth"  MinDate="01/01/1900" width="160px" runat="server" Enabled="false"></telerik:RadMonthYearPicker>
                </td>
            </tr>
            <tr><td colspan ="2">
                <div style="margin-top:10px;margin-bottom:10px;text-align:center">
                    <telerik:RadButton ID="btnSearch" runat="server" Text="Search" CommandName="Search" OnClick="btnSearch_Click">
                          <Icon PrimaryIconCssClass="rbSearch" PrimaryIconLeft="4" PrimaryIconTop="5"></Icon>
                        </telerik:RadButton>
                         <telerik:RadButton ID="btnClear" runat="server" Text="Clear" Visible="false" CommandName="Clear" OnClick="btnClear_Click">
                         <Icon PrimaryIconCssClass="rbCancel" PrimaryIconLeft="4" PrimaryIconTop="5"></Icon>
                         </telerik:RadButton>
                </div>
                </td></tr>
            <tr><td colspan ="2">
                <asp:Panel ID="Panel1" runat="server" Visible="false">
                <table style="width:100%">
                    <tr><td>
                        <telerik:RadGrid ID="RadGrid_ItemBank" runat="server" AllowPaging="false"  Width="100%"   
                AutoGenerateColumns="false" OnItemDataBound="RadGrid_ItemBank_ItemDataBound" OnNeedDataSource="RadGrid_ItemBank_NeedDataSource">
                <ClientSettings EnableRowHoverStyle="true" >
              <Selecting AllowRowSelect="false" />
             </ClientSettings>
                  <MasterTableView 
                          CommandItemDisplay="None" NoMasterRecordsText="No Item found."
                         CommandItemStyle-HorizontalAlign="Right"
                         CommandItemStyle-Height="40px" TableLayout="Fixed"
                       GroupHeaderItemStyle-Font-Bold="true"
                       GroupHeaderItemStyle-Font-Size="Larger" 
                      GroupHeaderItemStyle-ForeColor="Black"
                         DataKeyNames="LocCode,Category,ItemMonth,ItemYear,ItemCode,IsClose">
                      <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldAlias="Category" FieldName="Category" HeaderText="Category Type"  ></telerik:GridGroupByField>
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="Category" SortOrder="Descending"></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                  </GroupByExpressions>
                         <PagerStyle PageSizeControlType="RadComboBox" AlwaysVisible="true" HorizontalAlign="Center"></PagerStyle>
                          <Columns>
                         <telerik:GridTemplateColumn HeaderText="No" ItemStyle-Width="10%" HeaderStyle-Width="10%">
                            <ItemTemplate>
                             <%# (Container.ItemIndex+1).ToString() %>
                              </ItemTemplate>
                               </telerik:GridTemplateColumn>
                               <telerik:GridBoundColumn DataField="ItemCode" HeaderStyle-Width="20%" ItemStyle-Width="20%" ItemStyle-CssClass="itemColumn" HeaderText="Stock Code"></telerik:GridBoundColumn>
                               <telerik:GridBoundColumn DataField="ItemDesc" HeaderStyle-Width="50%" ItemStyle-Width="50%" ItemStyle-CssClass="itemColumn" HeaderText="Stock Name"></telerik:GridBoundColumn>
  <%--                             <telerik:GridBoundColumn DataField="IsClose_Show" HeaderStyle-Width="5%" ItemStyle-Width="5%" ItemStyle-CssClass="itemColumn" HeaderText="IsClosed"></telerik:GridBoundColumn>--%>
                               <telerik:GridTemplateColumn HeaderText="Close" HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cbClose" Enabled="false" Checked='<%# Eval("IsClose") %>' runat="server" />
                                        </ItemTemplate>
                               </telerik:GridTemplateColumn>
                               <telerik:GridTemplateColumn HeaderText="Quantity" HeaderStyle-Width="10%" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" >
                                        <ItemTemplate>
                                            <telerik:RadNumericTextBox ID="txtQty" EmptyMessage ="0" NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0" MinValue="0"  Width="80px"   Text='<%# Eval("ItemCount") %>'   runat="server"></telerik:RadNumericTextBox>
                                        </ItemTemplate>
                               </telerik:GridTemplateColumn>
                              </Columns>
                        </MasterTableView>
                       </telerik:RadGrid>   
                        </td></tr>
                    <tr><td>
                  <div style="margin-top:25px;margin-bottom:25px;text-align:center;width:100%" >
                         <telerik:RadButton ID="btnSave" runat="server" Text="Update" OnClick="btnSave_Click" Width="115px" Visible ="false" >
                             <Icon PrimaryIconCssClass="rbSave" />
                         </telerik:RadButton>
                         <telerik:RadButton ID="btnConfirm" runat="server" Text="Submit As Final Figure" OnClick="btnConfirm_Click" Width="175px" Visible ="false">
                         </telerik:RadButton>
                    </div>
                </td></tr>
                </table>
                 </asp:Panel>
                </td></tr>
              </table>
            </div>
 
        </telerik:RadAjaxPanel>
</asp:Content>


