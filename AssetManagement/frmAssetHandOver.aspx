<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetHandOver.aspx.cs" Inherits="AssetMobileApplication.AssetManagement.frmAssetHandOver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtHandOverDate.ClientID %>"));
            });
            $('#<%=pdfpreview2.ClientID %>').change(function () {
                fncFileValidation1();
            })
        }
        function SetDefaultDate(HandOverDate) {
            try {

                HandOverDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, minDate: "0" });

                if (HandOverDate.val() === '') {
                    HandOverDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, minDate: "0" }).datepicker("setDate", "today");
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncSaveValidation()
        {
            var status = true, Employee = '', CheckedBy = '';
            try
            {
                Employee = $('#<%=ddlEmployee.ClientID %>').val();
                CheckedBy = $('#<%=ddlCheckedBy.ClientID %>').val();
                if (Employee == '0' || Employee == '--Select--') {
                    ShowPopupMessageBox('Please Select Employee');
                    status = false;
                }
                else if (CheckedBy == '0' || CheckedBy == '--Select--') {
                    ShowPopupMessageBox('Please Select CheckedBy');
                    status = false;
                }
                else if ($('#<%=txtHandOverDate.ClientID %>').val()=='') {
                    ShowPopupMessageBox('Please Enter Hand Over Date');
                    status = false;
                }
            }
            catch (err) {
                return false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncCancel()
        {
            window.location = "../AssetManagement/frmAssetHandOver.aspx";
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
                <li><a href="javascript:void(0);">AssetManagement</a></li>
                <li><a href="javascript:void(0);">Asset HandOver</a></li>
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
                                            <asp:Label ID="Label15" runat="server" Text="Employee"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlEmployee" runat="server" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" AutoPostBack="true" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="container-group-top">
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="lblEmployeeDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="Employee Details"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label1" runat="server" Text="First Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label3" runat="server" Text="Last Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label4" runat="server" Text="Designation"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label7" runat="server" Text="Department"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label2" runat="server" Text="Email-Id"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label5" runat="server" Text="Extension No"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtExtensionNo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label6" runat="server" Text="Work Phone"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtWorkPhone" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label8" runat="server" Text="Contact No"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label9" runat="server" Text="Location"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div style="height: 250px; overflow: auto;">
                                        <asp:GridView ID="gvAssetDetails" runat="server" Width="100%" AutoGenerateColumns="False" OnRowDataBound="gvAssetDetails_RowDataBound" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                                                <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                                <%--<asp:BoundField DataField="isReturned" HeaderText="Is Returned"></asp:BoundField>
                                    <asp:BoundField DataField="Status" HeaderText="Status"></asp:BoundField>--%>
                                                <asp:TemplateField HeaderText="Is Returned">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="IsReturned" runat="server" Text=" " />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                     <%--   <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control"></asp:DropDownList>--%>
                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">                                                            
                                                <asp:ListItem>--Select--</asp:ListItem>
                                                <asp:ListItem>InUse</asp:ListItem>
                                                <asp:ListItem>NotInUse</asp:ListItem>
                                                <asp:ListItem>damage</asp:ListItem>
                                            </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="container-group-top">
                        <div class="col-md-12">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="lblAssetHandOverDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="Asset Hand Over Details"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-4">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="Label10" runat="server" Text="Checked By"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:DropDownList ID="ddlCheckedBy" runat="server" CssClass="form-control"></asp:DropDownList>                            
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="Label11" runat="server" Text="Hand Over Date"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:TextBox ID="txtHandOverDate" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="control-group">
                                    <div class="control-left">
                                        <asp:Label ID="Label12" runat="server" Text="Remarks"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                                          <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label19" style="margin-left:-350px"  runat="server" Text="Document"></asp:Label>
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
                                                <asp:FileUpload Style="float: right; margin-right: 518px;margin-top:4px" accept=".pdf,.xlsx" ID="FileUpload1" runat="server" onchange="showpreview2(this);" />
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
                                <asp:LinkButton ID="lnkSave" runat="server" OnClientClick="return fncSaveValidation();" OnClick="lnkSave_Click" CssClass="btn btn-success waves-effect">Save</asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" OnClientClick="fncCancel();return false;" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
