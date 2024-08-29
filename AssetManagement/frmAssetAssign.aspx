<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetAssign.aspx.cs" Inherits="AssetMobileApplication.AssetManagement.frmAssetAssign" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .border-style {
            border: 1px solid green;
            padding: 3px 6px;
        }
    </style>
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtAssignedDate.ClientID %>"));
            });

            $(function () {
                SetDefaultDueDate($("#<%= txtDueDate.ClientID %>"));
               });
        }
        function SetDefaultDate(AssignedDate) {
            try {
                AssignedDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                if (AssignedDate.val() === '') {
                    AssignedDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }

        function SetDefaultDueDate(AssignedDueDate) {
            try {
                AssignedDueDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                if (AssignedDueDate.val() === '') {
                    AssignedDueDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, })
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
                            url: '<%=ResolveUrl("frmAssetAssign.aspx/GetAssetCodeForAssetAssigning") %>',
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
        function fncAssetAssignValidation()
        {
            var status = true, Location = '', Department = '', Block = '', Floor = '',
                Room = '', Cubical = '', AssignedBy = '', Employee = '';
            try {
                Location = $('#<%=ddlLocation.ClientID %>').val();
                Department = $('#<%=ddlDepartment.ClientID %>').val();
                Block = $('#<%=ddlBlockName.ClientID %>').val();
                Floor = $('#<%=ddlFloorName.ClientID %>').val();
                Room = $('#<%=ddlRoom.ClientID %>').val();
                Cubical = $('#<%=ddlCubical.ClientID %>').val();
                AssignedBy = $('#<%=ddlAssignedBy.ClientID %>').val();
                Employee = $('#<%=ddlEmployee.ClientID %>').val();

                if ($('#<%=txtAssetCode.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Select Asset');
                    status = false;
                }
                else if (Location == '0' || Location == '--Select--') {
                    ShowPopupMessageBox('Please Select Location');
                    status = false;
                }
                else if (Employee == '0' || Employee == '--Select--') {
                    ShowPopupMessageBox('Please Select Employee');
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
                //else if (Cubical == '0' || Cubical == '--Select--') {
                //    ShowPopupMessageBox('Please Select Cubical');
                //    status = false;
                //}
                else if (AssignedBy == '0' || AssignedBy == '--Select--') {
                    ShowPopupMessageBox('Please Select AssignedBy');
                    status = false;
                }
                else if ($('#<%=txtAssignedDate.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Select Assigned Date');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncClearForm() {
            window.location = "../AssetManagement/frmAssetAssign.aspx";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Asset Management</a></li>
                <li><a href="javascript:void(0);">Asset Assigning</a></li>
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
                                        <asp:Button Text="" Style="display: none;" ID="btnFetchAssetDetails" OnClick="btnFetchAssetDetails_Click" runat="server" />
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
                                <div class="col-md-4" style ="display:none" >

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
                            </div>
                            <div class="col-md-12">
                            
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
                            </div>
                            <div class="col-md-12">
                              
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
                                <div class="col-md-6">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="lblAssetAssigningDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="Asset Assigning Details"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div runat="server" id="divlblAssetAssignment" visible="false" class="col-md-6">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="lblAssetAssignment" ForeColor="Tomato" Font-Bold="true" runat="server" Text=""></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                 <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label14" runat="server" Text="Employee"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                           <%-- <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control"></asp:DropDownList>--%>
                                             <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label15" runat="server" Text="Department"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                           <asp:TextBox ID="ddlDepartment" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label16" runat="server" Text="Location"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="ddlLocation" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label17" runat="server" Text="Block Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="ddlBlockName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label18" runat="server" Text="Floor Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="ddlFloorName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label19" runat="server" Text="Room"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="ddlRoom" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label20" runat="server" Text="Cubical"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="ddlCubical" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label21" runat="server" Text="Assigned By"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlAssignedBy" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label22" runat="server" Text="Assigned Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtAssignedDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>

    <div class="col-md-4">
        <div class="control-group">
            <div class="control-left">
                <asp:Label ID="Label23" runat="server" Text="Due Date"></asp:Label>
            </div>
            <div class="control-right">
                <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="control-group">
            <div class="control-left">
                <asp:Label ID="Label24" runat="server" Text="Comments" CssClass="mr-2"></asp:Label>
            </div>
            <div class="control-right">
                <asp:TextBox ID="txtComments" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="control-group">
            <div class="button-control">
                <asp:LinkButton ID="lnkAssign" runat="server" OnClientClick="return fncAssetAssignValidation();" OnClick="lnkAssign_Click" CssClass="btn btn-success waves-effect">Assign</asp:LinkButton>
                <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
            </div>
        </div>
    </div>
</div>


            <asp:HiddenField ID="hiddepartmentIds" runat="server" />
            <asp:HiddenField ID="hidlocationId" runat="server" />
            <asp:HiddenField ID="hidblockId" runat="server" />
            <asp:HiddenField ID="hidfloorId" runat="server" />
            <asp:HiddenField ID="hidroomId" runat="server" />
            <asp:HiddenField ID="hidcubicalId" runat="server" />

    </div>
</asp:Content>
