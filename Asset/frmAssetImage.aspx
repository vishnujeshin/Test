<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetImage.aspx.cs" Inherits="AssetMobileApplication.Asset.frmAssetImage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            GetStoreList();
        });
        function GetStoreList() {
            try {
                var Busername = "unipro";
                var Bpassword = "ups@123";

                $.ajax({
                    url: 'http://156.238.16.0/onlineordertest/api/GetAllStores',
                    type: "GET",
                    dataType: "json",
                    headers: {
                        'Authorization': 'Basic ' + btoa(Busername + ':' + Bpassword)
                    },

                    async: false,
                    success: function (data) {
                        console.log(data);
                    },
                    error: function (data) {
                        console.log("Error");
                        console.log(data);
                    }
                });
            }
            catch (e) {
                console.log(e);
            }
        }
    </script>
    <script type="text/javascript">
        function showpreview(input) {
            try {
                var maxsize = 50 * 1024;
                if (input.files && input.files[0].size < maxsize) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#<%=imgpreview.ClientID %>').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(input.files[0]);
                }
                else {
                    input.value = "";
                    ShowToastError('File size exceeds 50 kb');
                    //alert('file size: ' + input.files[0].size);
                }
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }
        function ValidateForm() {
            var status = true;
            try {
                if ($('#<%=txtAssetCode.ClientID %>').val() == '') {
                    ShowPopupMessageBox('Please Scan Asset');
                    status = false;
                }
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncClearForm() {
            window.location = "../Asset/frmAssetImage.aspx";
        }
        function fncSearchAssetCode() {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                if ($('#<%=txtAssetCode.ClientID %>').val() == '')
                    event.preventDefault();
            }
            if ($('#<%=txtAssetCode.ClientID %>').val() != '') {
                $("[id$=txtAssetCode]").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("frmAssetImage.aspx/SearchAssetCodeForAssetImage") %>',
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
                        $('#<%=txtAssetCode.ClientID %>').val($.trim(i.item.val));
                        $('#<%=txtAssetCode.ClientID %>').attr('readonly', true);
                        GetAssetImages($.trim(i.item.val));
                        event.preventDefault();
                    },

                    minLength: 1
                });
            }
        }
        function GetAssetImages(AssetCode) {
            var obj = {};
            obj.Mode = 'GetAssetImage',
                obj.AssetCode = AssetCode
            $.ajax({
                type: "POST",
                url: "frmAssetImage.aspx/GetAssetImageDetails",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    fncBindAssetDetails(msg.d);
                },
                error: function (data) {
                    ShowToastError(data.message);
                }
            });
        }
        function fncBindAssetDetails(data) {
            var obj, row, tbl;
            tbl = $("#tblAssetDetails tbody");
            try {
                obj = jQuery.parseJSON(data);
                tbl.children().remove();

                if (obj.length > 0) {
                    for (var i = 0; i < obj.length; i++) {
                        row = "<tr><td >" + obj[i]["SNo"] + "</td>"
                            + " <td >" + obj[i]["AssetCode"] + "</td>"                            
                            + " <td ><img src='" + obj[i]["ImageUrl"].replace('~','..') + "' alt='' style='width: 150px; height: 100px;'></td>"
                            + " <td >" + obj[i]["Remarks"] + "</td>"
                            + "</tr>";
                        tbl.append(row);

                    }

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
                <li><a href="javascript:void(0);">Asset</a></li>
                <li><a href="javascript:void(0);">Add Asset Images</a></li>
            </ol>
        </div>
        <div class="col-md-12">
            <div class="container-group-top">
                <div class="control-group">
                    <div class="col-md-12">
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label1" runat="server" Text="Asset Code"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtAssetCode" onkeydown="return fncSearchAssetCode(event)" runat="server" CssClass="form-control"></asp:TextBox>
                                    <%--<asp:Button Text="" Style="display: none;" ID="btnFetchRequestDetails" runat="server" />--%>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="control-group">
                                <div class="button-control" style="float: left !important; margin: 0px !important; padding-left: 2px !important">
                                    <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncClearForm();">Clear</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="container-group-top">
                        <div class="col-md-8">
                            <div id="divAssetImageUpload">
                                <div class="control-left">
                                    <asp:Label ID="Label32" runat="server" Text="Asset Image"></asp:Label>
                                </div>
                                <asp:Panel runat="server" ID="Panel2" HorizontalAlign="Center">

                                    <asp:Image ID="imgpreview" runat="server" Style="align-content: center;" Height="100px" Width="150px" />
                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                        <triggers>
                                        <asp:PostBackTrigger ControlID="lnkUpload" />
                                    </triggers>
                                        <contenttemplate>
                                        <asp:FileUpload Style="float: right" accept="image/*" ID="fuimage" runat="server" onchange="showpreview(this);" />
                                    </contenttemplate>
                                    </asp:UpdatePanel>
                                </asp:Panel>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="control-group">
                                <div class="control-left">
                                    <asp:Label ID="Label13" runat="server" Text="Remarks"></asp:Label>
                                </div>
                                <div class="control-right">
                                    <asp:TextBox ID="txtRemarks" TextMode="MultiLine" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="control-group">
                                <div class="button-control">
                                    <asp:LinkButton ID="lnkUpload" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkUpload_Click" OnClientClick="return ValidateForm()">Upload</asp:LinkButton>
                                    <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncClearForm();return false;">Clear</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div style="overflow: auto; height: 350px;">
                                <table class="pshro_GridDgn" border="1" id="tblAssetDetails">
                                    <thead>
                                        <tr class="pshro_GridDgnStyle">
                                            <th class="pshro_GridDgnHeaderCellCenter">S.No</th>
                                            <th class="pshro_GridDgnHeaderCellCenter">Asset Code</th>
                                            <th class="pshro_GridDgnHeaderCellCenter">Image</th>
                                            <th class="pshro_GridDgnHeaderCellCenter">Remarks</th>
                                        </tr>
                                    </thead>
                                    <tbody class="pshro_GridDgnStyle">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
</asp:Content>
