<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmDCEntry.aspx.cs" Inherits="AssetMobileApplication.DeliveryChallan.frmDCEntry" %>

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
        function fncOpenDeleteDialog(source) {
            $("#dialog-confirm").dialog({
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "YES": function () {
                        $(this).dialog("close");
                        fncDeleteGridData(source);
                        return false;
                    },
                    "NO": function () {
                        $(this).dialog("close");
                        return false;
                    }
                }
            });
            return false;
        }
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtDispatchDate.ClientID %>"), $("#<%= txtDCReturnDate.ClientID %>"));
            });

            $('#<%=pdfpreview2.ClientID %>').change(function () {
                fncFileValidation1();
            })
        }
        function SetDefaultDate(DispatchDate, DCReturnDate) {
            try {
                DispatchDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                DCReturnDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, minDate: "0" });

                if (DispatchDate.val() === '') {
                    DispatchDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
                }
                if (DCReturnDate.val() === '') {
                    DCReturnDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, minDate: "0" }).datepicker("setDate", "today");
                }
            }
            catch (err) {
                ShowToastError(err.message);
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
                            url: '<%=ResolveUrl("frmDCEntry.aspx/GetAssetCodeForDCEntry") %>',
                            data: "{ 'prefix': '" + request.term + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('|')[0],
                                        val: item.split('|')[1],
                                        vendor: item.split('|')[2],
                                        price: item.split('|')[3]
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
                        $('#<%=txtAssetCode.ClientID %>').val($.trim(i.item.label));
                        $('#<%=txtAssetName.ClientID %>').val($.trim(i.item.val));
                        $('#<%=hdVendorId.ClientID %>').val($.trim(i.item.vendor));
                        $('#<%=hdPrice.ClientID %>').val($.trim(i.item.price));
                        $('#<%=txtAssetCode.ClientID %>').attr('readonly', true);
                        $('#<%=txtQty.ClientID %>').select().focus();
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
        function fncSearchAssetName() {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtAssetName.ClientID %>').val() == '')
                    event.preventDefault();
            }
            if ($('#<%=txtAssetName.ClientID %>').val() != '') {
                $("[id$=txtAssetName]").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("frmDCEntry.aspx/GetAssetNameForDCEntry") %>',
                            data: "{ 'prefix': '" + request.term + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('|')[1],
                                        val: item.split('|')[0],
                                        vendor: item.split('|')[2],
                                        price: item.split('|')[3]
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
                        $('#<%=txtAssetName.ClientID %>').val($.trim(i.item.label));
                        $('#<%=hdVendorId.ClientID %>').val($.trim(i.item.vendor));
                        $('#<%=hdPrice.ClientID %>').val($.trim(i.item.price));
                        $('#<%=txtAssetCode.ClientID %>').attr('readonly', true);
                        $('#<%=txtQty.ClientID %>').select().focus();
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
        function fncDCSaveValidation() {
            var status = true, Count = 0, Department = '', DCType = '';
            try {
                Count = $("#tblItemDetail tbody").children().length;
                Department = $('#<%=ddlDepartment.ClientID %>').val();
                DCType = $('#<%=ddlDCType.ClientID %>').val();
                if ($('#<%=txtDispatchBy.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Enter Dispatch By');
                    status = false;
                }
                else if (Department == '0' || Department == '--Select--') {
                    ShowPopupMessageBox('Please Select Department');
                    status = false;
                }
                else if (DCType == '0' || DCType == '--Select--') {
                    ShowPopupMessageBox('Please Select Block');
                    status = false;
                }
                else if ($('#<%=txtBillTo.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter Bill To');
                     status = false;
                 }
                 else if ($('#<%=txtDeliveryAt.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter Delivery At');
                     status = false;
                 }
                 else if ($('#<%=txtTruckNo.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter Truck No');
                     status = false;
                 }
                 else if ($('#<%=txtBillGSTNo.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter Bill GSTNo');
                     status = false;
                 }
                 else if ($('#<%=txtDeliveryGSTNo.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter Delivery GSTNo');
                     status = false;
                 }
                 else if ($('#<%=txtElectronicReference.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter Electronic Reference');
                     status = false;
                 }
                 else if ($('#<%=txtDCRemarks.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter DC Remarks');
                     status = false;
                 }
                 else if (Count == 0) {
                     ShowPopupMessageBox('Please Add Asset Details');
                     status = false;
                 }
                 else {
                     status = XmlGridValue($('#tblItemDetail tr'), $('#<%=hidXmlData.ClientID %>'));
                    return status;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncDCTypeChange() {
            var DCType = '';
            try {
                DCType = $('#<%=ddlDCType.ClientID %>').val();
                if (DCType == 'Returnable') {
                    //$('#<%=txtDCReturnDate.ClientID %>').attr('enable', 'true');
                    $('#<%=txtDCReturnDate.ClientID %>').removeAttr('disabled');
                }
                else {
                    //$('#<%=txtDCReturnDate.ClientID %>').attr('enable', 'false');
                    $('#<%=txtDCReturnDate.ClientID %>').attr('disabled', 'disabled');
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncAddAssetDetails() {
            var tblBody, row, rowId, cost = 0, count = 0, TotalValue = 0;
            try {
                if (fncAddAssetDetailValidation()) {
                    $('#tblItemDetail tbody').children().each(function () {
                        objtbl = $(this);
                        if (objtbl.length > 0) {

                            if ($(this).find("td").eq(1).html() == $('#<%=txtAssetCode.ClientID %>').val()) {
                                count = count + 1;
                                $(this).css('background', 'red');
                                //#008000
                                $(this).css('color', 'white');
                            }
                        }
                    });
                    if (count > 0) {
                        ShowPopupMessageBox('Asset Already Added..!');
                    }
                    else {
                        TotalValue = parseFloat($('#<%=txtQty.ClientID %>').val()) * parseFloat($('#<%=hdPrice.ClientID %>').val());
                        rowId = $("#tblItemDetail tr").length;
                        tblBody = $("#tblItemDetail tbody");
                        row = "<tr id='trtblItemDetail_" + rowId + "' tabindex='" + rowId + "' >"
                            + "<td id='tdSNo' >" + rowId + "</td>"
                            + "<td id='tdAssetCode' >" + $('#<%=txtAssetCode.ClientID %>').val() + "</td>"
                            + "<td id='tdAssetName'>" + $('#<%=txtAssetName.ClientID %>').val() + "</td>"
                            + "<td id='tdQty' >" + $('#<%=txtQty.ClientID %>').val() + "</td>"
                            + "<td id='tdTotalValue' >" + TotalValue.toFixed(2) + "</td>"
                            + "<td><img src='../images/delete.png' onclick = 'fncOpenDeleteDialog(this);return false;'/></td>"
                            + "</tr>";
                        tblBody.append(row);
                        //fncClearDetailTextBoxes();
                    }
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncAddAssetDetailValidation() {
            var status = true;
            try {
                if ($('#<%=txtAssetCode.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Enter Asset Code');
                    status = false;
                }
                else if ($('#<%=txtAssetName.ClientID %>').val() == '') {
                     ShowPopupMessageBox('Please Enter Asset Name');
                     status = false;
                 }
                 else if ($('#<%=txtQty.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Enter Qty');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
      <%--  function fncClearDetailTextBoxes() {
            try {
                $('#<%=txtAssetCode.ClientID %>').attr('readonly', false);
                $('#<%=txtAssetCode.ClientID %>').val('');
                $('#<%=txtAssetName.ClientID %>').val('');
                $('#<%=txtQty.ClientID %>').val('');
                $('#<%=ddlDepartment.ClientID %>').val('');
                $('#<%=ddlDepartment.ClientID %>').trigger("liszt:updated");
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }--%>

        function fncclearForm() {
            window.location = "../DeliveryChallan/frmDCEntry.aspx";
        }


        function fncDeleteGridData(source) {
            var rowNo = 1;
            try {
                $(source).closest("tr").remove();
                $("#tblItemDetail tbody").children().each(function () {
                    $(this).find('td:eq(0)').html(rowNo)
                    rowNo = rowNo + 1;
                });
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function XmlGridValue(tableid, XmlID) {
            try {

                var xml = '<NewDataSet>';

                // $('#grdAttribute tr').each(function () {
                tableid.each(function () {
                    var cells = $("td", this);
                    if (cells.length > 0) {

                        xml += "<Table>";
                        for (var j = 0; j < cells.length; ++j) {

                            xml += '<' + $(this).parents('table:first').find('th').eq(j).text().trim() + '>' + cells.eq(j).text().trim() + '</' + $(this).parents('table:first').find('th').eq(j).text().trim() + '>';

                        }
                        xml += "</Table>";
                    }
                });

                xml = xml + '</NewDataSet>'
                XmlID.val(escape(xml));
                return true;
            }
            catch (err) {
                return false;
                fncToastInformation(err.Message);
            }
        }

        function showpreview2(input) {
            try {
                fncFileValidation1(input);
                var maxsize = 2000 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=pdfpreview2.ClientID %>').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0])
                }
                else {
                    input.value = "";
                    ShowToastError('File size exceeds 2 MB');
                    //alert('file size: ' + input.files[0].size);
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }

        function fncFileValidation1(input) {

            $('#<%=pdfpreview2.ClientID %>').on('change', function (e) {
                e.preventDefault();

                // Get the selected file
                var selectedFile = input.files[0];

                // Check if a file is selected
                if (selectedFile) {
                    // Check the file extension
                    var fileExtension = selectedFile.name.split('.').pop().toLowerCase();

                    if (fileExtension === 'xlsx' || fileExtension === 'pdf') {
                        // Valid file type
                        // You can proceed with form submission or any other action
                        //ShowToastError('Valid file selected: ' + selectedFile.name);
                        // Uncomment the line below to submit the form
                        // $('#fileForm').submit();
                    } else {
                        // Invalid file type
                        input.value = "";
                        ShowToastError('Invalid file type. Please select an XLSX or PDF file.');
                    }
                } else {
                    // No file selected
                    ShowToastError('No file selected.');
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Delivery Challan</a></li>
                <li><a href="javascript:void(0);">DC Entry</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="container-group-top">
                            <%--<div class="col-md-12">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="lblDCHeader" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="DC Header"></asp:Label>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label1" runat="server" Text="Dispatch No"></asp:Label> <span class="mandatory">*</span>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDispatchNo" runat="server" CssClass="form-control"></asp:TextBox>
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
                                            <asp:Label ID="Label16" runat="server" Text="DC Return Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDCReturnDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">

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
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label5" runat="server" Text="Truck No"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtTruckNo" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label8" runat="server" Text="Bill GST No"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtBillGSTNo" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label9" runat="server" Text="Delivery GST No"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDeliveryGSTNo" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label10" runat="server" Text="Remarks"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="container-group-top">
                                <%--<div class="col-md-12">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="lblDCDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="DC Details"></asp:Label>
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="col-md-12">
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label11" runat="server" Text="Asset Code"></asp:Label> <span class="mandatory">*</span>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtAssetCode" onkeydown="return fncSearchAssetCode(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label12" runat="server" Text="Asset Name"></asp:Label> <span class="mandatory">*</span>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtAssetName" onkeydown="return fncSearchAssetName(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label13" runat="server" Text="Qty"></asp:Label> <span class="mandatory">*</span>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtQty" runat="server" type="tel" onkeypress="return fncAllowOnlyNumbers(event)" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>                              

                                </div>
                                <div class="col-md-12">
                                    <div class="control-group">
                                        <div class="button-control">
                                            <asp:LinkButton ID="lnkAddDCDetails" runat="server" OnClientClick=" fncAddAssetDetails();return false;" CssClass="btn btn-success waves-effect">Add</asp:LinkButton>
                                            <asp:LinkButton ID="lnkClear" runat="server" OnClientClick="fncclearForm();return false;" CssClass="btn btn-warning waves-effect">Clear</asp:LinkButton>
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
                                                    <th scope="col">AssetCode
                                                    </th>
                                                    <th scope="col">AssetName
                                                    </th>
                                                    <th scope="col">Qty
                                                    </th>
                                                    <th scope="col">Value
                                                    </th>
                                                    <th scope="col">Delete
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
                            <div class="container-group-top">
                                <div class="col-md-12">
                                    <div class="col-md-6">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label2" runat="server" Text="Electronic Reference"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtElectronicReference" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label17" runat="server" Text="DC Remarks"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtDCRemarks" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                             <div class="col-md-6">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label19" runat="server" Text="Document"></asp:Label>
                                        </div>                                       
                                    </div>
                                </div>
                                      <div class="col-md-6">
                                   <div class="control-right" >
                                    <asp:Panel runat="server" ID="Panel4" HorizontalAlign="Center">

                                        <asp:UpdatePanel ID="pdfpreview2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <Triggers>
                                                <asp:PostBackTrigger ControlID="lnkSave" />
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:FileUpload Style="float: right; margin-right: 372px;margin-top:4px" accept=".pdf,.xlsx" ID="FileUpload1" runat="server" onchange="showpreview2(this);" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>

                                </div>
                                          </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="control-group">
                                <div class="button-control">
                                    <asp:LinkButton ID="lnkSave" runat="server" OnClientClick="return fncDCSaveValidation();" OnClick="lnkSave_Click" CssClass="btn btn-success waves-effect">Save</asp:LinkButton>
                                    <asp:LinkButton ID="lnkDCCancel" runat="server" OnClick="lnkDCCancel_Click" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="dialog-confirm" style="display: none;">
        <asp:Label ID="Label18" runat="server" Text="Do You Want to Delete?"></asp:Label>
    </div>
    <asp:HiddenField ID="hidXmlData" runat="server" Value="" />
    <asp:HiddenField ID="hdVendorId" runat="server" Value="0" />
    <asp:HiddenField ID="hdPrice" runat="server" Value="0" />
</asp:Content>
