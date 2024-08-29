<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmVendorMaster.aspx.cs" Inherits="AssetMobileApplication.Asset_Master.frmVendorMaster" %>

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
                $("#<%=hdVendorCode.ClientID%>").val($("td", data).eq(2).html().replace(/&nbsp;/g, ''))
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
            <%--if ($("#<%=txtVendorCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Vendor Code');
                status = false;
            }--%>
            if ($("#<%=txtVendorName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Vendor Name');
                status = false;
            }
            else if ($("#<%=txtPostalCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter PostalCode');
                status = false;
            }
           <%--   else if ($("#<%=txtCity.ClientID%>").val() == '') {
              ShowPopupMessageBox('Please Enter City');
                status = false;
            }
            else if ($("#<%=txtState.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter State');
                status = false;
            }
            else if ($("#<%=txtCountry.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Country');
                status = false;
            }

            else if ($("#<%=txtMailId.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Employee Mail Id');
                status = false;
            }
            else if ($("#<%=txtMailId.ClientID%>").val() != '') {
                var email = $("#<%=txtMailId.ClientID%>").val();
                if (!IsValidEmail(email)) {
                    ShowPopupMessageBox('Please Enter valid Mail Id');
                    status = false;
                }
            }
            else if ($("#<%=txtMobileNo.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Vendor Mobile Number');
                status = false;
            }
            else if ($("#<%=txtGSTIN.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter GSTIN');
                status = false;
            }--%>
            <%--else if ($("#<%=txtBankCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Bank Code');
                status = false;
            }
            else if ($("#<%=txtBankBranchCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Bank Branch Code');
                status = false;
            }
            else if ($("#<%=txtBankAccountNo.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Bank Account Number');
                status = false;
            }
            else if ($("#<%=txtIFSCcode.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter IFSC Code');
                    status = false;
                }--%>

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
            $('input[type=text]').val('');
            $("#<%=hdVendorCode.ClientID%>").val('');
            $('#<%=txtMobileNo.ClientID %>').val('');
        }
        function fncAllowOnlyNumbers(evt) {
            try {
                if (evt.charCode > 31 && (evt.charCode < 48 || evt.charCode > 57)) {
                    //ShowPopupMessageBox('Allow Only Numbers');
                    return false;
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function imgbtnEdit_ClientClick(source) {
            DisplayDetails($(source).closest("tr"));
        }
        function lnkSearch_Click(source) {
            DisplayDetails($(source).closest("tr"));
        }
        function DisplayDetails(row) {
            try {
                $("#<%=hdVendorCode.ClientID%>").val($("td", row).eq(2).html().replace(/&nbsp;/g, ''))
                $('#<%=txtVendorName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
                $('#<%=txtAddress.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                $('#<%=txtCity.ClientID %>').val($("td", row).eq(5).html().replace(/&nbsp;/g, ''));
                $('#<%=txtState.ClientID %>').val($("td", row).eq(6).html().replace(/&nbsp;/g, ''));
                $('#<%=txtCountry.ClientID %>').val($("td", row).eq(7).html().replace(/&nbsp;/g, ''));
                $('#<%=txtPostalCode.ClientID %>').val($("td", row).eq(8).html().replace(/&nbsp;/g, ''));
                $('#<%=txtMailId.ClientID %>').val($("td", row).eq(9).html().replace(/&nbsp;/g, ''));
                $('#<%=txtMobileNo.ClientID %>').val($("td", row).eq(10).html().replace(/&nbsp;/g, ''));
                $('#<%=txtGSTIN.ClientID %>').val($("td", row).eq(11).html().replace(/&nbsp;/g, ''));

            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Master</a></li>
                <li><a href="javascript:void(0);">Vendor Master</a></li>
            </ol>
        </div>

        <div class="container-group-top">
            <div class="col-md-12">
                <%--<div class="control-group">
                    <div class="control-left">
                        <asp:Label ID="Label4" runat="server" Text="Vendor Code"></asp:Label>
                    </div>
                    <div class="control-right">
                        <asp:TextBox ID="txtVendorCode" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>--%>
                <div class="col-md-12">
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label1" runat="server" Text="Vendor Name"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtVendorName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label2" runat="server" Text="Address"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <%--<div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label3" runat="server" Text="Address2"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>--%>
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label5" runat="server" Text="City"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label7" runat="server" Text="State"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtState" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label13" runat="server" Text="Country"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label8" runat="server" Text="PostalCode"></asp:Label> <span class="mandatory">*</span>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtPostalCode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label6" runat="server" Text="E-Mail Id"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtMailId" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label9" runat="server" Text="MobileNo"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtMobileNo" MaxLength="10" type="tel" onkeypress="return fncAllowOnlyNumbers(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label10" runat="server" Text="GSTIN"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtGSTIN" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="button-control">
                        <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkSave_Click" OnClientClick="return ValidateForm()">Save</asp:LinkButton>
                        <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="clearForm();return false;">Clear</asp:LinkButton>
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
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter Vendor Name  To Search"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:LinkButton ID="lnkSearchGrid" runat="server" class="button-blue" Width="100px" Style="visibility: hidden"
                                        OnClick="lnkSearchGrid_Click" Text="Search"><i class="icon-play"></i></asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <div class="grd-scroll">
                        <asp:GridView ID="gvVendor" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="True">
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
                                <asp:BoundField DataField="VendorCode" HeaderText="VendorCode" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                <asp:BoundField DataField="VendorName" HeaderText="Vendor Name"></asp:BoundField>
                                <asp:BoundField DataField="Address" HeaderText="Address"></asp:BoundField>
                                <asp:BoundField DataField="City" HeaderText="City"></asp:BoundField>
                                <asp:BoundField DataField="State" HeaderText="State"></asp:BoundField>
                                <asp:BoundField DataField="Country" HeaderText="Country"></asp:BoundField>
                                <asp:BoundField DataField="PostalCode" HeaderText="PostalCode"></asp:BoundField>
                                <asp:BoundField DataField="Email" HeaderText="Email"></asp:BoundField>
                                <asp:BoundField DataField="MobileNo" HeaderText="MobileNo"></asp:BoundField>
                                <asp:BoundField DataField="GSTIN" HeaderText="GSTIN"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </div>
                    <ups:PaginationUserControl runat="server" ID="VendorMasterPagination" OnPaginationButtonClick="Vendor_PaginationButtonClick" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <asp:HiddenField ID="hdVendorCode" runat="server" Value="" />
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
</asp:Content>
