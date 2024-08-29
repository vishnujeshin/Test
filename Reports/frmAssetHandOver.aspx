<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetHandOver.aspx.cs" Inherits="AssetMobileApplication.Reports.frmAssetHandOver" %>

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
        function fncAssetAuditValidation() {
            var status = true<%--, Employee = '', AssetCode='';
            try {
                AssetCode = $('#<%=ddlAssetCode.ClientID %>').val();
                Employee = $('#<%=ddlEmployee.ClientID %>').val();
                if ($('#<%=txtFromDate.ClientID %>').val() == '' || $('#<%=txtToDate.ClientID %>').val() == '')
                {
                    ShowPopupMessageBox('Please Select Date');
                    status = false;
                }
               else if (AssetCode == '0' || AssetCode == '--Select--') {
                   ShowPopupMessageBox('Please Select AssetCode');
                    status = false;
                }
                else if (Employee == '0' || Employee == '--Select--') {
                    ShowPopupMessageBox('Please Select Employee');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }--%>
            return status;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Reports</a></li>
                <li><a href="javascript:void(0);">Asset Handover</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="container-group-top border-style">
                            <div class="col-md-12">
                                <div class="col-md-6">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label2" runat="server" Text="Asset Code"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlAssetCode" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
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
                                <div class="col-md-6">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label13" runat="server" Text="From Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label1" runat="server" Text="To Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="button-control">
                                        <asp:LinkButton ID="lnkLoad" runat="server" OnClientClick="return fncAssetAuditValidation();" OnClick="lnkLoad_Click" CssClass="btn btn-success waves-effect">Load</asp:LinkButton>
                                        <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
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
                                        <asp:BoundField DataField="AssetCode" HeaderText="AssetCode"></asp:BoundField>
                                        <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName"></asp:BoundField>
                                        <asp:BoundField DataField="HandOverDate" HeaderText="HandOverDate" ItemStyle-CssClass="LAssetCode"></asp:BoundField>
                                        <asp:BoundField DataField="BrandId" HeaderText="Brand Id"></asp:BoundField>
                                        <asp:BoundField DataField="Model" HeaderText="Model"></asp:BoundField>
                                        <asp:BoundField DataField="SerialNo" HeaderText="Serial No"></asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Status"></asp:BoundField>
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
