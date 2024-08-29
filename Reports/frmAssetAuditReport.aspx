<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetAuditReport.aspx.cs" Inherits="AssetMobileApplication.Reports.frmAssetAuditReport" %>

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
                    FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
                }
                if (ToDate.val() === '') {
                    ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncAssetAuditValidation() {
            var status = true, Location = '', Department = '', Block = '', Floor = '',
                Room = '', Cubical = '', Employee = '';
            try {
             <%--<%-- <%--  Location = $('#<%=ddlLocation.ClientID %>').val();
                Department = $('#<%=ddlDepartment.ClientID %>').val();
                Block = $('#<%=ddlBlockName.ClientID %>').val();
                Floor = $('#<%=ddlFloorName.ClientID %>').val();
                Room = $('#<%=ddlRoom.ClientID %>').val();
                Cubical = $('#<%=ddlCubical.ClientID %>').val();--%>
                <%--Employee = $('#<%=ddlEmployee.ClientID %>').val();--%>
                if ($('#<%=txtFromDate.ClientID %>').val() == '' || $('#<%=txtToDate.ClientID %>').val() == '')
                {
                    ShowPopupMessageBox('Please Select Date');
                    status = false;
                }
               else if (Location == '0' || Location == '--Select--') {
                    ShowPopupMessageBox('Please Select Location');
                    status = false;
                }
                else if (Department == '0' || Department == '--Select--') {
                    ShowPopupMessageBox('Please Select Department');
                    status = false;
                }
                else if (Block == '0' || Block == '--Select--') {
                    ShowPopupMessageBox('Please Select Block');
                    status = false;
                }
                else if (Floor == '0' || Floor == '--Select--') {
                    ShowPopupMessageBox('Please Select Floor');
                    status = false;
                }
                else if (Room == '0' || Room == '--Select--') {
                    ShowPopupMessageBox('Please Select Room');
                    status = false;
                }
                else if (Cubical == '0' || Cubical == '--Select--') {
                    ShowPopupMessageBox('Please Select Cubical');
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
            }
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
                <li><a href="javascript:void(0);">Asset Audit Report</a></li>
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
                                            <asp:Label ID="lblMethod" runat="server" Text="Method"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlMethod" runat="server" CssClass="form-control">
                                           <asp:listitem>--Select--</asp:listitem>                                           
                                          <asp:listitem>Assigned</asp:listitem>  
                                          <asp:listitem>UnAssigned</asp:listitem>  
                                            </asp:DropDownList>
                                                                
                              <div class="col-md-4" style="display:none">
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
                            <div class="col-md-12" style="display:none">
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
                            <div class="col-md-12" style="display:none">
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
                                </div>
                            </div>
                            <div class="col-md-4" >
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="lblAuditCode" runat="server" Text="AuditId"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlAuditCode" runat="server" CssClass="form-control"></asp:DropDownList>
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
                                        <asp:BoundField DataField="AssetCode" HeaderText="Asset Code" ItemStyle-CssClass="LAssetCode"></asp:BoundField>
                                   <%--     <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>--%>
                                        <%--<asp:BoundField DataField="StatusName" HeaderText="Asset Status"></asp:BoundField>--%>
                                        <asp:BoundField DataField="AuditId" HeaderText="AuditId"></asp:BoundField>
                                        <asp:BoundField DataField="Department" HeaderText="Department"></asp:BoundField>
                                        <asp:BoundField DataField="Employee" HeaderText="Employee"></asp:BoundField>
                                        <asp:BoundField DataField="location" HeaderText="Location"></asp:BoundField>
                                        <asp:BoundField DataField="block" HeaderText="Block"></asp:BoundField>
                                        <asp:BoundField DataField="floor" HeaderText="Floor"></asp:BoundField>
                                        <asp:BoundField DataField="Room" HeaderText="Room"></asp:BoundField>
                                        <asp:BoundField DataField="Cubical" HeaderText="Cubical"></asp:BoundField>
                                        <asp:BoundField DataField="AuditedBy" HeaderText="Audited By"></asp:BoundField>
                                        <asp:BoundField DataField="AuditedDate" HeaderText="Audited Date"></asp:BoundField>
                                        <asp:BoundField DataField="Remark" HeaderText="Remark"></asp:BoundField>
                                        <asp:BoundField DataField="Method" HeaderText="Method"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div>
</asp:Content>
