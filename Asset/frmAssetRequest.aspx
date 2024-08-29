<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetRequest.aspx.cs" Inherits="AssetMobileApplication.Asset.frmAssetRequest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
        }
        function clearForm() {
            $('input[type=text]').val('');
            pageLoad();
        }
        function fncSendRequestVAlidation() {
            var status = true, RequestDepartment = '', AssetBrand = '';
            try {
                RequestDepartment = $("#<%=ddlRequestDepartment.ClientID%>").val();
                AssetBrand = $("#<%=ddlAssetBrand.ClientID%>").val();
                if ($("#<%=txtAssetName.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter Asset Name');
                    status = false;
                }
                else if (AssetBrand == '0' || AssetBrand == '--Select--') {
                    ShowPopupMessageBox('Please Select Asset Brand');
                    status = false;
                }
                else if ($("#<%=txtRequestBy.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter Request Person Name');
                    status = false;
                }
                else if (RequestDepartment == '0' || RequestDepartment == '--Select--') {
                    ShowPopupMessageBox('Please Select Request Department');
                    status = false;
                }
                else if ($("#<%=txtQty.ClientID%>").val() == '') {
                    ShowPopupMessageBox('Please Enter Asset Qty');
                    status = false;
                }

            }

            catch (err) {

                status = false;

                ShowToastError(err.message);

            }

            return status;

        }

        function fncAssetCodeScan(event) {

            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtAssetName.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Scan Asset Code');
                    return false;
                }
                else {
                      document.getElementById("<%=lnkAssetCodeScan.ClientID %>").click();
                      return false;
                  }
              }
          }



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Asset Management</a></li>
                <li><a href="javascript:void(0);">Asset Request</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label1" runat="server" Text="Request Id"></asp:Label> <span class="mandatory">*</span>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtRequestId" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label2" runat="server" Text="Asset Name"></asp:Label> <span class="mandatory">*</span>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetName" runat="server" onkeydown="return fncAssetCodeScan(event);" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label3" runat="server" Text="Asset Brand"></asp:Label> <span class="mandatory">*</span>
                                </div>
                                <div class="control-right">
                                    <%--<asp:TextBox ID="txtAssetBrand" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                    <asp:DropDownList ID="ddlAssetBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label6" runat="server" Text="Request By"></asp:Label> <span class="mandatory">*</span>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtRequestBy" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label7" runat="server" Text="Request Department"></asp:Label> <span class="mandatory">*</span>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlRequestDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label4" runat="server" Text="Qty"></asp:Label> <span class="mandatory">*</span>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtQty" onkeypress="return fncAllowOnlyNumbers(event)" type="tel" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="button-control">
                               
                                <asp:LinkButton ID="lnkSendRequest" runat="server" OnClientClick="return fncSendRequestVAlidation();" OnClick="lnkSendRequest_Click" CssClass="btn btn-success waves-effect">Send Request</asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                                <asp:LinkButton ID="lnkAssetCodeScan" runat="server" OnClick="lnkAssetCodeScan_Click" style="display:none;" CssClass="btn btn-success waves-effect">Transfer</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
