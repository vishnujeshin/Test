<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetDetailsRpt.aspx.cs" Inherits="AssetMobileApplication.Reports.frmAssetDetailsRpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Src="~/UserControls/PaginationUserControls.ascx" TagName="PaginationUserControl" TagPrefix="ups" %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Reports</a></li>
                <li><a href="javascript:void(0);">Asset Details</a></li>
            </ol>
        </div>
        <div class="container-group-top">
            <div class="col-md-12">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label3" runat="server" Text="Department"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlDepartment" onchange="" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label4" runat="server" Text="Category"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label6" runat="server" Text="SubCategory"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label5" runat="server" Text="Location"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label7" runat="server" Text="Class"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label8" runat="server" Text="Employee"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label9" runat="server" Text="Brand"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label10" runat="server" Text="Vendor"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="button-control">
                <asp:LinkButton ID="lnkReport" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkReport_Click" OnClientClick="return ValidateForm()">Show Report</asp:LinkButton>
                <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClick="lnkClear_Click" >Clear</asp:LinkButton>
            </div>
        </div>
        <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                <ContentTemplate>
                    <asp:GridView ID="gvAssetDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="True">
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
                            <asp:BoundField DataField="RowNumber" HeaderText="S.No"></asp:BoundField>
                            <asp:BoundField DataField="AssetCode" HeaderText="Asset Code"></asp:BoundField>
                            <asp:BoundField DataField="Description" HeaderText="Description"></asp:BoundField>
                            <asp:BoundField DataField="Model" HeaderText="Model"></asp:BoundField>
                            <asp:BoundField DataField="SerialNo" HeaderText="Serial No"></asp:BoundField>
                            <asp:BoundField DataField="WarrantyStartDate" HeaderText="Warranty Start Date"></asp:BoundField>
                            <asp:BoundField DataField="WarrantyEndDate" HeaderText="Warranty End Date"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <ups:PaginationUserControl runat="server" ID="AssetDetailsPagination" OnPaginationButtonClick="AssetDetails_PaginationButtonClick" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
