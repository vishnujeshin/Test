<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmLocationMaster.aspx.cs" Inherits="AssetMobileApplication.Asset_Master.frmLocationMaster" %>

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
                $("#<%=hdLocationCode.ClientID%>").val($("td", data).eq(2).html().replace(/&nbsp;/g, ''))
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
            if ($("#<%=txtLocationCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Location Code');
                status = false;
            }
            else if ($("#<%=txtLocationName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Location Name');
                status = false;
            }
            return status;
        }
        function fncPopupMessageBox(msg) {
            clearForm()
            ShowPopupMessageBox(msg);
        }
        function clearForm() {
            $('input[type=text]').val('');
            $('#<%=txtLocationCode.ClientID %>').attr('readonly', false);
}
function imgbtnEdit_ClientClick(source) {
    DisplayDetails($(source).closest("tr"));
}
function lnkSearch_Click(source) {
    DisplayDetails($(source).closest("tr"));
}
function DisplayDetails(row) {
    try {
        $('#<%=txtLocationCode.ClientID %>').attr('readonly', true);
        $('#<%=txtLocationCode.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
        $('#<%=txtLocationName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));

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
                <li><a href="javascript:void(0);">Location Master</a></li>
            </ol>
        </div>

        <div class="container-group-top">
            <div class="col-md-12">
                <div class="col-md-6">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label4" runat="server" Text="Location Code"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtLocationCode" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label1" runat="server" Text="Location Name"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtLocationName" runat="server" CssClass="form-control"></asp:TextBox>
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
        <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                <ContentTemplate>
                    <div class="control-group">
                        <div class="col-md-12">
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="lnkSearchGrid">
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter Location Name To Search"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:LinkButton ID="lnkSearchGrid" runat="server" class="button-blue" Width="100px" Style="visibility: hidden"
                                        OnClick="lnkSearchGrid_Click" Text="Search"><i class="icon-play"></i></asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <asp:GridView ID="gvLocation" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="True">
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
                            <asp:BoundField DataField="LocationCode" HeaderText="Location Code"></asp:BoundField>
                            <asp:BoundField DataField="LocationName" HeaderText="Location Name"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <ups:PaginationUserControl runat="server" ID="LocationMasterPagination" OnPaginationButtonClick="Location_PaginationButtonClick" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <asp:HiddenField ID="hdLocationCode" runat="server" Value="" />
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
