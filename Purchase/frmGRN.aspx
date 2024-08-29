<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmGRN.aspx.cs" Inherits="AssetMobileApplication.Purchase.frmGRN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtPurchaseDate.ClientID %>"));
             });

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
                            url: '<%=ResolveUrl("frmGRN.aspx/GetRequesIdForGRN") %>',
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
                        $('#<%=txtRequestId.ClientID %>').attr('readonly', true);
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
        function fncAddAssetDetails() {
            var status = true, AssetBrand = '', Vendor='';
            try {
                AssetBrand = $('#<%=ddlAssetBrand.ClientID %>').val();
                Vendor = $('#<%=ddlVendor.ClientID %>').val();
                if ($('#<%=txtAssetName.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Enter Asset Name');
                    status = false;
                }
                else if (AssetBrand == '0' || AssetBrand == '--Select--') {
                    ShowPopupMessageBox('Please Select Asset Brand');
                    status = false;
                }
                else if (Vendor == '0' || Vendor == '--Select--') {
                    ShowPopupMessageBox('Please Select Vendor');
                    status = false;
                }
                else if ($('#<%=txtQty.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Enter Qty');
                    status = false;
                }
                else if ($('#<%=txtPrice.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Enter Price');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncCompleteGRNVAlidation()
        {
            var status = true;
            try {
                if ($('#<%=txtGRNNo.ClientID %>').val() == '') {
                    ShowPopupMessageBox('GRNNo should not be empty.');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncClearForm()
        {
            window.location = "../Purchase/frmGRN.aspx";
        }
        function fncDelete(source) {
            try {
                var data = $(source).closest("tr");
                $("#<%=hdGRNid.ClientID%>").val($("td", data).eq(1).html().replace(/&nbsp;/g, ''))
                $("#<%=hdReqid.ClientID%>").val($("td", data).eq(2).html().replace(/&nbsp;/g, ''))
                $('#<%=btnDelete.ClientID %>').click();
             }
             catch (err) {
                 ShowPopupMessageBox(err.message);
             }
        }

         function SetDefaultDate(PurchaseDate) {
            try {
                PurchaseDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
              
                if (PurchaseDate.val() === '') {
                    PurchaseDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "");
                }
               
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
                <li><a href="javascript:void(0);">Purchase</a></li>
                <li><a href="javascript:void(0);">GRN</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label2" runat="server" Text="GRN No"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtGRNNo" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label1" runat="server" Text="Request Id"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtRequestId" onkeydown="return fncSearchRequestId(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:Button Text="" OnClick="btnFetchRequestDetails_Click" Style="display: none;" ID="btnFetchRequestDetails" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1">
                            <div class="control-group">
                                <div class="button-control" style="margin: 0px !important; padding-left: 2px !important">
                                    <asp:LinkButton ID="lnkClear" runat="server" OnClick="lnkClear_Click" CssClass="btn btn-warning waves-effect">Clear</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="lblRequestDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="Request Details"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="control-group">
                            <%--<div class="button-control">
                                <asp:LinkButton ID="lnkAddNew" runat="server" OnClick="lnkClear_Click" CssClass="btn btn-success waves-effect">Add New</asp:LinkButton>
                            </div>--%>
                            <asp:GridView ID="gvRequestDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                    <div id="divAddNewAssets" class="col-md-12">
                        <div class="container-group-top">
                            <div class="control-group">
                                <div class="col-md-12">
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label4" runat="server" Text="Asset Name"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtAssetName" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label5" runat="server" Text="Asset Brand"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <%--<asp:TextBox ID="txtAssetBrand" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlAssetBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label3" runat="server" Text="Vendor"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label7" runat="server" Text="Requested Department"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <asp:DropDownList ID="ddlRequestDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>--%>
                                </div>
                                <div class="col-md-12">
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label8" runat="server" Text="Qty"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtQty" onkeypress="return fncAllowOnlyNumbers(event)" type="tel" runat="server" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label6" runat="server" Text="Price"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <asp:TextBox ID="txtPrice" runat="server" type="tel" onkeypress="return fncAllowOnlyNumbers(event)" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="control-group">
                                            <div class="control-left">
                                                <asp:Label ID="Label9" runat="server" Text="Purchase Date"></asp:Label>
                                            </div>
                                            <div class="control-right">
                                                <%--<asp:TextBox ID="txtPurchaseDate" runat="server" CssClass="form-control"></asp:TextBox>--%>
                                                <asp:TextBox ID="txtPurchaseDate" onfocus="blur();" runat="server" BackColor="White" CssClass="form-control"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>                                
                                </div>
                                <div class="col-md-12">
                                    <div class="control-group">
                                        <div class="button-control">
                                            <asp:LinkButton ID="lnkAddAssetDetails" runat="server" OnClientClick="return fncAddAssetDetails();" OnClick="lnkAddAssetDetails_Click" CssClass="btn btn-success waves-effect">Add</asp:LinkButton>
                                            <asp:LinkButton ID="lnkCancelAssetDetails" runat="server" OnClientClick="fncClearForm();return false;" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="lblGRNDetails" ForeColor="#3F51B5" Font-Bold="true" runat="server" Text="GRN Details"></asp:Label>
                            </div>
                        </div>
                    </div>
                                 <asp:UpdatePanel ID="updtPnltopbrand" UpdateMode="Conditional" runat="Server">
            <ContentTemplate>
                        <div class="col-md-12" style="height: 200px; overflow: auto;">
                            <div class="control-group">
                                <asp:GridView ID="gvGRNDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                                        <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images/delete.png" OnClientClick="return fncDelete(this);"
                                        CommandName="Select" ToolTip="Click here to Delete" />
                                </ItemTemplate>
                                  </asp:TemplateField>
                                        <asp:BoundField DataField="ID" HeaderText="ID" ></asp:BoundField>
                                        <asp:BoundField DataField="RequestID" HeaderText="RequestID" ></asp:BoundField>
                                        <asp:BoundField DataField="AssetName" HeaderText="Asset Name"></asp:BoundField>
                                        <asp:BoundField DataField="BrandName" HeaderText="Asset Brand"></asp:BoundField>
                                        <asp:BoundField DataField="Vendor" HeaderText="Vendor"></asp:BoundField>
                                        <asp:BoundField DataField="Qty" HeaderText="Qty"></asp:BoundField>
                                        <asp:BoundField DataField="Price" HeaderText="Price"></asp:BoundField>
                                        <asp:BoundField DataField="DeliveryNote" HeaderText="Delivery Note"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="control-group">
                            <div class="button-control">
                                <asp:LinkButton ID="lnkSaveGRN" runat="server" OnClientClick="return fncCompleteGRNVAlidation();" OnClick="lnkSaveGRN_Click" CssClass="btn btn-success waves-effect">Complete GRN</asp:LinkButton>
                                <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                       <asp:HiddenField ID="hdGRNid" runat="server" Value="" />
                       <asp:HiddenField ID="hdReqid" runat="server" Value="" />

                </div>
            </div>
        </div>

        <div class="hiddencol">

                    <asp:Button ID="btnDelete" runat="server" OnClick ="btnDelete_Click"/>

                </div>
    </div>
                    </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>
