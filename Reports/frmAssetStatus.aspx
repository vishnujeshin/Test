<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="frmAssetStatus.aspx.cs" Inherits="AssetMobileApplication.Reports.frmAssetStatusReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            $(function () {
                <%--SetDefaultDate($("#<%= txtFromDate.ClientID %>"), $("#<%= txtToDate.ClientID %>"));--%>
            });
        }
        //function SetDefaultDate(FromDate, ToDate) {
        //    try {
        //        FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });
        //        ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, });

        //        if (FromDate.val() === '') {
        //            FromDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
        //        }
        //        if (ToDate.val() === '') {
        //            ToDate.datepicker({ dateFormat: "dd/mm/yy", changeMonth: true, changeYear: true, showButtonPanel: true, }).datepicker("setDate", "today");
        //        }
        //    }
        //    catch (err) {
        //        ShowToastError(err.message);
        //    }
        //}
        function fncAssetAuditValidation() {
           var status = true <%--, Location = '', Department = '', Employee = '', Brand = '',
                Category = '', SubCategory = '', Vendor = '';
            try {
                Location = $('#<%=ddlLocation.ClientID %>').val();
                Department = $('#<%=ddlDepartment.ClientID %>').val();
                Employee = $('#<%=ddlEmployee.ClientID %>').val();
                Brand = $('#<%=ddlBrand.ClientID %>').val();
                Category = $('#<%=ddlCategory.ClientID %>').val();
                SubCategory = $('#<%=ddlSubCategory.ClientID %>').val();
                Vendor = $('#<%=ddlVendor.ClientID %>').val();--%>
               
                <%--if ($('#<%=txtFromDate.ClientID %>').val() == '' || $('#<%=txtToDate.ClientID %>').val() == '')
                {
                    ShowPopupMessageBox('Please Select Date');
                    status = false;
                }--%>
            //    if (Location == '0' || Location == '--Select--') {
            //        ShowPopupMessageBox('Please Select Location');
            //        status = false;
            //    }
            //    else if (Department == '0' || Department == '--Select--') {
            //        ShowPopupMessageBox('Please Select Department');
            //        status = false;
            //    }
            //    else if (Employee == '0' || Employee == '--Select--') {
            //        ShowPopupMessageBox('Please Select Employee');
            //        status = false;
            //    }
            //    else if (Brand == '0' || Brand == '--Select--') {
            //        ShowPopupMessageBox('Please Select Brand');
            //        status = false;
            //    }
            //    else if (Category == '0' || Category == '--Select--') {
            //        ShowPopupMessageBox('Please Select Category');
            //        status = false;
            //    }
            //    else if (SubCategory == '0' || SubCategory == '--Select--') {
            //        ShowPopupMessageBox('Please Select SubCategory');
            //        status = false;
            //    }
            //    else if (Vendor == '0' || Vendor == '--Select--') {
            //        ShowPopupMessageBox('Please Select Vendor');
            //        status = false;
            //    }
            //}
            //catch (err) {
            //    status = false;
            //    ShowToastError(err.message);
            //}
            return status;
        }
        function fncDCReportValidation() {
            var status = true;
            try {
                if ($('#<%=ddlstatus.ClientID %>').val() == '0' || $('#<%=ddlstatus.ClientID %>').val() == '--Select--') {
                    ShowPopupMessageBox('Please Select Status');
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
    <div class="container-fluid" style="overflow:hidden">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Reports</a></li>
                <li><a href="javascript:void(0);">Asset Status</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12"  style="width:74%">
                        <div class="container-group-top border-style" style="width:84%">
                            <div class="col-md-12">
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label14" runat="server" Text="Location"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
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
                                            <asp:Label ID="Label16" runat="server" Text="Employee"></asp:Label>
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
                                            <asp:Label ID="Label1" runat="server" Text="Brand"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label17" runat="server" Text="Category"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label18" runat="server" Text="SubCategory"></asp:Label>
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
                                            <asp:Label ID="Label19" runat="server" Text="Vendor"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlVendor" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label2" runat="server" Text="Room"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                               <%-- <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label20" runat="server" Text="Status"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                            <%--<asp:RadioButton ID="rdoInUse" runat="server" Text="In Use"></asp:RadioButton>
                                            <asp:RadioButton ID="rdoNotInUse" runat="server" Text="Not In Use"></asp:RadioButton>
                                            <asp:RadioButton ID="rdoDamaged" runat="server" Text="Damaged"></asp:RadioButton>--%>
                                          <%--  <asp:RadioButtonList ID="rdoAssetStatus" RepeatDirection="Horizontal" runat="server">
                                                <asp:ListItem Selected="True" Value="1">InUse</asp:ListItem>
                                                <asp:ListItem Selected="False" Value="2">Not In Use</asp:ListItem>
                                                <asp:ListItem Selected="False" Value="3">Damaged</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                </div>--%>
                                 <div class="col-md-4">
                                    <div class="control-group">
                                        <div class="control-left">
                                            <asp:Label ID="Label3" runat="server" Text="Status"></asp:Label>
                                        </div>
                                        <div class="control-right">
                                              <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control">
                                                <asp:ListItem>--Select--</asp:ListItem>
                                                <asp:ListItem Value="" >All</asp:ListItem>
                                                <asp:ListItem Value="1">In Use</asp:ListItem>
                                                  <asp:ListItem Value="2">Not In Use</asp:ListItem>
                                                  <asp:ListItem Value="3">Damage</asp:ListItem>
                                                  <asp:ListItem Value="4">Disposed</asp:ListItem>
                                                  <asp:ListItem Value="5">In-Store</asp:ListItem>
                                                  <asp:ListItem Value="6">Ready to Deploy</asp:ListItem>
                                                  <asp:ListItem Value="7">Donation</asp:ListItem>
                                                  <asp:ListItem Value="8">E-Waste</asp:ListItem>
                                                  <asp:ListItem Value="9">In-Stock</asp:ListItem>
                                                  <asp:ListItem Value="10">Installed Office</asp:ListItem>
                                                  <asp:ListItem Value="11">IT Store</asp:ListItem>
                                                  <asp:ListItem Value="12">Temp for Project</asp:ListItem>
                                                  <asp:ListItem Value="13">Under IT</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-12">
                                <div class="control-group">
                                    <div class="button-control">
                                        <asp:LinkButton ID="lnkLoad" runat="server" OnClientClick="return fncDCReportValidation();" OnClick="lnkLoad_Click" CssClass="btn btn-success waves-effect">Load</asp:LinkButton>
                                        <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="col-md-12">
                            <div class="control-group">
                                <div class="col-md-6">
                                    <asp:ImageButton ID="btnExcelExport" runat="server" ImageUrl="~/images/excel.PNG" OnClick="btnExcelExport_Click" Style="margin-top: 5px" />
                                    <%--<asp:ImageButton ID="imgbtnPdfExport" runat="server" ImageUrl="~/images/pdf_icon.png" OnClick="imgbtnPdfExport_Click" Style="margin-top: 5px" />--%>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div style="height: 300px; width:74%;overflow:scroll">
                                <asp:GridView ID="gvAssetDetails" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="false">
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
                                  <%--      <asp:BoundField DataField="Sno" HeaderText="Sno"></asp:BoundField>--%>
                                        <asp:BoundField DataField="AssetCode" HeaderText="Asset Code" ItemStyle-CssClass="LAssetCode"></asp:BoundField>
                                        <asp:BoundField DataField="AssetName" HeaderText="AssetName"></asp:BoundField>
                                        <asp:BoundField DataField="Model" HeaderText="Model"></asp:BoundField>
                                        <asp:BoundField DataField="SerialNo" HeaderText="Serial No"></asp:BoundField>
                                        <asp:BoundField DataField="WarrantyStartDate" HeaderText="Warranty Start Date"></asp:BoundField>
                                        <asp:BoundField DataField="WarrantyEndDate" HeaderText="Warranty End Date"></asp:BoundField>
                                        <asp:BoundField DataField="StatusName" HeaderText="AssetStatus"></asp:BoundField>
                                        <asp:BoundField DataField="DepartmentName" HeaderText="DepartmentName"></asp:BoundField>
                                        <asp:BoundField DataField="EmployeeName" HeaderText="EmployeeName"></asp:BoundField>
                                        <asp:BoundField DataField="LocationName" HeaderText="LocationName"></asp:BoundField>
                                        <asp:BoundField DataField="Brandname" HeaderText="Brandname"></asp:BoundField>
                                        <asp:BoundField DataField="categoryName" HeaderText="categoryName"></asp:BoundField>
                                        <asp:BoundField DataField="SubcategoryName" HeaderText="SubcategoryName"></asp:BoundField>
                                        <asp:BoundField DataField="vendorname" HeaderText="vendorname"></asp:BoundField>
                                        <asp:BoundField DataField="Unit" HeaderText="Unit"></asp:BoundField>
                                        <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice"></asp:BoundField>
                                        <asp:BoundField DataField="PurchasePrice" HeaderText="PurchasePrice"></asp:BoundField>
                                        <asp:BoundField DataField="BlockName" HeaderText="BlockName"></asp:BoundField>
                                        <asp:BoundField DataField="FloorName" HeaderText="FloorName"></asp:BoundField>
                                        <asp:BoundField DataField="RoomName" HeaderText="RoomName"></asp:BoundField>
                                        <asp:BoundField DataField="Cubicalname" HeaderText="Cubicalname"></asp:BoundField>
                                        <asp:BoundField DataField="CreatedUser" HeaderText="CreatedUser"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
