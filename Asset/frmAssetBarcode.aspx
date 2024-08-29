<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetBarcode.aspx.cs" Inherits="AssetMobileApplication.Asset.frmAssetBarcode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
              <%--  SetDefaultDate($("#<%= txtFromDate.ClientID %>"), $("#<%= txtToDate.ClientID %>"));--%>
            });
        }
        function SetDefaultDate(FromDate, ToDate) {
            try {
                FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });

                if (FromDate.val() === '') {
                    FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
                }
                if (ToDate.val() === '') {
                    ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncPrintVAlidation() {
            var status = true;
            if ($('#<%=ddlPrinter.ClientID %>').val() == '0' || $('#<%=ddlPrinter.ClientID %>').val() == '--Select--') {
                ShowPopupMessageBox('Please Select Printer Name');
                status = false;
            }
            return status;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="overflow: hidden" class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../Asset/frmAssetBarcode.aspx"><i class="material-icons">home</i>Assets</a></li>
                <li><a href="javascript:void(0);">Bulk Barcode</a></li>
            </ol>
        </div>
        <asp:UpdatePanel ID="Updatepanel1" runat="server">
            <ContentTemplate>


                <div class="col-md-12">
                    <div class="container-group-top">
                        <div class="control-group">
                            <div class="col-md-12">
                                <div class="container-group-top border-style">
                                    <div class="col-md-12">
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label14" runat="server" Text="Department"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label15" runat="server" Text="Category"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label17" runat="server" Text="SubCategory"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label18" runat="server" Text="Location"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label19" runat="server" Text="Employee"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="col-md-12">
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label5" runat="server" Text="From Asset"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlFromAsset" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label6" runat="server" Text="To Asset"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlToAsset" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <%--      <div class="col-md-12">
                                            <div class="col-md-4">
                                                <div class="control-group">
                                                    <div class="control-left">
                                                        <asp:Label ID="Label8" runat="server" Text="From Date"></asp:Label>
                                                    </div>
                                                    <div class="control-right">
                                                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="control-group">
                                                    <div class="control-left">
                                                        <asp:Label ID="Label9" runat="server" Text="To Date"></asp:Label>
                                                    </div>
                                                    <div class="control-right">
                                                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>--%>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="control-group">
                                            <div class="button-control">
                                                <asp:LinkButton ID="lnkLoad" OnClick="lnkLoad_Click" runat="server" CssClass="btn btn-success waves-effect">Load</asp:LinkButton>
                                                <asp:LinkButton ID="lnkCancel" OnClick="lnkCancel_Click" runat="server" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <asp:UpdatePanel ID="UpdatePanel5" runat="Server">
                                    <ContentTemplate>
                                        <div class="control-group">
                                            <div style="height: 250px; overflow: auto;">
                                                <asp:GridView ID="gvAssetDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" oncopy="return false" AllowPaging="false">
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
                                                        <asp:TemplateField HeaderStyle-Width="4%">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="chkSelectAll" runat="server" Text=" " AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:CheckBox ID="chkSelect" runat="server" Text=" " AutoPostBack="true" OnCheckedChanged="chkSelect_CheckedChanged" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                       <asp:BoundField DataField="AssetCode" HeaderText="Asset Code" />
                                                 <asp:BoundField DataField="AssetName" HeaderText="Asset Name" />                                                  
                                        <asp:BoundField DataField="DepartmentName" HeaderText="Department Name" />
                                        <asp:BoundField DataField="LocationName" HeaderText="Location Name" />
                                           <asp:BoundField DataField="SerialNo" HeaderText="Serial Number" />

                                                    </Columns>
                                                </asp:GridView>


                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="col-md-12">
                                        <div class="container-group-top border-style">
                                            <div class="col-md-4">
                                                <div class="control-group">
                                                    <div class="control-left">
                                                        <asp:Label ID="Label7" runat="server" Text="Printer Name"></asp:Label>
                                                    </div>
                                                    <div class="control-right">
                                                        <asp:DropDownList ID="ddlPrinter"  runat="server" CssClass="form-control"></asp:DropDownList>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div style="margin-left: 216px; width: 114px" class="control-group">
                                                    <div class="control-left">
                                                        <asp:LinkButton ID="butPrint" ToolTip="Print the Details" OnClick="butPrint_Click" OnClientClick="return fncPrintVAlidation();" runat="server" CssClass="btn btn-success waves-effect">Print</asp:LinkButton>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <asp:HiddenField ID="hdnXmlvalue" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
