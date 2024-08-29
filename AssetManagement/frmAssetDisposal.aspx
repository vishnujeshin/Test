<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetDisposal.aspx.cs" Inherits="AssetMobileApplication.AssetManagement.frmAssetDisposal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtDisposalDate.ClientID %>"));
            });
            $('#<%=pdfpreview2.ClientID %>').change(function () {
                fncFileValidation1();
            })
        }
        function SetDefaultDate(DisposalDate) {
            try {

                DisposalDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, minDate: "0" });

                if (DisposalDate.val() === '') {
                    DisposalDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, minDate: "0" }).datepicker("setDate", "today");
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
                            url: '<%=ResolveUrl("frmAssetDisposal.aspx/SearchAssetCodeForAssetDisposal") %>',
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
                        $('#<%=txtAssetCode.ClientID %>').attr('readonly', true);
                        $("#<%=btnFetchAssetDetails.ClientID%>").click();
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
        function fncClearForm() {
            window.location = "../AssetManagement/frmAssetDisposal.aspx";
        }
        function fncAssetDisposalValidation()
        {
            var status = true, DisposedBy = '';
            try {
                DisposedBy = $('#<%=ddlDisposedBy.ClientID %>').val();
                if ($('#<%=txtAssetCode.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Select Asset');
                    status = false;
                }
                else if (DisposedBy == '0' || DisposedBy == '--Select--') {
                    ShowPopupMessageBox('Please Select DisposedBy');
                    status = false;
                }
                else if ($('#<%=txtDisposalDate.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Select Disposal Date');
                    status = false;
                }
                else if ($('#<%=txtDisposalPrice.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Select Disposal Price');
                    status = false;
                }
                else if ($('#<%=txtAssetName.ClientID %>').val() == '' || $('#<%=txtStatus.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Invalid Process..!');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
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
                <li><a href="javascript:void(0);">Asset Management</a></li>
                <li><a href="../AssetManagement/frmAssetDisposalAprovalList.aspx">Asset Disposal List</a></li>
                <li><a href="javascript:void(0);">Asset Disposal</a></li>
            </ol>
        </div>
          <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="container-group-top border-style">
                            <div class="col-md-4">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="Label2" runat="server" Text="Asset Code"></asp:Label> <span class="mandatory">*</span>
                                    </div>
                                    <div class="control-right">
                                        <asp:TextBox ID="txtAssetCode" runat="server" onkeydown="return fncSearchAssetCode(event)" CssClass="form-control"></asp:TextBox>
                                        <asp:Button Text="" Style="display: none;" ID="btnFetchAssetDetails" runat="server" OnClick="btnFetchAssetDetails_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1">
                                <div class="control-group">
                                    <div class="button-control" style="margin: 0px !important; padding-left: 2px !important">
                                        <asp:LinkButton ID="lnkClear" OnClientClick="fncClearForm();return false;" runat="server" CssClass="btn btn-warning waves-effect">Clear</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="container-group-top border-style">
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="lblAssetDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="Asset Details"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label1" runat="server" Text="Asset Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtAssetName" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label3" runat="server" Text="Department"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label4" runat="server" Text="Category"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label5" runat="server" Text="Employee"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtEmployee" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label6" runat="server" Text="Sub Category"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtSubCategory" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label7" runat="server" Text="Class"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtClass" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label8" runat="server" Text="Status"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtStatus" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label9" runat="server" Text="Brand"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label10" runat="server" Text="Vendor"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtVendor" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label11" runat="server" Text="Model"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtModel" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label12" runat="server" Text="Serial"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtSerial" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label13" runat="server" Text="Purchase Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDateAcqired" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="container-group-top border-style">
                            <div class="col-md-12">                               
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="lblAssetDisposalDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="Asset Disposal Details"></asp:Label>
                                        </div>
                                    </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label14" runat="server" Text="Disposed By"></asp:Label> <span class="mandatory">*</span>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlDisposedBy" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label15" runat="server" Text="Disposal Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDisposalDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label16" runat="server" Text="Disposal Price"></asp:Label> <span class="mandatory">*</span>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDisposalPrice" runat="server" CssClass="form-control" onkeypress="return fncAllowOnlyNumbers(event)" type="tel"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label23" runat="server" Text="Remarks"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtRemarks" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                 <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label17" runat="server" Text="Document"></asp:Label>
                                        </div>                                       
                                    </div>
                                </div>
                                   
                                   <div class="control-right" >
                                    <asp:Panel runat="server" ID="Panel4" HorizontalAlign="Center">

                                        <asp:UpdatePanel ID="pdfpreview2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <Triggers>
                                                <asp:PostBackTrigger ControlID="lnkSave" />
                                            </Triggers>
                                            <ContentTemplate>
                                                <asp:FileUpload Style="float: right; margin-right: 306px;margin-top:-9px" accept=".pdf,.xlsx" ID="FileUpload1" runat="server" onchange="showpreview2(this);" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>

                                </div>
                                <div class="col-md-8">
                                    <div class="control-group">
                                        <div class="button-control">
                                            <asp:LinkButton ID="lnkSave" runat="server" OnClientClick="return fncAssetDisposalValidation();" OnClick="lnkSave_Click" CssClass="btn btn-success waves-effect">Save</asp:LinkButton>
                                            <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncClearForm();return false;">Cancel</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </div>
                        </div>

                    </div>
                </div>
              </div>

    </div>
</asp:Content>
