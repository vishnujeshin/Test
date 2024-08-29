<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmDCReturn.aspx.cs" Inherits="AssetMobileApplication.DeliveryChallan.frmDCReturn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .Icon-Btn {
    background-color: DodgerBlue;
    color: white;
    padding: 3px 8px;
    font-size: 16px;
    cursor: pointer;
    background-image: none;
    border: 1px solid #ccc !important;
    border-radius: 4px !important;
    font-weight: normal;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
}
    </style>
    <script type="text/javascript">
        function pageLoad() {
            $('#<%=pdfpreview2.ClientID %>').change(function () {
                fncFileValidation1();
            })
        }
        function fncSearchDCNo() {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtDCNo.ClientID %>').val() == '')
                    event.preventDefault();
            }
            if ($('#<%=txtDCNo.ClientID %>').val() != '') {
                $("[id$=txtDCNo]").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("frmDCReturn.aspx/fncSearchDispatchNoforDCReturn") %>',
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
                        $('#<%=txtDCNo.ClientID %>').val($.trim(i.item.val));
                        $('#<%=txtDCNo.ClientID %>').attr('readonly', true);
                        $("#<%=btnFetchDCReturnDetails.ClientID%>").click();
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
        function fncBindDCReturnDetails(source) {
            var row;
            try {
                row = $(source).closest("tr");
                $('#<%=txtReturnDispatchNo.ClientID %>').attr('readonly', true);
                $('#<%=txtReturnDispatchNo.ClientID %>').val($("td", row).eq(1).html().replace(/&nbsp;/g, ''));
                $('#<%=txtAssetCode.ClientID %>').attr('readonly', true);
                $('#<%=txtAssetCode.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
                $('#<%=txtAssetName.ClientID %>').attr('readonly', true);
                $('#<%=txtAssetName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
                $('#<%=txtActualQty.ClientID %>').attr('readonly', true);
                $('#<%=txtActualQty.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                $('#<%=txtBalanceQty.ClientID %>').attr('readonly', true);
                $('#<%=txtBalanceQty.ClientID %>').val($("td", row).eq(6).html().replace(/&nbsp;/g, ''));
                $('#<%=txtReturnQty.ClientID %>').select().focus();
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncDCReturnVAlidation() {
            var status = true;
            try {
                if ($('#<%=txtReturnDispatchNo.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Dispatch No should not be empty.');
                    status = false;
                }
                else if ($('#<%=txtReturnQty.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Enter Return Qty.');
                    status = false;
                }
                else {
                    status = fncDCReturnQtyValidation();
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncDCReturnQtyValidation()
        {
            var status = true, ActualQty = 0, BalanceQty = 0, ReturnQty = 0;
            try
            {
                if ($('#<%=txtActualQty.ClientID %>').val() != '' && $('#<%=txtBalanceQty.ClientID %>').val() != '') {
                    ActualQty = parseFloat($('#<%=txtActualQty.ClientID %>').val())
                    BalanceQty = parseFloat($('#<%=txtBalanceQty.ClientID %>').val());
                    ReturnQty = parseFloat($('#<%=txtReturnQty.ClientID %>').val());
                    if (ReturnQty > ActualQty || ReturnQty > BalanceQty) {
                        ShowPopupMessageBox('Return Qty should not be Greater than to Actual or Balance Qty');
                        status = false;
                    }
                    else {
                        status = true;
                    }
                }
                else {
                    ShowPopupMessageBox('Invalid Process Flow..!');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status; 
        }
        function fncClear() {
            window.location = "../DeliveryChallan/frmDCReturn.aspx";
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
                <li><a href="javascript:void(0);">DC Return</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label1" runat="server" Text="DC No"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtDCNo" onkeydown="return fncSearchDCNo(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:Button Text="" Style="display: none;" OnClick="btnFetchDCReturnDetails_Click" ID="btnFetchDCReturnDetails" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="control-group">
                                <div class="button-control" style="float: left !important; margin: 0px !important; padding-left: 2px !important">
                                    <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncClear();return false;">Clear</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div style="height: 250px; overflow: auto;">
                        <div class="control-group">
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
                                    <asp:TemplateField HeaderText="Go">
                                        <ItemTemplate>
                                            <asp:Button Text="Go" OnClientClick="fncBindDCReturnDetails(this);return false;" ID="gvbtnGo" runat="server" class="Icon-Btn" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="DispatchNo" HeaderText="Dispatch No"></asp:BoundField>
                                    <asp:BoundField DataField="PartNo" HeaderText="Asset Code"></asp:BoundField>
                                    <asp:BoundField DataField="PartName" HeaderText="Asset Name"></asp:BoundField>
                                    <asp:BoundField DataField="ActualQty" HeaderText="Actual Qty"></asp:BoundField>
                                    <asp:BoundField DataField="ReturnQty" HeaderText="Returnd Qty"></asp:BoundField>
                                    <asp:BoundField DataField="BalanceQty" HeaderText="BalanceQty"></asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="container-group-top">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label8" runat="server" Text="DispatchNo"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtReturnDispatchNo" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label6" runat="server" Text="Asset Code"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetCode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label9" runat="server" Text="Asset Name"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetName" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label2" runat="server" Text="Actual Qty"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtActualQty" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label3" runat="server" Text="Balance Qty"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtBalanceQty" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label4" runat="server" Text="Return Qty"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtReturnQty" runat="server" onkeypress="return fncAllowOnlyNumbers(event)" type="tel" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                                     <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label19" runat="server" Text="Document"></asp:Label>
                                        </div>                                       
                                    </div>
                                </div>
                                      <div class="col-md-4">
                                   <div class="control-right" >
                                    <asp:Panel runat="server" ID="Panel4" HorizontalAlign="Center">

                                        <asp:UpdatePanel ID="pdfpreview2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <Triggers>
                                                <asp:PostBackTrigger ControlID="lnkSave" />
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:FileUpload Style="float: right; margin-right: 313px;margin-top:4px" accept=".pdf,.xlsx" ID="FileUpload1" runat="server" onchange="showpreview2(this);" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>

                                </div>
                                          </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="control-group">
                        <div class="button-control">
                            <asp:LinkButton ID="lnkSave" runat="server" OnClientClick="return fncDCReturnVAlidation();" OnClick="lnkSave_Click" CssClass="btn btn-success waves-effect">Save</asp:LinkButton>
                            <asp:LinkButton ID="lnkCancel" runat="server" OnClientClick="fncClear();return false;" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
