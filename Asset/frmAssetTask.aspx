<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetTask.aspx.cs" Inherits="AssetMobileApplication.Asset.frmAssetTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {

            $("select").chosen({ width: '100%' }); // width in px, %, em, etc 
        }
        function fncValidation() {
            var status = true;
            try {
                if ($('#<%=ddlTask.ClientID %>').val() == '0') {
                    ShowPopupMessageBox('Please Select Task');
                    status = false;
                }
                else if ($('#<%=ddlLocation.ClientID %>').val() == '0') {
                    ShowPopupMessageBox('Please Select Location'); 
                    status = false;
                }
                return status;
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }
        function fncClear() {
            $('#<%= ddlLocation.ClientID %>').val('0');
            $('#<%=ddlLocation.ClientID %>').trigger("liszt:updated");
            $('#<%= ddlTask.ClientID %>').val('0');
            $('#<%=ddlTask.ClientID %>').trigger("liszt:updated");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Assets</a></li>
                <li><a href="javascript:void(0);">Asset Verification</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label1" runat="server" Text="Task"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlTask" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-left">
                            <asp:Label ID="Label5" runat="server" Text="Location"></asp:Label>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="button-control">
                    <asp:LinkButton ID="lnkGo" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkGo_Click" OnClientClick="return fncValidation()">Go</asp:LinkButton>
                    <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClick="lnkClear_Click">Clear</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
