<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MainMaster.Master" CodeBehind="Assethistory.aspx.cs" Inherits="AssetMobileApplication.Reports.Assethistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                SetDefaultDate($("#<%= txtFromDate.ClientID %>"), $("#<%= txtToDate.ClientID %>"));
            });
        }
        function SetDefaultDate(FromDate, ToDate) {
            try {
                FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });

                if (FromDate.val() === '') {
                    FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
                }
                if (ToDate.val() === '') {
                    ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncAssetAuditValidation() {
            var status = true, Location = '', Department = '', Block = '', Floor = '',
                Room = '', Cubical = '', Employee = '';
            try {
             <%--<%-- <%--  Location = $('#<%=ddlLocation.ClientID %>').val();
                Department = $('#<%=ddlDepartment.ClientID %>').val();
                Block = $('#<%=ddlBlockName.ClientID %>').val();
                Floor = $('#<%=ddlFloorName.ClientID %>').val();
                Room = $('#<%=ddlRoom.ClientID %>').val();
                Cubical = $('#<%=ddlCubical.ClientID %>').val();--%>
                <%--Employee = $('#<%=ddlEmployee.ClientID %>').val();--%>
               if (Location == '0' || Location == '--Select--') {
                    ShowPopupMessageBox('Please Select Location');
                    status = false;
                }
                else if (Department == '0' || Department == '--Select--') {
                    ShowPopupMessageBox('Please Select Department');
                    status = false;
                }
                else if (Block == '0' || Block == '--Select--') {
                    ShowPopupMessageBox('Please Select Block');
                    status = false;
                }
                else if (Floor == '0' || Floor == '--Select--') {
                    ShowPopupMessageBox('Please Select Floor');
                    status = false;
                }
                else if (Room == '0' || Room == '--Select--') {
                    ShowPopupMessageBox('Please Select Room');
                    status = false;
                }
                else if (Cubical == '0' || Cubical == '--Select--') {
                    ShowPopupMessageBox('Please Select Cubical');
                    status = false;
                }
                else if (Employee == '0' || Employee == '--Select--') {
                    ShowPopupMessageBox('Please Select Employee');
                    status = false;
                }
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
                <li><a href="javascript:void(0);">Reports</a></li>
                <li><a href="javascript:void(0);">Asset History Report</a></li>
            </ol>
        </div>
         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="container-group-top border-style">
                            <div class="col-md-12">
                                <div class="col-md-4" style="display:none">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label13" runat="server" Text="From Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtFromDates" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                  <div class="col-md-4" >
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label2" runat="server" Text="Asset Code"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                             <asp:DropDownList ID="ddlAssetCode" runat="server"  onSelectedIndexChanged="LoadLocationInBlock" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                  <div class="col-md-4" >
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label3" runat="server" Text="Asset Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                             <asp:DropDownList ID="ddlAssetName" runat="server" CssClass="form-control" ></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                    <div class="col-md-4" style="display:none">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label4" runat="server" Text="Stage Code"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                             <asp:DropDownList ID="ddlstageCode" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4" style="display:none">
                                    <div class="control-group" >
                                        <div class="control-left">
                                            <asp:Label ID="Label1" runat="server" Text="To Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4" style="display:none">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="lblMethod" runat="server" Text="Method"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlMethod" runat="server" CssClass="form-control">
                                           <asp:listitem>--Select--</asp:listitem>                                           
                                          <asp:listitem>Assigned</asp:listitem>  
                                          <asp:listitem>UnAssigned</asp:listitem>  
                                            </asp:DropDownList>
                                                                
                              <div class="col-md-4" style="display:none">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label14" runat="server" Text="Location"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" style="display:none">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label15" runat="server" Text="Department"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label17" runat="server" Text="Block Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlBlockName" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label18" runat="server" Text="Floor Name"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlFloorName" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12" style="display:none">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label19" runat="server" Text="Room"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label20" runat="server" Text="Cubical"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlCubical" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label16" runat="server" Text="Employee"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlEmployee" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4" style="display:none">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="lblAuditCode" runat="server" Text="AuditId"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlAuditCode" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4" >
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label5" runat="server" Text="Date"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="button-control">
                                        <asp:LinkButton ID="lnkLoad" runat="server" OnClientClick="return fncAssetAuditValidation();" OnClick="lnkLoad_Click" CssClass="btn btn-success waves-effect">Fetch</asp:LinkButton>
                                        <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-warning waves-effect">Clear</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <div class="control-group">
                                <div class="col-md-6">
           <%--                         <asp:ImageButton ID="btnExcelExport" runat="server" ImageUrl="~/images/excel.PNG"  Style="margin-top: 5px" />--%>
                                    <%--<asp:ImageButton ID="imgbtnPdfExport" runat="server" ImageUrl="~/images/pdf_icon.png" OnClick="imgbtnPdfExport_Click" Style="margin-top: 5px" />--%>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div style="height: 250px; overflow: auto;">
                        <asp:GridView ID="gvAssetDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
    <EmptyDataTemplate>
        <asp:Label ID="Lbl2" runat="server" Text="No Records Found"></asp:Label>
    </EmptyDataTemplate>
    <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
    <RowStyle CssClass="pshro_GridDgnStyle" />
    <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
    <PagerStyle CssClass="pshro_text" />
    <Columns>

  <asp:BoundField DataField="CreatedDate" HeaderText="Date" />
  <asp:BoundField DataField="AssetCode" HeaderText="AssetCode" />
        <asp:BoundField DataField="GRNNO" HeaderText="GRNNO" />
        <asp:BoundField DataField="RequestId" HeaderText="RequestId" />
        <asp:BoundField DataField="Description" HeaderText="AssetName" />
        <asp:BoundField DataField="StageCode" HeaderText="StageCode" />
      
    </Columns>
</asp:GridView>

 

                            </div>
                        </div>
                                                      
                    </div>

                </div>
            </div>
        </div>
    </div>
            
                          </ContentTemplate>
        <Triggers>
<asp:AsyncPostBackTrigger ControlID="ddlAssetCode" EventName="SelectedIndexChanged" />          
        </Triggers>
    </asp:UpdatePanel>

</asp:Content>