<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmEmployeeMaster.aspx.cs" Inherits="AssetMobileApplication.Asset_Master.frmEmployeeMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Src="~/UserControls/PaginationUserControls.ascx" TagName="PaginationUserControl" TagPrefix="ups" %>
    <script type="text/javascript">
        $(function () {
            $("#divDialog_Confirm").dialog({
                autoOpen: false,
                resizable: false,
                height: 130,
                width: 240,
                modal: true,
                title: "",
                appendTo: 'form:first'
            });
        });
        function fncOpenSaveConfirmDialogOpen(source) {
            try {
                var data = $(source).closest("tr");
                $("#<%=hdEmployeeCode.ClientID%>").val($("td", data).eq(2).html().replace(/&nbsp;/g, ''))
                $("#<%=lblDialog_Confirm.ClientID %>").text('Do you want Delete?');
                $("#divDialog_Confirm").dialog('open');
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }
        function fncMaterialChkDialogClose() {
            try {
                $("#divDialog_Confirm").dialog('close');
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }
        function ValidateForm() {
            var status = true;
            if ($("#<%=txtEmployeeCode.ClientID%>").val() == '') {
             ShowPopupMessageBox('Please Enter Employee Code');
             status = false;
         }
         else if ($("#<%=txtFirstName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Employee Name');
                status = false;
            }
            else if ($("#<%=txtDesignation.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Employee Designation');
                status = false;
            }
            else if ($("#<%=txtDesignation.ClientID%>").val() == 'Driver') {
                if ($("#<%=txtLicenseNo.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter License No');
                    status = false;
                }
                else
                    status = true;
            }
            else if ($("#<%=txtMailId.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Employee Mail Id');
                status = false;
            }
         <%--   else if ($("#<%=txtContactNo.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter ContentNo');
                status = false;
            }--%>
          <%--  else if ($("#<%=txtMailId.ClientID%>").val() != '') {
                var email = $("#<%=txtMailId.ClientID%>").val();
                if (!IsValidEmail(email)) {
                    ShowPopupMessageBox('Please Enter valid Mail Id');
                    status = false;
                }
            }--%>
            else if ($("#<%=ddlDepartment.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Select Department Name');
                status = false;
            }
            else if ($("#<%=ddlLocation.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Select Location Name');
                status = false;
            }
            else if ($("#<%=ddlBlock.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Select Block Name');
                status = false;
            }
            else if ($("#<%=ddlFloor.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Select Floor Name');
                status = false;
            } 
        else if ($("#<%=ddlRoom.ClientID%>").val() == '') {
             ShowPopupMessageBox('Please Select Room Name');
             status = false;
         }
            else if ($("#<%=ddlCubical.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Select Cubical Name');
                status = false;
            }


         return status;
     }
        function IsValidEmail(email) {
            try {
                var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                return expr.test(email);
            }
            catch (err) {
                ShowToastError(err.message);
            }
        };
        function fncPopupMessageBox(msg) {
            clearForm()
            ShowPopupMessageBox(msg);
        }

        function clearForm() {
            $('input[type=text], input[type=number]').val('');
            $('#<%=txtEmployeeCode.ClientID %>').attr('readonly', false);
            $('#<%=txtContactNo.ClientID %>').val('');
            $('#<%=ddlBlock.ClientID %>').val('');
            $('#<%=ddlFloor.ClientID %>').val('');
            $('#<%=ddlRoom.ClientID %>').val('');
            $('#<%=ddlCubical.ClientID %>').val('');
        }

      <%--  function clearForm() {
            $('input[type=text]').val('');
            $('#<%=txtEmployeeCode.ClientID %>').attr('readonly', false);
        }--%>
        //function fncAllowOnlyNumbers(evt) {
        //    try {
        //        if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
        //            //ShowPopupMessageBox('Allow Only Numbers');
        //            return false;
        //        }
        //    }
        //    catch (err) {
        //        ShowToastError(err.message);
        //    }
        //}
        function imgbtnEdit_ClientClick(source) {
            DisplayDetails($(source).closest("tr"));
            __doPostBack('ctl00$ContentPlaceHolder1$hidbtnedit', '');
            return false;
        }
        function lnkSearch_Click(source) {
            DisplayDetails($(source).closest("tr"));
        }


        function ShowPopupMessageBox1(msg) {
            $(function () {

                $("#dialog-MessageBox1").html(msg);
                $("#dialog-MessageBox1").dialog({
                    title: "Room",
                    buttons: {
                        Ok: function () {
                            //$(this).dialog('close');                            
                            $("#<%=btnsavenew.ClientID %>").click();
                            clearForm()

                        }
                    },
                    modal: true
                });
            });
        }


        function DisplayDetails(row) {
            try {
                $('#<%=hdBrandId.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
                $('#<%=txtEmployeeCode.ClientID %>').attr('readonly', true);
        $('#<%=txtEmployeeCode.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
        $('#<%=txtFirstName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
        $('#<%=txtLastName.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlDepartment.ClientID %>').val($("td", row).eq(13).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlDepartment.ClientID %>').trigger("chosen:updated");
        $('#<%=txtDesignation.ClientID %>').val($("td", row).eq(6).html().replace(/&nbsp;/g, ''));
        $('#<%=txtDesignation.ClientID %>').trigger("chosen:updated");
        $('#<%=txtMailId.ClientID %>').val($("td", row).eq(7).html().replace(/&nbsp;/g, ''));
        $('#<%=txtContactNo.ClientID %>').val($("td", row).eq(8).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlLocation.ClientID %>').val($("td", row).eq(14).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlLocation.ClientID %>').trigger("chosen:updated");
        $('#<%=ddlBlock.ClientID %>').val($("td", row).eq(15).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlBlock.ClientID %>').trigger("chosen:updated");
        $('#<%=ddlFloor.ClientID %>').val($("td", row).eq(16).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlFloor.ClientID %>').trigger("chosen:updated");
        $('#<%=ddlRoom.ClientID %>').val($("td", row).eq(17).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlRoom.ClientID %>').trigger("chosen:updated");
       $('#<%=ddlCubical.ClientID %>').val($("td", row).eq(18).html().replace(/&nbsp;/g, ''));
        $('#<%=ddlCubical.ClientID %>').trigger("chosen:updated");

            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    //$('#blah')
                    //    .attr('src', e.target.result)
                    //    .width(150)
                    //    .height(100);
                    $('#<%=imgpreview.ClientID %>').attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
            }
        }
        function showpreview(input) {
            try {
                var maxsize = 30 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=imgpreview.ClientID %>').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
                else {
                    input.value = "";
                    ShowToastError('File size exceeds 30 kb');
                    //alert('file size: ' + input.files[0].size);
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncDesignation() {
            var Designation = '';
            try {
                Designation = $("#<%=txtDesignation.ClientID%>").val();
                if (Designation == 'Driver') {
                    $('#divLicenseNo').show();
                    $('#divLicenseImageUpload').show();
                }
                else {
                    $('#divLicenseNo').hide();
                    $('#divLicenseImageUpload').hide();
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function isAllowdNumOnly(event) {
            $('#<%=txtContactNo.ClientID %>').on('input', function () {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Master</a></li>
                <li><a href="javascript:void(0);">Employee Master</a></li>
            </ol>
        </div>

        <div class="container-group-top">
            <div class="col-md-12">
                <div class="col-md-12">
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label4" runat="server" Text="Employee Code"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtEmployeeCode" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label1" runat="server" Text="First Name"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label2" runat="server" Text="Last Name"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label3" runat="server" Text="Department"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label5" runat="server" Text="Designation"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control"></asp:TextBox>
                                <%-- <asp:DropDownList ID="ddlDesignation" runat="server" onchange="fncDesignation()" CssClass="form-control"></asp:DropDownList>--%>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label6" runat="server" Text="E-Mail Id"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtMailId" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label7" runat="server" Text="Contact No"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtContactNo" runat="server" MaxLength="10" type="tel" onkeypress="return isAllowdNumOnly(event)" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label13" runat="server" Text="Location Name"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlLocation" runat="server" onSelectedIndexChanged="LoadLocationInBlock" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label8" runat="server" Text="Block"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control" onSelectedIndexChanged="LoadBlockInfloor" AutoPostBack="True"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label9" runat="server" Text="Floor"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlFloor" runat="server"  onSelectedIndexChanged="LoadfloorInRoom" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label10" runat="server" Text="Room"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlRoom" runat="server" onSelectedIndexChanged="LoadRoomInCubical" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                      <div id="Employee" class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="CubicalNo" runat="server" Text="Cubical"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlCubical" runat="server" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                    <div id="divLicenseNo" class="col-md-4" style="display: none;">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label11" runat="server" Text="License No"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtLicenseNo" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div>
                    <div id="divLicenseImageUpload" style="display: none;">
                        <div class="control-left">
                            <asp:Label ID="Label32" runat="server" Text="License Image"></asp:Label>
                        </div>
                        <asp:Panel runat="server" ID="Panel2" HorizontalAlign="Center">

                            <asp:Image ID="imgpreview" runat="server" Style="align-content: center;" Height="100px" Width="150px" />
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                </Triggers>
                                <ContentTemplate>
                                    <asp:FileUpload Style="float: right" accept="image/*" ID="fuimage" runat="server" onchange="showpreview(this);" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="button-control">
                        <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkSave_Click" OnClientClick="return ValidateForm()">Save</asp:LinkButton>
                        <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncclearForm();return false;">Clear</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                <ContentTemplate>
                    <div class="control-group">
                        <div class="col-md-12">
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="lnkSearchGrid">
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter Employee FirstName To Search"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:LinkButton ID="lnkSearchGrid" runat="server" class="button-blue" Width="100px" Style="visibility: hidden"
                                        OnClick="lnkSearchGrid_Click" Text="Search"><i class="icon-play"></i></asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="grd-scroll">
                        <asp:GridView ID="gvEmployee" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="True">
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
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images/edit-icon.png" OnClientClick="imgbtnEdit_ClientClick(this); return false;"
                                            CommandName="Select" ToolTip="Click here to edit" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images/delete.png" OnClientClick="fncOpenSaveConfirmDialogOpen(this); return false;"
                                            CommandName="Select" ToolTip="Click here to Delete" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="EmployeeCode" HeaderText="Employee Code"></asp:BoundField>
                                <asp:BoundField DataField="FirstName" HeaderText="First Name"></asp:BoundField>
                                <asp:BoundField DataField="LastName" HeaderText="Last Name"></asp:BoundField>
                                <asp:BoundField DataField="Department" HeaderText="Department"></asp:BoundField>
                                <asp:BoundField DataField="Designation" HeaderText="Designation"></asp:BoundField>
                                <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number"></asp:BoundField>
                                <asp:BoundField DataField="Location" HeaderText="Location"></asp:BoundField>
                                <asp:BoundField DataField="BlockName" HeaderText="Block Name"></asp:BoundField>
                                <asp:BoundField DataField="FloorName" HeaderText="Floor Name"></asp:BoundField>
                                <asp:BoundField DataField="RoomNo" HeaderText="Room No"></asp:BoundField>
                                <asp:BoundField DataField="DepartmentID" HeaderText="Department Id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                <asp:BoundField DataField="LocationId" HeaderText="LocationId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                <asp:BoundField DataField="BlockId" HeaderText="BlockId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                <asp:BoundField DataField="FloorId" HeaderText="FloorId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                <asp:BoundField DataField="RoomId" HeaderText="RoomId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                <asp:BoundField DataField="CubicalId" HeaderText="CubicalId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                 <asp:BoundField DataField="CubicalNo" HeaderText="CubicalNo"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    </div>
                    <ups:PaginationUserControl runat="server" ID="EmployeeMasterPagination" OnPaginationButtonClick="Employee_PaginationButtonClick" />
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:HiddenField ID="hdEmployeeCode" runat="server" Value="" />
            <div id="divDialog_Confirm" style="display: none;">
                <div>
                    <asp:Label ID="lblDialog_Confirm" runat="server"></asp:Label>
                </div>
                <div class="Dialog_Confirm_Center">
                    <div class="Dialog_Confirm_yes">
                        <asp:UpdatePanel ID="upDialog_Confirm" runat="server">
                            <ContentTemplate>
                                <asp:LinkButton ID="lnkbtnYes" runat="server" class="btn btn-success waves-effect" Text='Yes' OnClick="lnkDelete_Click"
                                    OnClientClick="fncMaterialChkDialogClose();"> </asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="Dialog_Confirm_No">
                        <asp:LinkButton ID="lnlbtnNo" runat="server" class="btn btn-warning waves-effect" Text='No'
                            OnClientClick="fncMaterialChkDialogClose();return false;"> </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
              <asp:HiddenField ID="hdBrandId" runat="server" />
   <div style="display:none"> 
       <asp:LinkButton ID="hidbtnedit" runat="server" class="btn btn-warning waves-effect"   OnClick="gridebind" > </asp:LinkButton>
   </div>
      <asp:Button ID="btnsavenew" runat="server" style="display:none"  OnClick="btn_save_Click" />
      <div id="dialog-MessageBox1" style="display: none"></div>
  
</asp:Content>
