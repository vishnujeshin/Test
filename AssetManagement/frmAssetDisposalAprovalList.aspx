<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetDisposalAprovalList.aspx.cs" Inherits="AssetMobileApplication.AssetManagement.frmAssetDisposalAprovalList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function fncClearForm() {
            window.location = "../AssetManagement/frmAssetDisposalAprovalList.aspx";
        }
        function fncGetAssetforRvert(source)
        {
            var row;
            try
            {
                row = $(source).closest("tr");
                $('#<%=hdAssetCode.ClientID %>').val($("td", row).eq(0).html().replace(/&nbsp;/g, ''));
            }
            catch (err)
            {
                return false;
                ShowToastError(err.message);
            }
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Asset Management</a></li>
                <li><a href="../AssetManagement/frmAssetDisposal.aspx">Asset Disposal</a></li>
                <li><a href="javascript:void(0);">Asset Disposal Approval List</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="lblAssetDisposalDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="Asset Disposal Details"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="control-group">
                            <div style="height: 450px; overflow: auto;">
                                <asp:GridView ID="gvAssetDisposalList" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                                        <asp:BoundField DataField="AssetCode" HeaderText="Asset Code"></asp:BoundField>
                                        <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                        <asp:BoundField DataField="DisposedBy" HeaderText="Disposed By"></asp:BoundField>
                                        <asp:BoundField DataField="DisposedDate" HeaderText="Disposed Date"></asp:BoundField>
                                        <asp:TemplateField HeaderText="Dispose">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkDispose" runat="server" Text=" " />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Revert">
                                            <ItemTemplate>
                                                <asp:Button Text="Revert" ID="gvbtnRevert" runat="server" OnClientClick="return fncGetAssetforRvert(this);" OnClick="gvbtnRevert_Click" class="Icon-Btn" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="button-control">
                                <asp:LinkButton ID="lnkDispose" runat="server" OnClientClick="return fncDCReturnVAlidation();" OnClick="lnkDispose_Click" CssClass="btn btn-success waves-effect">Dispose</asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" OnClientClick="fncClearForm();return false;" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="hdAssetCode" runat="server" Value="" />
    </div>
</asp:Content>
