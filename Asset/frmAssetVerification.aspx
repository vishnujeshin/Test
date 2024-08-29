<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetVerification.aspx.cs" Inherits="AssetMobileApplication.Asset.frmAssetVerification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function fncUpdateLocationConfirmationDialogOpen() {
            try {
                $("#divUpdateLocation").dialog({
                    resizable: false,
                    height: 150,
                    width: 340,
                    modal: true,
                    title: ""
                });
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }
        function fncUpdateLocationProcess() {
            $("#divUpdateLocation").dialog('close');
        }
        function fncUpdateLocationConfirmation() {
        try {
            $("#<%=lblUpdateLocation.ClientID %>").text('Asset Does Not Belongs to Location.Do you want to Move this Location?');
            fncUpdateLocationConfirmationDialogOpen();
        }
        catch (err) {
            ShowPopupMessageBox(err.message);
            //console.log(err.message);
        }
    }
        function fncAssetCodeScan(event) {
            fncAutocomplete();
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
        function fncBacktoPreviousForm() {
            window.location = "../Asset/frmAssetTask.aspx";
        }
        $(document).ready(function () {
            fncAutocomplete();
        });
        function fncAutocomplete() {
            $("[id$=txtAssetCode]").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: '<%=ResolveUrl("~/Asset/frmAssetVerification.aspx/GetAssetCode") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('/')[0],
                                    val: item.split('/')[0]
                                }
                            }))
                        },
                        error: function (response) {
                            ShowPopupMessageBox(response.responseText);
                        },
                        failure: function (response) {
                            ShowPopupMessageBox(response.responseText);
                        }
                    });
                },
                    select: function (event, i) {
                        $('#<%=txtAssetCode.ClientID %>').val($.trim(i.item.val));
                    document.getElementById("<%=lnkAssetCodeScan.ClientID %>").click();
                    event.preventDefault();
                },

                    minLength: 1
                });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
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
                        <%--<div class="col-md-12">
                        <asp:Label ID="lblhead" runat="server" Style="height: 30px; font-size: 20px; font-weight: bold;" Text=""></asp:Label>
                            </div>--%>
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="control-left">
                                    <asp:Label ID="Label1" runat="server" Text="Asset Code"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetCode" onkeydown="return fncAssetCodeScan(event);" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:LinkButton ID="lnkAssetCodeScan" runat="server" OnClick="lnkAssetCodeScan_Click" Style="display: none;" CssClass="btn btn-success waves-effect">Transfer</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12" runat="server" style="width: 100%; height: 150px; overflow: scroll">
                            <asp:GridView ID="gvAssetDetails" Width="100%" runat="server" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn">
                                <EmptyDataTemplate>
                                    <asp:Label ID="Label2" runat="server" Text="No Records Found"></asp:Label>
                                </EmptyDataTemplate>
                                <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                                <RowStyle CssClass="pshro_GridDgnStyle" />
                                <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                    NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
                                <PagerStyle CssClass="pshro_text" />
                                <Columns>
                                    <asp:BoundField DataField="SNo" HeaderText="S.No"></asp:BoundField>
                                    <asp:BoundField DataField="AssetCode" HeaderText="Asset Code"></asp:BoundField>
                                    <asp:BoundField DataField="Description" HeaderText="Asset Name"></asp:BoundField>
                                </Columns>
                            </asp:GridView>

                        </div>
                        <div class="button-control">
                            <asp:LinkButton ID="lnkSave" runat="server" OnClick="lnkSave_Click" CssClass="btn btn-success waves-effect">Partially Save</asp:LinkButton>
                            <asp:LinkButton ID="lnkBack" runat="server" OnClientClick="fncBacktoPreviousForm();return false" CssClass="btn btn-warning waves-effect">Back</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="divUpdateLocation" style="display: none;">
        <div>
            <asp:Label ID="lblUpdateLocation" runat="server"></asp:Label>
        </div>
        <div class="Dialog_Confirm_Center">
            <div class="Dialog_Confirm_yes">
                <asp:UpdatePanel ID="upDialog_Confirm" runat="server">
                    <ContentTemplate>
                        <asp:LinkButton ID="lnkbtnYes" runat="server" class="btn btn-success waves-effect" Text='Yes'
                            OnClientClick="fncUpdateLocationProcess();return true;" OnClick="lnkUpdateLocation_Click"> </asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="Dialog_Confirm_No">
                <asp:LinkButton ID="lnlbtnNo" runat="server" class="btn btn-warning waves-effect" Text='No'
                    OnClientClick="fncUpdateLocationProcess();return false;"> </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>
