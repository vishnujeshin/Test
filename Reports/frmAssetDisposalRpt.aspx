<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetDisposalRpt.aspx.cs" Inherits="AssetMobileApplication.Reports.frmAssetDisposalRpt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtFromDate.ClientID %>"), $("#<%= txtToDate.ClientID %>"));
            });
        }
        function SetDefaultDate(FromDate, ToDate) {
            try {
                FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });

                if (FromDate.val() === '') {
                    FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                }
                if (ToDate.val() === '') {
                    ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
       <%-- function fncAssetDisposalValidation() {
            var status = true;
            try {
                if ($('#<%=txtFromDate.ClientID %>').val() == '' || $('#<%=txtToDate.ClientID %>').val() == '')
                {
                    ShowPopupMessageBox('Please Select Date');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }--%>
        function fncCancel() {
            window.location = "../Reports/frmAssetDisposalRpt.aspx";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Reports</a></li>
                <li><a href="javascript:void(0);">Asset Disposal Report</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="container-group-top border-style">
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label13" runat="server" Text="From Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label1" runat="server" Text="To Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label14" runat="server" Text="Location"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label15" runat="server" Text="Department"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label17" runat="server" Text="Block Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlBlockName" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label18" runat="server" Text="Floor Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlFloorName" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label19" runat="server" Text="Room"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label20" runat="server" Text="Cubical"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlCubical" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label16" runat="server" Text="Employee"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="button-control">
                                        <asp:LinkButton ID="lnkLoad" runat="server" OnClientClick="return fncAssetDisposalValidation();" OnClick="lnkLoad_Click" CssClass="btn btn-success waves-effect">Load</asp:LinkButton>
                                        <asp:LinkButton ID="lnkCancel" runat="server" OnClientClick="fncCancel();return false;" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <div class="control-group">
                                <div class="col-md-6">
                                    <asp:ImageButton ID="btnExcelExport" runat="server" ImageUrl="~/images/excel.PNG" OnClick="btnExcelExport_Click" Style="margin-top: 5px" />
                                    <%--<asp:ImageButton ID="imgbtnPdfExport" runat="server" ImageUrl="~/images/pdf_icon.png" OnClick="imgbtnPdfExport_Click" Style="margin-top: 5px" />--%>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div style="height: 250px; overflow: auto;">
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
                                        <asp:BoundField DataField="AssetCode" HeaderText="Asset Code" ItemStyle-CssClass="LAssetCode"></asp:BoundField>
                                        <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                        <asp:BoundField DataField="DisposedPrice" HeaderText="Disposed Price"></asp:BoundField>
                                        <asp:BoundField DataField="DisposedDate" HeaderText="Disposed Date"></asp:BoundField>
                                        <asp:BoundField DataField="DispossedBy" HeaderText="Dispossed By"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
