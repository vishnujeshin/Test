<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmUserGroupMaster.aspx.cs" Inherits="AssetMobileApplication.UserAccess.frmUserGroupMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $("select").chosen({ width: '100%' }); // width in px, %, em, etc 
            $("input[type=checkbox]").addClass("filled-in chk-col-indigo");
        }
        function imgbtnEdit_ClientClick(source) {
            var row;
            try {
                row = $(source).closest("tr");
                $('#<%=txtUserGroupName.ClientID %>').attr('readonly', true);
                $('#<%=txtUserGroupName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
                $('#<%=txtRemarks.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                $('#<%=hdUserGroupId.ClientID %>').val($("td", row).eq(5).html().replace(/&nbsp;/g, ''));
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function imgbtnDelete_ClientClick(source) {
            try {
                var row = $(source).closest("tr");
                $('#<%=hdUserGroup.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
                $('#<%=hdUserGroupId.ClientID %>').val($("td", row).eq(5).html().replace(/&nbsp;/g, ''));
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function ValidateForm() {
            var status = true;
            try
            {
                if ($("#<%=txtUserGroupName.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter User Group Name');
                    status = false;
                }
            }
            catch (err) {
                return false;
                ShowToastError(err.message);
            }
        return status;
        }
        function fncclearForm()
        {
            window.location = "../UserAccess/frmUserGroupMaster.aspx";
        }
        function Brand_Delete(source) {



            $("#dialog-confirm").dialog({
                resizable: false,
                height: "auto",
                width: 400,
                modal: true,
                buttons: {
                    "YES": function () {
                        $(this).dialog("close");
                        $('#<%=hdUserGroupId.ClientID %>').val($("td", $(source).closest("tr")).eq(5).html().replace(/&nbsp;/g, ''));

                                $("#<%= btnDelete.ClientID %>").click();
                            },
                            "NO": function () {
                                $(this).dialog("close");
                                return false();
                            }
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
                <li><a href="javascript:void(0);">User Access</a></li>
                <li><a href="javascript:void(0);">User Group Master</a></li>
            </ol>
        </div>
        <asp:UpdatePanel ID="updtPnltopbrand" UpdateMode="Conditional" runat="Server">
            <ContentTemplate>
        <div class="control-group">
            <div class="col-md-6">
                <div class="container-group-top">
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label1" runat="server" Text="User Group Name"></asp:Label><span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtUserGroupName" onFocus="this.select()" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label2" runat="server" Text="Remarks"></asp:Label>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtRemarks" onFocus="this.select()" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="button-control">
                                <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkSave_Click" OnClientClick="return ValidateForm()">Save</asp:LinkButton>
                                <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncclearForm();return false;">Clear</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                            <div class="container-group-top">
                                <asp:GridView ID="gvUserGroup" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn"
                                    PageSize="10" OnPageIndexChanging="gvUserGroup_PageIndexChanging" AllowPaging="True">
                                    <EmptyDataTemplate>
                                        <asp:Label ID="Lbl2" runat="server" Text="No Records Found"></asp:Label>
                                    </EmptyDataTemplate>
                                    <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                                    <RowStyle CssClass="pshro_GridDgnStyle" />
                                    <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                        NextPageText="Next" PreviousPageText="Previous" />
                                    <PagerStyle CssClass="pshro_text" />
                                    <Columns>
                                        <asp:BoundField DataField="SNo" HeaderText="S.No"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Edit">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images/edit-icon_Old.png" OnClientClick="imgbtnEdit_ClientClick(this); return false;"
                                                    CommandName="Select" ToolTip="Click here to Edit" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images/delete.png"  OnClientClick="return Brand_Delete(this);"
                                                    CommandName="Select" ToolTip="Click here to Delete" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="UserGroupName" HeaderText="User Group Name"></asp:BoundField>
                                        <asp:BoundField DataField="Remarks" HeaderText="Is Active"></asp:BoundField>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    
            </div>
        </div>
         <div id="dialog-confirm" style="display: none;" title="Enterpriser Web">
                    <p><span class="ui-icon ui-icon-alert" style="float: left; display: none; margin: 12px 12px 20px 0;"></span>These items will be permanently deleted and cannot be recovered. Are you sure?</p>
                </div>
        <asp:HiddenField ID="hdUserGroup" runat="server" Value="" />
        <asp:HiddenField ID="hdUserGroupId" runat="server" Value="" />
        <asp:Button ID="btnDelete" runat="server" OnClick ="btnDelete_Click" style="display:none"/>
    </div>
                  </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
