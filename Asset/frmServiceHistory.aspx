<%@ Page Title="" Language="C#"  MasterPageFile="~/MainMaster.Master"  AutoEventWireup="true" CodeBehind="frmServiceHistory.aspx.cs" Inherits="AssetMobileApplication.Asset.frmServiceHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function fncAssignExcelFiletoTextbox() {
            try {
                var prnfile = document.getElementById("<%=FileUploadexcel.ClientID %>");
                var prnfileName = document.getElementById("<%=FileUploadexcel.ClientID %>").files[0].name;
                if (prnfile.files.length == 0) {
                    $('#<%=txtfilename.ClientID %>').val('');
                }
                else {
                    $('#<%=txtfilename.ClientID %>').val(prnfileName);
                }
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }

        function fncBrowseClick() {
            try {
                $("#<%=FileUploadexcel.ClientID%>").click();
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }

        function fncMessageBox(msg) {
            alert(msg);
            $('#<%=txtfilename.ClientID %>').val('');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Assets</a></li>
                <li><a href="javascript:void(0);">View Asset</a></li>
                <li><a href="javascript:void(0);">Service History</a></li>
            </ol>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
            <ContentTemplate>
                <div id="divGeneral">
                    <div class="control-group">
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <div class="control-left">
                                    <asp:Label ID="Label1" runat="server" Text="Asset Code"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetCode" runat="server" ReadOnly="true" Width="80%" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="control-left">
                                    <asp:Label ID="Label2" runat="server" Text="Asset Name"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetName" runat="server" ReadOnly="true" Width="80%" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>



                </div>
                <div class="container-group">
                    <div class="container-group-top" style="width: 50%; margin-top:15px;">
                        <div class="col-md-12">
                            <div class="col-md-9 control-left" style="margin-top: 3px;">
                                <asp:TextBox runat="server" ID="txtfilename" AutoComplete="off" CssClass="form-control" Placeholder="Excel File Name" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-9 control-left" style="margin-top: 3px;">
                                <asp:TextBox runat="server" ID="txtremarks" AutoComplete="off" CssClass="form-control" Placeholder="Remarks" MaxLength="500" onClick="this.select();"></asp:TextBox>
                                <asp:LinkButton ID="LinkButton1" runat="server"></asp:LinkButton>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="col-md-4 control-right" style="float: right; margin-top: 10px;">
                                <asp:Button ID="btnBrowse" runat="server" CssClass="btn btn-primary waves-effect" Text="Browse" data-toggle="tooltip" title="click to Browse the Excel Sheet"
                                    OnClientClick="fncBrowseClick();return false;" />
                                <asp:FileUpload ID="FileUploadexcel" runat="server" Style="display: none"
                                    accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"
                                    onchange="return fncAssignExcelFiletoTextbox();"></asp:FileUpload>
                                <asp:LinkButton runat="server" ID="btnImport" CssClass="btn btn-success waves-effect" data-toggle="tooltip"
                                    title="click to Import the selected File" OnClick="btnImport_Click">Import</asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnImport" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel4" runat="Server">
            <ContentTemplate>
                <div id="QCParentMaterial" style="margin-top:10px;">
                    <asp:GridView ID="gridServicehistory" runat="server" AutoGenerateColumns="False" ShowHeader="True" AllowPaging="false" PageSize="1"
                        ShowHeaderWhenEmpty="true" RowStyle-BackColor="#edf1fe" AlternatingRowStyle-BackColor="#c4ddff" CssClass="pshro_GridDgn"
                        HeaderStyle-CssClass="FixedHeader" Style="overflow: scroll">
                        <EmptyDataTemplate>
                            <asp:Label ID="Label3" runat="server" Text="No Warehouse Records Found"></asp:Label>
                        </EmptyDataTemplate>
                        <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast" PageButtonCount="4" />
                        <PagerStyle CssClass="pshro_text" />
                        <RowStyle CssClass="pshro_GridDgnStyle tbl_left" />
                        <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative tbl_left" />
                        <Columns>
                           <%-- <asp:TemplateField HeaderText="View">
                                <ItemTemplate>
                                    <a href="#" onclick="return fncopenGRN(this); return false;" data-toggle="tooltip" data-placement="right" title="Click to view Details"><span class="glyphicon glyphicon-eye-open"></span></a>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:BoundField DataField="MACHINENAME" HeaderText="MACHINE NAME"></asp:BoundField>
                            <asp:BoundField DataField="MACHINENO" HeaderText="MACHINE NO"></asp:BoundField>
                            <asp:BoundField DataField="CATEGORY" HeaderText="CATEGORY"></asp:BoundField>
                            <asp:BoundField DataField="DATEOFBREAKDOWN" HeaderText="DATEOFBREAKDOWN"></asp:BoundField>
                            <asp:BoundField DataField="DETAILSOFBREAKDOWN" HeaderText="DETAILSOFBREAKDOWN"></asp:BoundField>
                            <asp:BoundField DataField="CORRECTIVEACTION" HeaderText="CORRECTIVEACTION"></asp:BoundField>
                            <asp:BoundField DataField="DATEONCOMPLETION" HeaderText="DATEONCOMPLETION"></asp:BoundField>
                            <asp:BoundField DataField="PRTSREPLACED" HeaderText="PRTSREPLACED"></asp:BoundField>
                            <asp:BoundField DataField="STOPHRS" HeaderText="STOPHRS"></asp:BoundField>
                            <asp:BoundField DataField="SIGNATURE" HeaderText="SIGNATURE"></asp:BoundField>
                             <asp:BoundField DataField="REMARKS" HeaderText="REMARKS"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <asp:HiddenField ID="hiddenValueParentQCView" Value="" runat="server" />
                </div>
                <div class="hiddencol">
                    <asp:Button ID="btnEye" runat="server" />
                </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
