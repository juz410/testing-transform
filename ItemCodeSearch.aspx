<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ItemCodeSearch.aspx.cs" Inherits="Sales_POS_ItemCode_ItemCodeSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="content" runat="Server">
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            function callBackFn(arg) {
                //alert("this is the client-side callback function. The RadAlert returned: " + arg);
            }
            function OnClientClose(oWnd, args) {
                //__doPostBack("RELOAD");
                var oButton = document.getElementById("content_btnHidden");
                oButton.click();
            }

        </script>
    </telerik:RadScriptBlock>
    <telerik:RadWindowManager ID="RadWindowManager1" Width="900" Height="500" VisibleStatusbar="false" Behaviors="Close" ShowContentDuringLoad="false" Modal="true" ReloadOnShow="true" runat="server" EnableShadow="false" Style="z-index: 7200">
        <Windows>
            <telerik:RadWindow ID="WindowPopup" runat="server" OnClientClose="OnClientClose"></telerik:RadWindow>
            <telerik:RadWindow ID="WindowAction" runat="server" Width="500" Height="300" Title="What Would You Like To Do ?" ShowOnTopWhenMaximized="false" OnClientClose="closeCombos">
                <ContentTemplate>
                    <div style="margin-top: 5px; margin-bottom: 5px;">
                        <asp:HiddenField ID="hiddenSelection" runat="server" />
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtAction1" ReadOnly="true" Width="100%" BorderWidth="0" Text="You have selected : " runat="server"></telerik:RadTextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtSelection" BackColor="#F8F8F8" Font-Size="12pt" Font-Bold="true" Width="100%" ReadOnly="true" Text="" runat="server"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtAction2" ReadOnly="true" Width="100%" BorderWidth="0" Text="What would you like to do ?" runat="server"></telerik:RadTextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadComboBox ID="cmbAction" Width="100%" runat="server" ZIndex="100000" EmptyMessage="Action">
                                        <Items>
                                            <telerik:RadComboBoxItem Value="View" Text="View Item" Selected="true" />
                                            <telerik:RadComboBoxItem Value="Adjust" Text="Do Item Adjustment" />
                                            <telerik:RadComboBoxItem Value="Edit" Text="Edit Item" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%; margin-top: 10px">
                            <tr>
                                <td style="text-align: center">
                                    <telerik:RadButton ID="btnProceed" runat="server" Text="Proceed" OnClick="btnProceed_Click">
                                        <Icon PrimaryIconCssClass="rbNext" />
                                    </telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                </ContentTemplate>
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <div>
        <table style="width: 100%">
            <tr>
                <th class="caption">Item Code Search</th>
            </tr>
        </table>
    </div>
    <table class="tableview">
        <tr>
            <td class="title" style="width: 12%">Item Type</td>
            <td style="width: 21%">
                <telerik:RadComboBox ID="cmbItem_Type" Width="100%" DataValueField="ItemGrpID" DataTextField="ItemGrpDesc" EmptyMessage="Item Type" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" runat="server">
                </telerik:RadComboBox>
            </td>
            <td class="title" style="width: 12%">Item Code</td>
            <td style="width: 21%">
                <telerik:RadTextBox ID="txtItemCode" Width="100%" EmptyMessage="Item Code" runat="server"></telerik:RadTextBox>
            </td>
            <td class="title" style="width: 12%">Item Desc</td>
            <td style="width: 22%">
                <telerik:RadTextBox ID="txtItemDesc" Width="100%" EmptyMessage="Item Description" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        <%--<tr>
             <td class="title">Division</td>
                    <td>
                        <telerik:RadComboBox ID="cmbDivision" runat="server" Width="100%" EmptyMessage="Division" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                            <Items>
                                <telerik:RadComboBoxItem Value="236" Text="NE" />
                                <telerik:RadComboBoxItem Value="447" Text="LSD" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
          </tr>--%>
        <tr>
            <td class="title" style="width: 12%">Is SR Item Bank</td>
            <td>
                <telerik:RadComboBox ID="cmbIsNE" runat="server" Width="100%" EmptyMessage="SR ITEM BANK" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                    <Items>
                        <telerik:RadComboBoxItem Value="1" Text="True" />
                        <telerik:RadComboBoxItem Value="0" Text="False" />
                    </Items>
                </telerik:RadComboBox>
            </td>
            <td class="title" style="width: 12%">Is LSD Item Bank</td>
            <td>
                <telerik:RadComboBox ID="cmbIsLSD" runat="server" Width="100%" EmptyMessage="LSD ITEM BANK" CheckBoxes="true" EnableCheckAllItemsCheckBox="true">
                    <Items>
                        <telerik:RadComboBoxItem Value="1" Text="True" />
                        <telerik:RadComboBoxItem Value="0" Text="False" />
                    </Items>
                </telerik:RadComboBox>
            </td>
        </tr>

    </table>

    <div style="margin-top: 10px">
        <telerik:RadGrid ID="RadGrid_ItemCode" runat="server" AutoGenerateColumns="false" MasterTableView-AllowPaging="true"
            AllowPaging="True" AllowSorting="true" PageSize="10" AllowCustomPaging="true" OnNeedDataSource="RadGrid_ItemCode_NeedDataSource"
            OnItemCommand="RadGrid_ItemCode_ItemCommand">
            <ClientSettings EnableRowHoverStyle="true">
                <Selecting AllowRowSelect="false" />
            </ClientSettings>
            <MasterTableView DataKeyNames="ItemCode"
                CommandItemDisplay="Top" NoMasterRecordsText="No Item Code Found."
                CommandItemStyle-HorizontalAlign="Right"
                CommandItemStyle-Height="40px" TableLayout="Fixed">
                <CommandItemTemplate>
                    <div style="margin-right: 5px">
                        <telerik:RadButton ID="btnSearch" runat="server" Text="Search" CommandName="Search">
                            <Icon PrimaryIconCssClass="rbSearch" PrimaryIconLeft="4" PrimaryIconTop="5"></Icon>
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnClear" runat="server" Text="Clear" CommandName="Clear">
                            <Icon PrimaryIconCssClass="rbCancel" PrimaryIconLeft="4" PrimaryIconTop="5"></Icon>
                        </telerik:RadButton>
                        <telerik:RadButton ID="btnExport" runat="server" Text="Export To Excel" CommandName="ExportList">
                            <Icon PrimaryIconCssClass="rbPrint" PrimaryIconLeft="4" PrimaryIconTop="5"></Icon>
                        </telerik:RadButton>
                    </div>
                </CommandItemTemplate>
                <PagerStyle PageSizeControlType="RadComboBox" AlwaysVisible="true" HorizontalAlign="Center"></PagerStyle>
                <Columns>
                    <telerik:GridTemplateColumn HeaderText="No." ItemStyle-Width="5%" HeaderStyle-Width="5%">
                        <ItemTemplate>
                            <%#Container.DataSetIndex + 1%>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="IsDivStr" HeaderText="Division" ItemStyle-Width="10%" HeaderStyle-Width="10%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ItemGrpName" HeaderText="Item Group" ItemStyle-Width="10%" HeaderStyle-Width="10%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ItemCode" HeaderText="Item Code" ItemStyle-Width="10%" HeaderStyle-Width="10%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ItemDescription" HeaderText="Item Desc" ItemStyle-Width="10%" HeaderStyle-Width="10%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ItemRemark" HeaderText="Item Remark" ItemStyle-Width="60%" HeaderStyle-Width="60%">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Qty" HeaderText="Qty" ItemStyle-Width="10%" HeaderStyle-Width="5%">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn ItemStyle-Width="5%" HeaderStyle-Width="5%">
                        <ItemTemplate>
                            <telerik:RadButton ID="btnAction" runat="server" Text="" Font-Underline="true" ButtonType="ToggleButton" ToggleType="None" CommandName="Action">
                                <Icon PrimaryIconCssClass="rbOpen" />
                            </telerik:RadButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <%--          <telerik:GridBoundColumn UniqueName="Rate" DataField="Rate" HeaderText="Currency Rate" Display="false">
                </telerik:GridBoundColumn>--%>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>

