<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmUserRights.aspx.cs" Inherits="AssetMobileApplication.UserAccess.frmUserRights" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function clearForm() {
            $(':input').not(':button, :submit, :reset, :hidden, :checkbox, :radio').val('');
            $(':checkbox, :radio').prop('checked', false);
        }
        function pageLoad() {
            $("select").chosen({ width: '100%' }); // width in px, %, em, etc 
            $("input[type=checkbox]").addClass("filled-in chk-col-indigo");
        }
        function fncclearForm() {
            window.location = "../UserAccess/frmUserRights.aspx";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">User Access</a></li>
                <li><a href="javascript:void(0);">User Rights</a></li>
            </ol>
        </div>

        <div class="container-group-top">
            <div class="control-group">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label1" runat="server" Text="User Group Name"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlUserGroup" runat="server" CssClass="form-control" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlUserGroup_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12">
            <div style="height: 450px; overflow: auto;">
                <div class="container-group-top">
                    <div class="control-group">
                        <asp:GridView ID="gvFormRights" runat="server" AllowSorting="true" Width="100%" AutoGenerateColumns="False"
                            ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" DataKeyNames="FormID">
                            <EmptyDataTemplate>
                                <asp:Label ID="Label3" runat="server" Text="No Records Found"></asp:Label>
                            </EmptyDataTemplate>
                            <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                            <RowStyle CssClass="pshro_GridDgnStyle" />
                            <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                            <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
                            <PagerStyle CssClass="pshro_text" />
                            <Columns>                                
                                <asp:BoundField DataField="SNo" HeaderText="S.No"></asp:BoundField>
                                <asp:BoundField DataField="FormID" HeaderText="Form ID" ItemStyle-CssClass="hiddencol"
                                    HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                                <asp:BoundField DataField="FormName" HeaderText="Form Name"></asp:BoundField>                                
                                <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" Checked='<%# Eval("Permission") %>' Text=" " />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

            </div>
        </div>
        <div class="col-md-12">
            <div class="control-group">
                <div class="button-contol">
                    <asp:LinkButton ID="lnkUpdate" runat="server" CssClass="btn btn-primary waves-effect" OnClick="lnkUpdate_Click">Update</asp:LinkButton>
                    <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncclearForm();return false;">Clear</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
