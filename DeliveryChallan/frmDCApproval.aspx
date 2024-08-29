<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmDCApproval.aspx.cs" Inherits="AssetMobileApplication.DeliveryChallan.frmDCApproval" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #tblItemDetail {
            font-family: "bebas_neuebold";
            border-collapse: collapse;
            width: 100%;
        }

            #tblItemDetail td, #tblItemDetail th {
                border: 1px solid #3F51B5;
                border-bottom: 1px solid #3F51B5;
                padding: 4px;
                text-align: center;
                font-size: 12px;
            }

            #tblItemDetail tr:nth-child(even) {
                background-color: white;
            }

            #tblItemDetail tr:hover {
                background-color: white;
            }

            #tblItemDetail th {
                padding-top: 4px;
                padding-bottom: 4px;
                text-align: center;
                background-color: #3e4095;
                font-weight: bolder;
                color: white;
            }
    </style>
    <script type="text/javascript">
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
                            url: '<%=ResolveUrl("frmDCApproval.aspx/SearchDispatchNoForDCApproval") %>',
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
                        $('#<%=txtDispatchNo.ClientID %>').attr('readonly', true);
                        fncGetDispatchDetails();
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
        function fncClearTextBoxes() {
            try {
                window.location = "../DeliveryChallan/frmDCApproval.aspx";
                $('#<%=txtDispatchNo.ClientID %>').val('');
                $('#<%=txtDispatchDate.ClientID %>').val('');
                $('#<%=txtDispatchBy.ClientID %>').val('');
                $('#<%=txtDCType.ClientID %>').val('');
                $('#<%=txtBillTo.ClientID %>').val('');
                $('#<%=txtDeliveryAt.ClientID %>').val('');
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncGetDispatchDetails()
        {
            var obj = {}, DispatchNo = '';
            try {
                DispatchNo = $('#<%=txtDispatchNo.ClientID %>').val();
                obj.DispatchNo = DispatchNo;
                $.ajax({
                        type: "POST",
                        url: '<%=ResolveUrl("frmDCApproval.aspx/fncGetDetailsForDCApproval") %>',
                        data: JSON.stringify(obj),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            if (msg.d != '') {
                                var ds = jQuery.parseJSON(msg.d);
                                fncBindDispatchHeaderData(ds.Table);
                                fncBindDispatchDetails(ds.Table1);
                            }
                            else {
                                ShowToastError('Invalid Dispatch Number...!');
                            }

                        },
                        error: function (data) {
                            ShowPopupMessageBox(data.message);
                        }
                    });
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncBindDispatchHeaderData(data)
        {
            try {
                $('#<%=txtDispatchNo.ClientID %>').val(data[0]["DispatchNo"].replace(/&nbsp;/g, ''));
                $('#<%=txtDispatchDate.ClientID %>').val(data[0]["DispatchDate"]);
                $('#<%=txtDispatchBy.ClientID %>').val(data[0]["DispatchBy"].replace(/&nbsp;/g, ''));
                $('#<%=txtDCType.ClientID %>').val(data[0]["DCType"].replace(/&nbsp;/g, ''));
                $('#<%=txtBillTo.ClientID %>').val(data[0]["BillAddress"].replace(/&nbsp;/g, ''));
                $('#<%=txtDeliveryAt.ClientID %>').val(data[0]["DeliveryAddress"].replace(/&nbsp;/g, ''));
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncBindDispatchDetails(data) {
            var row, rowId, tblBody;
            try {
                tblBody = $("#tblItemDetail tbody");
                tblBody.empty();
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        rowId = i + 1;
                        row = "<tr id='tblItemDetail" + rowId + "' tabindex='" + rowId + "' >"
                               + "<td id='tdSNo' >" + rowId + "</td>"
                               + "<td id='tdPartNo' >" + data[i]["PartNo"] + "</td>"
                               + "<td id='tdPartName'>" + data[i]["PartName"] + "</td>"
                               + "<td id='tdQuantity' >" + data[i]["Quantity"] + "</td>"
                               + "<td id='tdValue' >" + data[i]["Value"] + "</td>"
                               + "</tr>";
                        tblBody.append(row);
                    }

                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncDCApprovalValidation() {
            var status = true, Count = 0;
            try {
                Count = $("#tblItemDetail tbody").children().length;
                if ($('#<%=txtDispatchNo.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Dispatch Number should not be Empty..!');
                    status = false;
                }
                else if (Count == 0) {
                    ShowPopupMessageBox('There is no data for Approval..!');
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
                <li><a href="javascript:void(0);">Delivery Challan</a></li>
                <li><a href="javascript:void(0);">DC Approval</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="container-group-top">
                            <div class="col-md-12">
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
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label3" runat="server" Text="Dispatch Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDispatchDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label4" runat="server" Text="Dispatch By"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDispatchBy" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label5" runat="server" Text="DC Type"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDCType" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label6" runat="server" Text="Bill To"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtBillTo" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label7" runat="server" Text="Delivery At"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDeliveryAt" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                            <div class="col-md-12">
                                    <div class="control-group">
                                        <div class="button-control">
                                            <asp:LinkButton ID="lnkClear" runat="server" OnClientClick="fncClearTextBoxes();return false;" CssClass="btn btn-warning waves-effect">Clear</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12" runat="server">
                                    <div style="height: 200px; overflow: auto;">
                                        <table id="tblItemDetail" cellspacing="0" rules="all" border="1">
                                            <thead>
                                                <tr>
                                                    <th scope="col">S.No
                                                    </th>
                                                    <th scope="col">PartCode
                                                    </th>
                                                    <th scope="col">PartName
                                                    </th>
                                                    <th scope="col">Qty
                                                    </th>
                                                    <th scope="col">Value
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                            <tfoot>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <div class="col-md-12">
                            <div class="control-group">
                                <div class="button-control">
                                    <asp:LinkButton ID="lnkDCApprove" runat="server" OnClientClick="return fncDCApprovalValidation();" OnClick="lnkDCApprove_Click" CssClass="btn btn-success waves-effect">Approve</asp:LinkButton>
                                    <asp:LinkButton ID="lnkDCReject" runat="server" OnClientClick="return fncDCApprovalValidation();" OnClick="lnkDCReject_Click" CssClass="btn btn-warning waves-effect">Reject</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>
