<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetTransfer.aspx.cs" Inherits="AssetMobileApplication.Asset.frmAssetTransfer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%=txtAssignedDate.ClientID %>"));
            });
        }
        function SetDefaultDate(AssignedDate)
        {
            AssignedDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
            if (AssignedDate.val() === '') {
                AssignedDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
            }
        }
        function fncSaveVAlidation() {
                var status = true;
                if ($("#<%=txtAssetCode.ClientID%>").val() == '')
                {
                    ShowPopupMessageBox('Please Enter Asset Code');
                    $("#<%=txtAssetCode.ClientID%>").select().focus();
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
            $('#<%=txtComments.ClientID %>').val() == ''
            pageLoad();
        }
        function fncAssetCodeScan(event) {
            
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtAssetCode.ClientID %>').val() == '') {
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
    <%--<div class="main-container" style="overflow: hidden">--%>
        <div class="container-fluid">
            <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Assets</a></li>
                <li><a href="javascript:void(0);">Assets Transfer</a></li>
            </ol>
        </div>
            <div class="col-md-12">

                <%--<div class="control-group" role="tabpanel" id="divAssetTransfer" style="background-color: #fff; color: black; font-weight: bolder;">
                    <div class="col-md-12">
                        <asp:Label ID="Label33" runat="server" Text="Asset Transfer"></asp:Label>
                    </div>
                </div>--%>

                <div style="border: 1px solid green;">
                    <div class="container-group-top">
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label1" runat="server" Text="Asset Code"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetCode" onkeydown="return fncAssetCodeScan(event);" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:LinkButton ID="lnkAssetCodeScan" runat="server" OnClick="lnkAssetCodeScan_Click" style="display:none;" CssClass="btn btn-success waves-effect">Transfer</asp:LinkButton>
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
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label3" runat="server" Text="Department"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlDepartment" onchange="" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label8" runat="server" Text="Employee"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label2" runat="server" Text="Block Name"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlBlockName" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label4" runat="server" Text="Floor Name"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlFloorName" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label6" runat="server" Text="Room No"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlRoomNo" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <%--<div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label7" runat="server" Text="Cubical"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlCubical" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>--%>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label9" runat="server" Text="Assigned By"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:DropDownList ID="ddlAssignedBy" runat="server" CssClass="form-control"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label11" runat="server" Text="Assigned Date"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssignedDate" onfocus="blur();" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label10" runat="server" Text="Comments"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtComments" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="button-control">
                            <asp:LinkButton ID="lnkTransfer" runat="server" OnClick="lnkTransfer_Click" OnClientClick="return fncSaveVAlidation();" CssClass="btn btn-success waves-effect">Transfer</asp:LinkButton>
                        </div>
                    </div>
            </div>
            </div>

        </div>
    <%--</div>--%>
</asp:Content>
