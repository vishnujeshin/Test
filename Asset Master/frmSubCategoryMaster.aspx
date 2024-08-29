<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmSubCategoryMaster.aspx.cs" Inherits="AssetMobileApplication.Asset_Master.frmSubCategoryMaster" %>

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
                $("#<%=hdSubCategoryCode.ClientID%>").val($("td", data).eq(2).html().replace(/&nbsp;/g, ''))
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
            if ($("#<%=txtSubCategoryCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter SubCategory Code');
                status = false;
            }
            else if ($("#<%=txtSubCategoryName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter SubCategory Name');
                status = false;
            }
            else if ($("#<%=ddlCategoryNames.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Choose Category Name');
                status = false;
            }
       <%--     else if ($("#<%=ddlCategoryName.ClientID%>").val() == '0') {
                ShowPopupMessageBox('Please Select Category Name');
                status = false;
            }--%>
        return status;
    }
    
        function fncPopupMessageBox(msg) {
        clearForm()
        ShowPopupMessageBox(msg);
    }
  <%--  function clearForm() {
        $('input[type=text]').val('');
        $('#<%=txtSubCategoryCode.ClientID %>').attr('readonly', false);
    }--%>

        //function fncclearForm() {
        //    window.location = "../Asset%20Master/frmSubCategoryMaster.aspx";
        //}

        function clearForm() {
            $('input[type=text]').val('');
            $('#<%=txtSubCategoryCode.ClientID %>').attr('readonly', false);
          }
    function imgbtnEdit_ClientClick(source) {
        DisplayDetails($(source).closest("tr"));
    }
    function lnkSearch_Click(source) {
        DisplayDetails($(source).closest("tr"));
    }
        function DisplayDetails(row) {
            try {
                $('#<%=txtSubCategoryCode.ClientID %>').attr('readonly', true);
        $('#<%=txtSubCategoryCode.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
                $('#<%=txtSubCategoryName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
                $('#<%=ddlCategoryNames.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                ($("td", row).eq(3).html().replace(/&nbsp;/g, ''))
                $('#<%=ddlCategoryNames.ClientID %>').trigger("chosen:updated");
        // Extract category name from the fifth column (index 4) of the row
    <%--    var categoryName = $("td", row).eq(4).html().replace(/&nbsp;/g, '').trim();
        
        // Populate the dropdown with the category name
        $('#<%=ddlCategoryNames.ClientID %>').val(categoryName.toLowerCase());
                $('#<%=ddlCategoryNames.ClientID %>').trigger("chosen:updated");--%>
            } catch (err) {
                ShowToastError(err.message);
            }
        }
        function clearForm() {
            $('input[type=text]').val('');
            $('#<%=txtSubCategoryCode.ClientID %>').attr('readonly', false);
            $('#<%=ddlCategoryNames.ClientID %>').val('').trigger("chosen:updated");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Master</a></li>
                <li><a href="javascript:void(0);">SubCategory Master</a></li>
            </ol>
        </div>

        <div class="container-group-top">
            <div class="col-md-16">
                 <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label2" runat="server" Text="Category Name"></asp:Label> <span class="mandatory">*</span>
                        </div> 
                        <div class="control-right">
                           <asp:DropDownList ID="ddlCategoryNames" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label4" runat="server" Text="Sub Category Code"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtSubCategoryCode" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label1" runat="server" Text="Sub Category Name"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtSubCategoryName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group" style="display:none;>

                        <div class="control-left">
                            <asp:Label ID="Label3" runat="server" Text="Category Name"></asp:Label>
                        </div>
                        <div class="control-right" style="display:none;>
                            <asp:DropDownList ID="ddlCategoryName" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="button-control">
                    <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkSave_Click" OnClientClick="return ValidateForm()">Save</asp:LinkButton>
                    <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncclearForm();return false;">Clear</asp:LinkButton>
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
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter SubCategory Name  To Search"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:LinkButton ID="lnkSearchGrid" runat="server" class="button-blue" Width="100px" Style="visibility: hidden"
                                        OnClick="lnkSearchGrid_Click" Text="Search"><i class="icon-play"></i></asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <asp:GridView ID="gvSubCategory" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="True">
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
                            <asp:BoundField DataField="SubCategoryCode" HeaderText="SubCategory Code"></asp:BoundField>
                            <asp:BoundField DataField="SubCategoryName" HeaderText="SubCategory Name"></asp:BoundField>                            
                            <asp:BoundField DataField="CategoryName" HeaderText="CategoryName"></asp:BoundField>
                            <asp:BoundField DataField="CategoryId" HeaderText="CategoryId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <ups:PaginationUserControl runat="server" ID="SubCategoryMasterPagination" OnPaginationButtonClick="SubCategory_PaginationButtonClick" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <asp:HiddenField ID="hdSubCategoryCode" runat="server" Value="" />
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
