<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmDCReport.aspx.cs" Inherits="AssetMobileApplication.DeliveryChallan.frmDCReport" %>

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
        function fncCancel() {
            window.location = "../DeliveryChallan/frmDCReport.aspx";
        }
     <%--   function fncDCReportValidation() {
            var status = true;
            try {
                if ($('#<%=ddlDCType.ClientID %>').val() == '0' || $('#<%=ddlDCType.ClientID %>').val() == '--Select--') {
                    ShowPopupMessageBox('Please Select DCType');
                    status = false;
                }
                else if ($('#<%=txtFromDate.ClientID %>').val() == '' || $('#<%=txtToDate.ClientID %>').val() == '') {
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
        function fncSearchDispatchNo() {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtDispatchNo.ClientID %>').val() == '')
                    event.preventDefault();
            }
            if ($('#<%=txtDispatchNo.ClientID %>').val() != '') {
                $("[id$=txtDispatchNo]").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("frmDCReport.aspx/SearchDispatchNoForDCReport") %>',
                            data: "{ 'prefix': '" + request.term + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('|')[0],
                                        val: item.split('|')[1]
                                    }
                                }))
                            },
                            error: function (response) {
                                ShowPopupMessageBox(response.responseText);
                            },
                            failure: function (response) {
                                ShowPopupMessageBox(response.responseText);
                            }
                        });
                    },
                    select: function (event, i) {
                        $('#<%=txtDispatchNo.ClientID %>').val($.trim(i.item.val));
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
        function fncSearchAssetCode() {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtAssetCode.ClientID %>').val() == '')
                    event.preventDefault();
            }
            if ($('#<%=txtAssetCode.ClientID %>').val() != '') {
                $("[id$=txtAssetCode]").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("frmDCReport.aspx/SearchAssetCodeForDCReport") %>',
                            data: "{ 'prefix': '" + request.term + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('|')[0],
                                        val: item.split('|')[1]
                                    }
                                }))
                            },
                            error: function (response) {
                                ShowPopupMessageBox(response.responseText);
                            },
                            failure: function (response) {
                                ShowPopupMessageBox(response.responseText);
                            }
                        });
                    },
                    select: function (event, i) {
                        $('#<%=txtAssetCode.ClientID %>').val($.trim(i.item.val));
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Delivery Challan</a></li>
                <li><a href="javascript:void(0);">DC Report</a></li>
            </ol>
        </div>
        <div id="Form1" runat="server">

       
                <asp:UpdatePanel ID="UpdatePanel3" runat="Server">
                    <ContentTemplate>
                        <div class="col-md-12">
                            <div class="container-group-top">
                                <div class="control-group">
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
                                                    <asp:Label ID="Label2" runat="server" Text="To Date"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label1" runat="server" Text="Dispatch No"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:TextBox ID="txtDispatchNo" runat="server" CssClass="form-control" onkeydown="return fncSearchDispatchNo(event)"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label14" runat="server" Text="DC Type"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlDCType" runat="server" onchange="fncDCTypeChange()" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label11" runat="server" Text="Asset Code"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:TextBox ID="txtAssetCode" onkeydown="return fncSearchAssetCode(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="control-group">
                                            <div class="button-control">
                                                <asp:LinkButton ID="lnkLoad" runat="server" CssClass="btn btn-success waves-effect"  OnClick="lnkLoad_Click">Load</asp:LinkButton>
                                                <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncCancel();return false;">Cancel</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="col-md-12">
                                        <div class="control-group">
                                            <div class="col-md-6">
                                                <asp:ImageButton ID="btnExcelExport" runat="server" ImageUrl="~/images/excel.PNG" OnClick="btnExcelExport_Click" Style="margin-top: 5px" />
                                                <%--<asp:ImageButton ID="imgbtnPdfExport" runat="server" ImageUrl="~/images/pdf_icon.png" OnClick="imgbtnPdfExport_Click" Style="margin-top: 5px" />--%>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div style="height: 350px; overflow: auto;">
                                            <div class="control-group">
                                                <div id="divgvDCDetails" class="grd-scroll" runat="server">
                                                    <asp:GridView ID="gvDCDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                                                            <asp:BoundField DataField="SNo" HeaderText="S.No"></asp:BoundField>
                                                            <asp:BoundField DataField="DispatchNo" HeaderText="Dispatch No"></asp:BoundField>
                                                            <asp:BoundField DataField="DispatchDate" HeaderText="Dispatch Date"></asp:BoundField>
                                                            <asp:BoundField DataField="DispatchBy" HeaderText="Dispatch By"></asp:BoundField>
                                                            <asp:BoundField DataField="TruckNo" HeaderText="Truck No"></asp:BoundField>
                                                            <asp:BoundField DataField="DCType" HeaderText="DC Type"></asp:BoundField>
                                                            <asp:BoundField DataField="DeliveryAddress" HeaderText="Delivery Address"></asp:BoundField>
                                                            <asp:BoundField DataField="DeliveryGSTIN" HeaderText="Delivery GSTIN"></asp:BoundField>
                                                            <asp:BoundField DataField="BillAddress" HeaderText="Bill Address"></asp:BoundField>
                                                            <asp:BoundField DataField="BillGSTIN" HeaderText="BillGSTIN"></asp:BoundField>
                                                            <asp:BoundField DataField="RequestedDepartment" HeaderText="Requested Department"></asp:BoundField>
                                                            <asp:BoundField DataField="ElectronicReference" HeaderText="Electronic Reference"></asp:BoundField>
                                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks"></asp:BoundField>
                                                            <asp:BoundField DataField="AssetCode" HeaderText="Asset Code"></asp:BoundField>
                                                            <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                                        <%--    <asp:BoundField DataField="Quantity" HeaderText="Quantity"></asp:BoundField>--%>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                                <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                    <ContentTemplate>
                                                        <div id="divgvDCReturnDetails" class="grd-scroll" style="display: none" runat="server">
                                                            <asp:GridView ID="gvDCReturnDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                                                                    <asp:BoundField DataField="SNo" HeaderText="S.No"></asp:BoundField>
                                                                    <asp:BoundField DataField="DispatchNo" HeaderText="Dispatch No"></asp:BoundField>
                                                                    <asp:BoundField DataField="DispatchDate" HeaderText="Dispatch Date"></asp:BoundField>
                                                                    <asp:BoundField DataField="DispatchBy" HeaderText="Dispatch By"></asp:BoundField>
                                                                    <asp:BoundField DataField="TruckNo" HeaderText="Truck No"></asp:BoundField>
                                                                    <asp:BoundField DataField="DCType" HeaderText="DC Type"></asp:BoundField>
                                                                    <asp:BoundField DataField="DeliveryAddress" HeaderText="Delivery Address"></asp:BoundField>
                                                                    <asp:BoundField DataField="DeliveryGSTIN" HeaderText="Delivery GSTIN"></asp:BoundField>
                                                                    <asp:BoundField DataField="BillAddress" HeaderText="Bill Address"></asp:BoundField>
                                                                    <asp:BoundField DataField="BillGSTIN" HeaderText="BillGSTIN"></asp:BoundField>
                                                                    <asp:BoundField DataField="RequestedDepartment" HeaderText="Requested Department"></asp:BoundField>
                                                                    <asp:BoundField DataField="ElectronicReference" HeaderText="Electronic Reference"></asp:BoundField>
                                                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks"></asp:BoundField>
                                                                    <asp:BoundField DataField="AssetCode" HeaderText="Asset Code"></asp:BoundField>
                                                                    <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                                                    <asp:BoundField DataField="ActualQty" HeaderText="Actual Qty"></asp:BoundField>
                                                                    <asp:BoundField DataField="ReturnQty" HeaderText="Return Qty"></asp:BoundField>
                                                                    <asp:BoundField DataField="BalanceQty" HeaderText="Balance Qty"></asp:BoundField>
                                                                    <asp:BoundField DataField="ReturnDate" HeaderText="Return Date"></asp:BoundField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </div>
                                                    </ContentTemplate>
                                                                 <Triggers>
                                                       <asp:PostBackTrigger ControlID="btnExcelExport" />
                                                                   </Triggers>
                                                </asp:UpdatePanel>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>
        
        </div>
    </div>
</asp:Content>
