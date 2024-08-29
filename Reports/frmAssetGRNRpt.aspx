<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetGRNRpt.aspx.cs" Inherits="AssetMobileApplication.Reports.frmAssetGRNRpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Reports</a></li>
                <li><a href="javascript:void(0);">GRN Report</a></li>
            </ol>
        </div>
        <div class="container-group-top">
            <div class="control-group">
                <div class="col-md-12">
                    <div class="col-md-12">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="lblGRNDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="GRN Details"></asp:Label>
                                    </div>
                                </div>
                            </div>
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="col-md-6">
                                <asp:ImageButton ID="btnExcelExport" runat="server" ImageUrl="~/images/excel.PNG" OnClick="btnExcelExport_Click" Style="margin-top: 5px" />
                                <%--<asp:ImageButton ID="imgbtnPdfExport" runat="server" ImageUrl="~/images/pdf_icon.png" OnClick="imgbtnPdfExport_Click" Style="margin-top: 5px" />--%>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div style="height: 450px; overflow: auto;">
                            <asp:GridView ID="gvAssetDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                                    <asp:BoundField DataField="PoNo" HeaderText="RequestID" ItemStyle-CssClass="LAssetCode"></asp:BoundField>
                                    <asp:BoundField DataField="GRNno" HeaderText="GRN No"></asp:BoundField>
                                    <asp:BoundField DataField="GRNDate" HeaderText="GRN Date"></asp:BoundField>
                                    <asp:BoundField DataField="Name" HeaderText="Name"></asp:BoundField>
                                    <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                    <asp:BoundField DataField="BrandName" HeaderText="Brand Name"></asp:BoundField>
                                    <asp:BoundField DataField="Qty" HeaderText="Qty"></asp:BoundField>
                                    <asp:BoundField DataField="Price" HeaderText="Price"></asp:BoundField>
                                    <asp:BoundField DataField="DeliveryNote" HeaderText="Purchase Date"></asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
