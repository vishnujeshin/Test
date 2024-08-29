<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmMainPage.aspx.cs" Inherits="AssetMobileApplication.Asset.frmMainPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        //function pageLoad() {
        //    $('#AssetImage').show();
        //}
      
        function showpreview(input) {
            try {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=imgpreview.ClientID %>').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function ImageForEdit() {
            debugger;
            $.ajax({

                type: "POST",
                url: "frmMainPage.aspx/GetImage",
                data: "{'AssetCode':'" + $('#<%=txtAssetCodeScan.ClientID %>').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        document.getElementById("<%=imgpreview.ClientID%>").src = "data:image/png;base64," + data.d[0];

                    },
                    error: function (data) {
                        ShowPopupMessageBox('Something Went Wrong')
                    }
                });
        }
        function showpreview(input) {
            try {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=imgpreview.ClientID %>').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function fncScanAssetCode(event) {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            try {
                if (keyCode == 13) {
                       <%--document.getElementById("<%=lnkAssetCodeScan.ClientID %>").click();--%>
                                if ($('#<%=txtAssetCodeScan.ClientID %>').val() != '') {
                                    //ImageForEdit();
                                    document.getElementById("<%=lnkAssetCodeScan.ClientID %>").click();
                    }

                    event.preventDefault();
                }
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }
        //function fncHideShowDivs()
        //{
        //    $('#ContentPlaceHolder1_div_Top').show();
        //    $('#ContentPlaceHolder1_div_Tabs').show();

        //    $('#ContentPlaceHolder1_div_AssetPurchaseDetailsGrid').hide();
        //    $('#ContentPlaceHolder1_div_AssetWarrantyDetailsGrid').hide();
        //    $('#ContentPlaceHolder1_div_AssetAMCDetailsGrid').hide();
        //    //$('#div_Tabs').show();
        //    return false;
        //}
        //$('#div').show();
        function fncSelect() {
            ShowPopupMessageBox('');
        }
        function fncTabClickEvent(data) {
            //$('#grdcolumndis').css("display", "block");
            if (data == 'Tab1') {
                $('#divGeneral').show();
                $('#divPurchaseDetails').hide();
                $('#divAMCDetails').hide();
                $('#divSupportDocument').hide();
                $('#AssetImage').show();
                $('#ContentPlaceHolder1_Tab1').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab2').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab3').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab4').removeClass('Clicked');

            }
            if (data == 'Tab2') {
                $('#divGeneral').hide();
                $('#divPurchaseDetails').show();
                $('#divAMCDetails').hide();
                $('#divSupportDocument').hide();
                $('#AssetImage').hide();
                $('#ContentPlaceHolder1_Tab2').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab3').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').addClass('Initial');
                $('#ContentPlaceHolder1_Tab4').removeClass('Clicked');
            }

            if (data == 'Tab3') {
                $('#divGeneral').hide();
                $('#divPurchaseDetails').hide();
                $('#divAMCDetails').hide();
                $('#divSupportDocument').show();
                $('#AssetImage').hide();
                $('#ContentPlaceHolder1_Tab3').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab2').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').addClass('Initial');
                $('#ContentPlaceHolder1_Tab4').removeClass('Clicked');
            }

            if (data == 'Tab4') {
                $('#divGeneral').hide();
                $('#divPurchaseDetails').hide();
                $('#divAMCDetails').show();
                $('#divSupportDocument').hide();
                $('#AssetImage').hide();
                $('#ContentPlaceHolder1_Tab4').addClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab2').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab3').removeClass('Clicked');
                $('#ContentPlaceHolder1_Tab1').addClass('Initial');
            }

            return false;
        }
        function fncPopupMessageBox(msg) {
            $('#ContentPlaceHolder1_divAssetDetails').hide();
            $('input[type=text]').val('');
            ShowPopupMessageBox(msg);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBoard/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Assets</a></li>
                <li><a href="javascript:void(0);">View Asset</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div id="div_Top" runat="server">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label1" runat="server" Text="Scan Asset Code"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtAssetCodeScan" runat="server" onkeydown="return fncScanAssetCode(event)" CssClass="form-control"></asp:TextBox>
                            <asp:LinkButton ID="lnkAssetCodeScan" OnClick="lnkAssetCodeScan_Click" runat="server" Style="display: none;"></asp:LinkButton>
                        </div>
                    </div>
                    <asp:Panel runat="server" ID="Panel1" HorizontalAlign="Center">
                    </asp:Panel>
                </div>
            </div>
            <div id="divAssetDetails" style="display: none;" runat="server">
                <div class="container-group-top">
                       <asp:Button Text="General" OnClientClick="return fncTabClickEvent('Tab1')" ID="Tab1" CssClass="Clicked" runat="server" Style="width: 270px" />
                        <asp:Button Text="Purchase Details" OnClientClick="return fncTabClickEvent('Tab2')" ID="Tab2" CssClass="Initial" runat="server" Style="width: 270px" />
                        <asp:Button Text="Support Document" OnClientClick="return fncTabClickEvent('Tab3')" ID="Tab3" CssClass="Initial" runat="server" Style="width: 270px" />
                        <asp:Button Text="Depreciation" OnClientClick="return fncTabClickEvent('Tab4')" ID="Tab4" CssClass="Initial" runat="server" Style="width: 270px" />

                    <asp:Panel runat="server" ID="Panel2" HorizontalAlign="Center" >
                        <div id="AssetImage">
                             <asp:Image ID="imgpreview" runat="server" Style="align-content: center; padding-top: 20px;" Height="120px" Width="150px" />

                        <div class="control-group">
                            <asp:Label ID="lblAssetName" runat="server" Text="-"></asp:Label>
                        </div>
                        </div>
                       
                    </asp:Panel>

                    <div id="divGeneral" >
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label5" runat="server" Text="Department"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblDepartment" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label17" runat="server" Text="Category"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblCategory" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label21" runat="server" Text="SubCategory"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblSubCategory" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label25" runat="server" Text="Location"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblLocation" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label27" runat="server" Text="Block"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblBlock" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label29" runat="server" Text="Floor"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblFloor" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label31" runat="server" Text="Room"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblRoom" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label33" runat="server" Text="Class"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblClass" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label35" runat="server" Text="Employee"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblEmployee" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label37" runat="server" Text="Brand"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblBrand" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label26" runat="server" Text="Cubical"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblCubic" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                    </div>
                    <div id="divPurchaseDetails" style="display: none;">
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label7" runat="server" Text="Vendor"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblVendor" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label8" runat="server" Text="Model"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblModel" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>


                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label10" runat="server" Text="Serial"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblSerial" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label3" runat="server" Text="Date Acquired"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblDateAcquired" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label9" runat="server" Text="Status"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblStatus" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>


                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label2" runat="server" Text="Unit"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblUnit" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label4" runat="server" Text="Unit Price"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblUnitPrice" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label6" runat="server" Text="Purchase Price"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblPurchasePrice" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>

                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label11" runat="server" Text="Warranty Start Date"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblWarrantyStartDate" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label13" runat="server" Text="Warranty End Date"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblWarrantyEndDate" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label15" runat="server" Text="Caution while Warranty Expires"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblCautionwhileWarrantyExpires" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>

                    </div>
                    <div id="divAMCDetails" style="display: none;">
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label12" runat="server" Text="AMC  Level"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblAMClevel" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label16" runat="server" Text="AMC Vendor"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblAMCVendor" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label18" runat="server" Text="AMC Amount"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblAMCAmount" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label20" runat="server" Text="AMC Start Date"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblAMCStartDate" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label22" runat="server" Text="AMC End Date"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblAMCEndDate" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label24" runat="server" Text="AMC Type"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblAMCType" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                        <div class="control-group Border-Bottom">
                            <div class="control-lbl-left">
                                <asp:Label ID="Label14" runat="server" Text="Rate of Depreciation"></asp:Label>
                            </div>
                            <div class="control-lbl-right">
                                <asp:Label ID="lblRateDep" runat="server" Text="-"></asp:Label>
                            </div>
                        </div>
                       <div class="control-group" style="background-color: #fff; color: black; font-weight: bolder;">
                            <div class="col-md-12">
                                <asp:Label ID="Label30" runat="server" Text="Printer"></asp:Label>
                            </div>
                        </div>
                        <div style="border: 1px solid green; padding: 3px 6px">
                            <div class="control-group">
                                <div class="col-md-12">
                                    <div class="control-left">
                                        <asp:Label ID="Label19" runat="server" Text="Printer Name"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:DropDownList ID="ddlPrinterName" CssClass="form-control" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div style="display:none" class="control-group">
                                <div class="col-md-12">
                                    <div class="control-left">
                                        <asp:Label ID="Label23" runat="server" Text="Template Code"></asp:Label>
                                    </div>
                                    <div class="control-right">
                                        <asp:DropDownList ID="ddlTemplate" CssClass="form-control" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="button-control">
                                <asp:LinkButton ID="lnkPrint" runat="server" OnClick="lnkPrint_Click" CssClass="btn btn-success waves-effect">Print</asp:LinkButton>
                                <asp:LinkButton ID="lnkServiceType" runat="server" OnClick="lnkServiceType_Click" CssClass="btn btn-success waves-effect">Service History</asp:LinkButton>
                            </div>
                        <%--</div>--%>
                </div>
            </div>

                      <div id="divSupportDocument" style="display: none;">
                    <div class="control-group" style="margin-top: 55px">
                      <%--  <div class="col-md-12">
                            <div class="control-left" style="width: 200px">
                                <asp:Label ID="lblDocument" runat="server" Text="Document"></asp:Label>
                            </div>
                            <div class="control-left" style="width: 200px">
                                <asp:Label ID="lblDocumentName" runat="server" Text="DocumentName"></asp:Label>
                            </div>
                        </div>--%>
                    </div>
                    <div class="control-group">
                        <div class="col-md-12" style="margin-top: 40px">

                            <div class="col-md-4">
                                <div class="control-left" style="width: 200px; margin-left: 6px">
                                    <asp:Label ID="lblDocument1" runat="server" Text="Document1"></asp:Label>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="control-right" style="width: 200px; margin-right: 330px">
                                    <asp:TextBox ID="txtDocument1" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <%--<div class="col-md-4">
                                <div class="control-right" style="width: 200px">
                                    <asp:Panel runat="server" ID="Panel3" HorizontalAlign="Center">

                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                        <%--    <Triggers>
                                                <asp:PostBackTrigger ControlID="lnkSave" />
                                            </Triggers>--%>
                                 <%--           <ContentTemplate>
                                                <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf" ID="FileUpload1" runat="server" onchange="showpreview1(this);" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </asp:Panel>

                                </div>
                            </div>--%>

                            <div class="button-control" style="margin-right: 578px; margin-top: -31px">
                                <asp:LinkButton ID="lnkDownload1" OnClick="lnkDownload_Click1" runat="server" CssClass="btn btn-primary waves-effect">Download</asp:LinkButton>
                               
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument2" runat="server" Text="Document2"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument2" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                             <%--   <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel4" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                              <%--  <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>--%>
                              <%--                  <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf" ID="FileUpload2" runat="server" onchange="showpreview1(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>--%>
                            <div class="button-control" style="margin-right: 575px; margin-top: -31px">
                                <asp:LinkButton ID="lnkDownload2" OnClick="lnkDownload_Click2" runat="server" CssClass="btn btn-primary waves-effect">Download</asp:LinkButton>
                               
                            </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument3" runat="server" Text="Document3"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument3" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                           <%--     <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel5" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                              <%--  <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>--%>
                                  <%--              <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf" ID="FileUpload3" runat="server" onchange="showpreview1(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>--%>
                               <div class="button-control" style="margin-right: 575px; margin-top: -31px">
                                <asp:LinkButton ID="lnkDownload3" OnClick="lnkDownload_Click3" runat="server" CssClass="btn btn-primary waves-effect">Download</asp:LinkButton>
                               
                            </div>


                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument4" runat="server" Text="Document4"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument4" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                         <%--       <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel6" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="UpdatePanel5" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                                <%--<Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>--%>
                                  <%--              <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf" ID="FileUpload4" runat="server" onchange="showpreview1(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>--%>
                            <div class="button-control" style="margin-right: 575px; margin-top: -31px">
                                <asp:LinkButton ID="lnkDownload4" OnClick="lnkDownload_Click4" runat="server" CssClass="btn btn-primary waves-effect">Download</asp:LinkButton>
                               
                            </div>


                            </div>
                        </div>
                        <div class="control-group">
                            <div class="col-md-12" style="margin-top: 10px">

                                <div class="col-md-4">
                                    <div class="control-left" style="width: 200px">
                                        <asp:Label ID="lblDocument5" runat="server" Text="Document5"></asp:Label>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="control-right" style="width: 200px; margin-right: 330px">
                                        <asp:TextBox ID="txtDocument5" Style="margin-left: -167px" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                           <%--     <div class="col-md-4">
                                    <div class="control-right" style="width: 200px">
                                        <asp:Panel runat="server" ID="Panel7" HorizontalAlign="Center">

                                            <asp:UpdatePanel ID="UpdatePanel6" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <%--    <Triggers>
                                                    <asp:PostBackTrigger ControlID="lnkSave" />
                                                </Triggers>--%>
                              <%--                  <ContentTemplate>
                                                    <asp:FileUpload Style="float: right; margin-right: 236px" accept=".pdf" ID="FileUpload5" runat="server" onchange="showpreview1(this);" />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </asp:Panel>

                                    </div>
                                </div>--%>
                             <div class="button-control" style="margin-right: 575px; margin-top: -31px">
                                <asp:LinkButton ID="lnkDownload5" OnClick="lnkDownload_Click5" runat="server" CssClass="btn btn-primary waves-effect">Download</asp:LinkButton>
                               
                            </div>

                            </div>
                        </div>
                    </div>

                </div>
        </div>
    </div>
         <asp:HiddenField ID="hdnCheck" runat="server" Value="" />
</asp:Content>
