<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmDashBord.aspx.cs" Inherits="AssetMobileApplication.DashBord.frmDashBord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header" style="padding-top: 13px; padding-left: 8px;">
            <h2>Dash Board</h2>
        </div>

        <!-- Widgets -->
        <div class="row mb-5">
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="info-box bg-pink hover-expand-effect">
                    <div class="icon">
                        <i class="material-icons">playlist_add_check</i>
                    </div>
                    <div class="content">
                        <div class="text">Total Assets</div>
                        <asp:Label ID="lblTotalAssetst" runat="server" Text="0" CssClass="number"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="info-box bg-amber hover-expand-effect">
                    <div class="icon">
                        <i class="material-icons">import_export</i>
                    </div>
                    <div class="content">
                        <div class="text">Assigned Assets</div>
                        <asp:Label ID="lblAssignedAssets" runat="server" Text="0" CssClass="number"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="info-box bg-green hover-expand-effect">
                    <div class="icon">
                        <i class="material-icons">help</i>
                    </div>
                    <div class="content">
                        <div class="text">Unassigned Assets</div>
                        <asp:Label ID="lblUnassignedAssets" runat="server" Text="0" CssClass="number"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="info-box bg-deep-purple hover-expand-effect">
                    <div class="icon">
                        <i class="material-icons">monetization_on</i>
                    </div>
                    <div class="content">
                        <div class="text">Total AssetCosts</div>
                        <asp:Label ID="lblTotalAssetCosts" runat="server" Text="0" CssClass="number"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="info-box bg-cyan hover-expand-effect">
                    <div class="icon">
                        <i class="material-icons">person_add</i>
                    </div>
                    <div class="content">
                        <div class="text">Total Employee</div>
                        <asp:Label ID="lblTotalEmployee" runat="server" Text="0" CssClass="number"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="info-box bg-light-green hover-expand-effect">
                    <div class="icon">
                        <i class="material-icons">location_on</i>
                    </div>
                    <div class="content">
                        <div class="text">Total Locations</div>
                        <asp:Label ID="lblTotalLocations" runat="server" Text="0" CssClass="number"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-3 col-sm-6 col-xs-12">
                <div class="info-box bg-orange hover-expand-effect">
                    <div class="icon">
                        <i class="material-icons">person</i>
                    </div>
                    <div class="content">
                        <div class="text">Total Vendors</div>
                        <asp:Label ID="lblTotalVendors" runat="server" Text="0" CssClass="number"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <!-- #END# Widgets -->
        <div>
            <div style="margin-top: 22%">
                <asp:GridView ID="gvDepartment" runat="server" Width="60%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn">
                    <EmptyDataTemplate>
                        <asp:Label ID="Lbl2" runat="server" Text="No Records Found"></asp:Label>
                    </EmptyDataTemplate>
                    <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                    <RowStyle CssClass="pshro_GridDgnStyle" />
                    <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                    <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" NextPageText="Next" PreviousPageText="Previous" Position="TopAndBottom" />
                    <PagerStyle CssClass="pshro_text" />
                    <Columns>
                        <asp:BoundField DataField="SNO" HeaderText="S.No"></asp:BoundField>
                        <asp:BoundField DataField="Subcategory" HeaderText="Subcategory"></asp:BoundField>
                        <asp:BoundField DataField="TotalAsset" HeaderText="TotalAsset"></asp:BoundField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </div>

    <!-- New GridView for Subcategory and Total Asset -->


    <%------------------------------------------------------------ JS File ------------------------------------------------------------%>
    <!-- Custom Js -->
    <script type="text/javascript" src="../js/pages/index.js"></script>
    <!-- Jquery CountTo Plugin Js -->
    <script type="text/javascript" src="../plugins/jquery-countto/jquery.countTo.js"></script>
    <!-- Morris Plugin Js -->
    <script type="text/javascript" src="../plugins/raphael/raphael.min.js"></script>
    <script type="text/javascript" src="../plugins/morrisjs/morris.js"></script>
    <!-- ChartJs -->
    <script type="text/javascript" src="../plugins/chartjs/Chart.bundle.js"></script>
    <!-- Flot Charts Plugin Js -->
    <script type="text/javascript" src="../plugins/flot-charts/jquery.flot.js"></script>
    <script type="text/javascript" src="../plugins/flot-charts/jquery.flot.resize.js"></script>
    <script type="text/javascript" src="../plugins/flot-charts/jquery.flot.pie.js"></script>
    <script type="text/javascript" src="../plugins/flot-charts/jquery.flot.categories.js"></script>
    <script type="text/javascript" src="../plugins/flot-charts/jquery.flot.time.js"></script>
    <!-- Sparkline Chart Plugin Js -->
    <script type="text/javascript" src="../plugins/jquery-sparkline/jquery.sparkline.js"></script>
</asp:Content>
