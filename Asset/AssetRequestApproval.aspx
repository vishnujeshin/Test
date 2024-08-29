<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="AssetRequestApproval.aspx.cs" Inherits="AssetMobileApplication.Asset.AssetRequestApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            fncSearchRequestId();
        }
        function clearForm() {
            $('#<%=txtRequestId.ClientID %>').attr('readonly', false);
            $('input[type=text]').val('');
            pageLoad();
        }
        function fncSearchRequestId() {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtRequestId.ClientID %>').val() == '')
                    event.preventDefault();
            }
            if ($('#<%=txtRequestId.ClientID %>').val() != '') {
                $("[id$=txtRequestId]").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("AssetRequestApproval.aspx/GetRequesId") %>',
                            data: "{ 'prefix': '" + request.term + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                response($.map(data.d, function (item) {
                                    return {
                                        label: item.split('|')[0],
                                        val: item.split('|')[1]
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
                        $('#<%=txtRequestId.ClientID %>').val($.trim(i.item.val));                     
                        $("#<%=btnFetchRequestDetails.ClientID%>").click();
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
            <%--if (keyCode == 13) {
                $('#<%=txtRequestId.ClientID %>').attr('readonly', true);
                $("#<%=btnFetchRequestDetails.ClientID%>").click();
                event.preventDefault();
            }--%>
        }
        function fncRequestApprovalVAlidation() {
            var status = true;
            try {
                if ($('#<%=txtRequestId.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Select Request Id');
                    status = false;
                }
                //else if ($("[id*=gvRequestDetails] tbody tr").length < 1) {
                //    ShowPopupMessageBox('There is no data for Approval..!');
                //    status = false;
                //}
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Asset Management</a></li>
                <li><a href="javascript:void(0);">Request Approval</a></li>
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
                                    <asp:TextBox ID="txtRequestId" onkeydown="return fncSearchRequestId(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:Button Text="" OnClick="btnFetchRequestDetails_Click" Style="display: none;" ID="btnFetchRequestDetails" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="control-group">
                                <div class="button-control" style="float: left !important; margin: 0px !important; padding-left: 2px !important">
                                    <asp:LinkButton ID="lnkClear" runat="server" OnClick="lnkClear_Click" CssClass="btn btn-warning waves-effect">Clear</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div style="height: 400px; overflow: scroll;">
                        <div class="control-group">
                            <asp:GridView ID="gvRequestDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="False">
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
                                  <%--  <asp:TemplateField HeaderText="Go">
                                            <ItemTemplate>
                                                <asp:Button Text="Go" OnClick="btnPickedPendingGo_Click" OnClientClick="return fncPickedPendingGo(this)" ID="btnPickedPendingGo" runat="server" class="Icon-Btn" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                    <asp:BoundField DataField="RequestId" HeaderText="Request Id"></asp:BoundField>
                                    <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                    <asp:BoundField DataField="AssetBrand" HeaderText="Asset Brand"></asp:BoundField>
                                    <asp:BoundField DataField="RequestBy" HeaderText="Requested By"></asp:BoundField>
                                    <asp:BoundField DataField="RequestDepartment" HeaderText="Requested Department"></asp:BoundField>
                                    <asp:BoundField DataField="RequestQty" HeaderText="Requested Qty"></asp:BoundField>
                                    <asp:BoundField DataField="RequestDate" HeaderText="Requested Date"></asp:BoundField>
                                    <asp:BoundField DataField="Remarks" HeaderText="Remarks"></asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="control-group">
                        <div class="button-control">
                            <asp:LinkButton ID="lnkAccept" runat="server" OnClientClick="return fncRequestApprovalVAlidation();" OnClick="lnkAccept_Click" CssClass="btn btn-success waves-effect">Accept</asp:LinkButton>
                            <asp:LinkButton ID="lnkReject" runat="server" OnClientClick="return fncRequestApprovalVAlidation();" OnClick="lnkReject_Click" CssClass="btn btn-warning waves-effect">Reject</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</asp:Content>
