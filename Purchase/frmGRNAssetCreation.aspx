<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmGRNAssetCreation.aspx.cs" Inherits="AssetMobileApplication.Purchase.frmGRNAssetCreation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
     
        }

        function fncSelectPendingInvoice(source) {
            try {
                                         

                var row = $(source).closest("tr");

                $('#<%=hdGRNno.ClientID %>').val($("td", row).eq(1).html().replace(/&nbsp;/g, ''));
                $('#<%=hdnVendor.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));

                /*fncShowHideDivForPendingInvoice('PendingBarcode');*/

                return true;
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }

        function fncCreateAsset(source) {
            try {
                
                var row = $(source).closest("tr");

                $('#<%=hdnGRN.ClientID %>').val($("td", row).eq(0).html().replace(/&nbsp;/g, ''));


                return true;
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }

        function fncdelete(source) {
            try {

                
                var row = $(source).closest("tr");

                $('#<%=hdid.ClientID %>').val($("td", row).eq(1).html().replace(/&nbsp;/g, ''));
                $('#<%=btnDelete.ClientID %>').click();
               return true;
              }
              catch (err) {
                  ShowPopupMessageBox(err.message);
              }
          }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
        <ContentTemplate>
            <div class="container-fluid">
                <div class="block-header">
                    <ol class="breadcrumb breadcrumb-col-indigo">
                        <li><a href="javascript:void(0);"><i class="material-icons">home</i>Home</a></li>
                        <li><a href="javascript:void(0);"><i class="material-icons">create</i>Operations</a>
                        </li>
                        <li><a href="javascript:void(0);">GRN AssetCreation</a></li>
                    </ol>
                </div>
                <div class="container-group">
                    <div class="col-md-12">
                        <div class="container-group-top">
                            <div id="divTabheading" runat="server" class="col-md-4">
                                <asp:Panel runat="server" ID="pnlpending" Height="30px" HorizontalAlign="Center">
                                    <asp:Button Text="Pending Invoice" OnClick="tabPendingInvoice_Click" OnClientClick="return fncTabClickEvent('Tab1')" Style="width: 170px" ID="tabPendingInvoice" CssClass="Clicked" runat="server" />
                                    <%--<button id="tabPendingInvoice" onclick="return fncTabClickEvent('Tab1');" class="Clicked">Pending Invoice <i class="fa fa-arrow-down"></i></button>
                                    <button id="tabCompletedInvoice" onclick="return fncTabClickEvent('Tab2');" class="Initial">Completed Invoice <i class="fa fa-arrow-down"></i></button>--%>
                                    <asp:Button Text="Completed Invoice" OnClick="tabCompletedInvoice_Click" Style="width: 170px" ID="tabCompletedInvoice" CssClass="Initial" runat="server" />
                                </asp:Panel>
                            </div>
                            <div style="display: block; overflow: auto; height: 350px;" id="divgvPendingInvoice" runat="server" class="col-md-12">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="Server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvPendingInvoice" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
                                            <EmptyDataTemplate>
                                                <asp:Label ID="Lbl2" runat="server" Text="No Records Found"></asp:Label>
                                            </EmptyDataTemplate>
                                            <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                                            <RowStyle CssClass="pshro_GridDgnStyle" />
                                            <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                                NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
                                            <PagerStyle CssClass="pshro_text" />
                                            <Columns>                                               
                                                <asp:TemplateField HeaderText="Select">
                                                    <ItemTemplate>
                                                        <asp:Button Text="Select" OnClick="btnSelectPendingInvoice_Click" OnClientClick="return fncSelectPendingInvoice(this)" ID="btnSelectPendingInvoice" runat="server" class="Icon-Btn" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>                                               
                                                <asp:BoundField DataField="GRNno" HeaderText="GRN No"></asp:BoundField>
                                                <asp:BoundField DataField="Grndate" HeaderText="GRN Date"></asp:BoundField>
                                                <asp:BoundField DataField="VendorName" HeaderText="Vendor Name"></asp:BoundField>                                                
                                                <asp:BoundField DataField="TotalItems" HeaderText="Total Items"></asp:BoundField>
                                                <asp:BoundField DataField="TotalQty" HeaderText="Total QTY"></asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div style="overflow: auto; height: 350px;" id="divgvCompletedInvoice" runat="server" class="col-md-12">
                                <asp:GridView ID="gvCompletedInvoice" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
                                    <EmptyDataTemplate>
                                        <asp:Label ID="Label1" runat="server" Text="No Records Found"></asp:Label>
                                    </EmptyDataTemplate>
                                    <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                                    <RowStyle CssClass="pshro_GridDgnStyle" />
                                    <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                        NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
                                    <PagerStyle CssClass="pshro_text" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:Button Text="View" OnClick="btnSelectcompleteInvoice_Click" OnClientClick="return fncSelectPendingInvoice(this)" ID="btnSelectcompleteInvoice" runat="server" class="Icon-Btn" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="GRNno" HeaderText="GRN No"></asp:BoundField>
                                        <asp:BoundField DataField="Grndate" HeaderText="GRN Date"></asp:BoundField>
                                        <asp:BoundField DataField="TotalItems" HeaderText="Total Items"></asp:BoundField>
                                        <asp:BoundField DataField="TotalQty" HeaderText="Total QTY"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                            <div id="divTabPanel_Barcode" runat="server" class="col-md-12">
                                <div class="col-md-4">
                                    <asp:Panel runat="server" ID="pnlComplete" Height="30px" HorizontalAlign="Center">
                                        <asp:Button Text="Asset Creation" ID="tabPendingBarcode" CssClass="Clicked" runat="server" />
                                    </asp:Panel>
                                </div>
                            </div>
                            <div id="divgvPendingBarcode" runat="server" class="col-md-12">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="Server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvPendingBarcode" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
                                            <EmptyDataTemplate>
                                                <asp:Label ID="Label2" runat="server" Text="No Records Found"></asp:Label>
                                            </EmptyDataTemplate>
                                            <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                                            <RowStyle CssClass="pshro_GridDgnStyle" />
                                            <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                                NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
                                            <PagerStyle CssClass="pshro_text" />
                                            <Columns>
                                                        <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images/delete.png" OnClientClick="return fncdelete(this)" OnClick="imgbtnDelete_Click1"
                                        CommandName="Select" ToolTip="Click here to Delete" />
                                </ItemTemplate>
                                  </asp:TemplateField>
                                                <asp:BoundField DataField="id" HeaderText="id" HeaderStyle-CssClass="hiddencol"  ItemStyle-CssClass="hiddencol"></asp:BoundField>
                                                <asp:BoundField DataField="Sno" HeaderText="S.NO"></asp:BoundField>
                                                <asp:BoundField DataField="GRNno" HeaderText="GRN NO"></asp:BoundField>
                                                <asp:BoundField DataField="GRNDate" HeaderText="GRN Date"></asp:BoundField>
                                                <asp:BoundField DataField="Vendor" HeaderText="Vendor"></asp:BoundField>
                                                <asp:BoundField DataField="AssetName" HeaderText="AssetName"></asp:BoundField>
                                                <asp:BoundField DataField="BrandName" HeaderText="BrandName"></asp:BoundField>
                                                <asp:BoundField DataField="QTY" HeaderText="QTY"></asp:BoundField>
                                                <asp:BoundField DataField="Price" HeaderText="Price"></asp:BoundField>
                                                <asp:BoundField DataField="Purchasedate" HeaderText="Purchasedate"></asp:BoundField>
                                                <asp:BoundField DataField="Department" HeaderText="Department"></asp:BoundField>
                                                <asp:BoundField DataField="Category" HeaderText="Category"></asp:BoundField>
                                                <asp:BoundField DataField="Location" HeaderText="Location"></asp:BoundField>
                                                <asp:BoundField DataField="SubCategory" HeaderText="SubCategory"></asp:BoundField>
                                                <asp:BoundField DataField="Class" HeaderText="Class"></asp:BoundField>
                                                <asp:BoundField DataField="Block" HeaderText="Block"></asp:BoundField>
                                                <asp:BoundField DataField="Status" HeaderText="Status"></asp:BoundField>
                                                <asp:BoundField DataField="Floor" HeaderText="Floor"></asp:BoundField>
                                                <asp:BoundField DataField="Room" HeaderText="Room"></asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                            <div id="divgvCompleteGrn" runat="server" class="col-md-12">
                                <div class="col-md-4">


                                    <asp:Panel runat="server" ID="Panel1" Height="30px" HorizontalAlign="Center">
                                        <asp:Button Width="225px" Text="Complete GRN Asset Details" ID="Button3" CssClass="Clicked" runat="server" />
                                    </asp:Panel>
                                </div>
                            </div>
                            <div id="divgvCompleteView" runat="server" class="col-md-12">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="Server">
                                    <ContentTemplate>
                                        <asp:GridView ID="gvCompleteGRNView" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
                                            <EmptyDataTemplate>
                                                <asp:Label ID="Label2" runat="server" Text="No Records Found"></asp:Label>
                                            </EmptyDataTemplate>
                                            <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                                            <RowStyle CssClass="pshro_GridDgnStyle" />
                                            <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                                            <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                                NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
                                            <PagerStyle CssClass="pshro_text" />
                                            <Columns>
                                                <asp:BoundField DataField="Sno" HeaderText="S.NO"></asp:BoundField>
                                                <asp:BoundField DataField="AssetCode" HeaderText="Asset Code"></asp:BoundField>
                                                <asp:BoundField DataField="GRNno" HeaderText="GRN NO"></asp:BoundField>
                                                <asp:BoundField DataField="GRNDate" HeaderText="GRN Date"></asp:BoundField>
                                                <asp:BoundField DataField="Vendor" HeaderText="Vendor"></asp:BoundField>
                                                <asp:BoundField DataField="AssetName" HeaderText="AssetName"></asp:BoundField>
                                                <%--<asp:BoundField DataField="BrandName" HeaderText="BrandName"></asp:BoundField>--%>
                                                <asp:BoundField DataField="Price" HeaderText="Price"></asp:BoundField>
                                                <asp:BoundField DataField="Purchasedate" HeaderText="Purchasedate"></asp:BoundField>
                                                <asp:BoundField DataField="Department" HeaderText="Department"></asp:BoundField>
                                                <asp:BoundField DataField="Category" HeaderText="Category"></asp:BoundField>
                                                <asp:BoundField DataField="Location" HeaderText="Location"></asp:BoundField>
                                                <asp:BoundField DataField="SubCategory" HeaderText="SubCategory"></asp:BoundField>
                                                <asp:BoundField DataField="Class" HeaderText="Class"></asp:BoundField>
                                                <asp:BoundField DataField="Block" HeaderText="Block"></asp:BoundField>
                                                <asp:BoundField DataField="Status" HeaderText="Status"></asp:BoundField>
                                                <asp:BoundField DataField="Floor" HeaderText="Floor"></asp:BoundField>
                                                <asp:BoundField DataField="Room" HeaderText="Room"></asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                            <div id="divback" runat="server">
                                <asp:Button Text="Back" OnClick="Btnback_Click" Style="float: right; background-color: darkorange" ID="Button1" runat="server" class="Icon-Btn" />
                            </div>
                            <div id="divback1" runat="server">
                                <asp:Button Text="Back" OnClick="Btnback1_Click" Style="float: right; background-color: darkorange" ID="Button4" runat="server" class="Icon-Btn" />
                            </div>
                            <div id="divCreate" runat="server">
                                <asp:Button Text="Create" OnClick="ButtonCreate_Click" Style="float: right; background-color: darkgreen" ID="Button2" runat="server" class="Icon-Btn" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <asp:HiddenField ID="hdGRNno" runat="server" Value="" />
            <asp:HiddenField ID="hdnVendor" runat="server" Value="" />
            <asp:HiddenField ID="hdlblInvDetails" runat="server" Value="" />
            <asp:HiddenField ID="hdnGRN" runat="server" Value="" />
            <asp:HiddenField ID="hdid" runat="server" Value="" />
              <div class="hiddencol">

                    <asp:Button ID="btnDelete" runat="server" />

                </div>
          
     <%--<asp:Button ID="hiddelete" runat="server" OnClick="hiddelete_Click"  HeaderStyle-CssClass="hiddencol"  ItemStyle-CssClass="hiddencol" />--%>     </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
