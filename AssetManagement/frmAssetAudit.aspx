<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmAssetAudit.aspx.cs" Inherits="AssetMobileApplication.AssetManagement.frmAssetAudit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function fncOpenAssetMoveDialog() {
            try {
                $("#dialog-confirm").dialog({
                    resizable: false,
                    height: "auto",
                    width: 400,
                    modal: true,
                    buttons: {
                        "YES": function () {
                            $(this).dialog("close");
                            fncMoveAssetLocation();
                            return false;
                        },
                        "NO": function () {
                            $('#<%=txtScanAsset.ClientID %>').val('');
                            $(this).dialog("close");
                            return false;
                        }
                    }
                });
            }
            catch (err) {
                ShowToastError(err.message);
            }
            return false;
        }
        function fncAssetAuditValidation() {
            var status = true, Location = '', Department = '', Block = '', Floor = '',
                Room = '', Cubical = '', Employee = '';
            try {
                Location = $('#<%=ddlLocation.ClientID %>').val();
                Department = $('#<%=ddlDepartment.ClientID %>').val();
                Block = $('#<%=ddlBlockName.ClientID %>').val();
                Floor = $('#<%=ddlFloorName.ClientID %>').val();
                Room = $('#<%=ddlRoom.ClientID %>').val();
                Cubical = $('#<%=ddlCubical.ClientID %>').val();
                Employee = $('#<%=ddlEmployee.ClientID %>').val();

                //if (Location == '0' || Location == '--Select--') {
                //    ShowPopupMessageBox('Please Select Location');
                //    status = false;
                //}
                //else if (Department == '0' || Department == '--Select--') {
                //    ShowPopupMessageBox('Please Select Department');
                //    status = false;
                //}
                //else if (Block == '0' || Block == '--Select--') {
                //    ShowPopupMessageBox('Please Select Block');
                //    status = false;
                //}
                //else if (Floor == '0' || Floor == '--Select--') {
                //    ShowPopupMessageBox('Please Select Floor');
                //    status = false;
                //}
                //else if (Room == '0' || Room == '--Select--') {
                //    ShowPopupMessageBox('Please Select Room');
                //    status = false;
                //}
                //else if (Cubical == '0' || Cubical == '--Select--') {
                //    ShowPopupMessageBox('Please Select Cubical');
                //    status = false;
                //}
                //else if (Employee == '0' || Employee == '--Select--') {
                //    ShowPopupMessageBox('Please Select Employee');
                //    status = false;
                //}
            }
            catch (err) {
                status = false;
                ShowToastError(err.message);
            }
            return status;
        }
        function fncSearchAssetCode() {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (keyCode == 13) {
                <%--if ($('#<%=txtScanAsset.ClientID %>').val() == '')--%>                    
                fncCheckAssetForAudit();
                event.preventDefault();
            }
            <%--if ($('#<%=txtScanAsset.ClientID %>').val() != '') {
                $("[id$=txtScanAsset]").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: '<%=ResolveUrl("frmAssetAudit.aspx/GetAssetCodeForAssetAudit") %>',
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
                        $('#<%=txtScanAsset.ClientID %>').val($.trim(i.item.val));
                     //   $('#<%=txtScanAsset.ClientID %>').val('');
                      //  $('#<%=txtScanAsset.ClientID %>').attr('readonly', true);
                        fncCheckAssetForAudit();--%>
                        <%--$("#<%=btnFetchAssetDetails.ClientID%>").click();--%>

            //            event.preventDefault();

            //        },

            //        minLength: 1
            //    });
            //}
        }
        function fncCheckAssetForAudit() {
            var Status = false, isScanned = 'N';
            try {
                $("[id*=gvAssetDetails] tr").each(function () {
                    if (!this.rowIndex) return;
                    objAssetCode = $(this).find('.LAssetCode');
                    objAssetScan = $(this).find('.LAssetscan');
                    var bgcolor = $(this).css('background-color');
                    if ($('#<%=txtScanAsset.ClientID %>').val().toUpperCase() == objAssetCode.text().toUpperCase()) {
                        if (bgcolor == 'rgb(60, 179, 113)') {
                            isScanned = 'Y';
                            ShowToastError('Asset Already Scanned..!');
                            return false;
                        }
                        else {
                            $(this).css('background', 'mediumseagreen');
                            $(this).css('color', 'Black');
                            Status = true;
                            isScanned = 'N';

                        }
                    }

                });
                if (Status && isScanned == 'N') {
                    //fncSaveAssetAudit();
                }
                //else {
                //    fncOpenAssetMoveDialog();
                //}
            }
            catch (err) {
                ShowToastError(err.message);
            }
        }

        function fncSaveAssetAudit() {
            var obj = {};
            var num = 0;
            var xml = '<NewDataSet>';


            $("[id*=gvAssetDetails] tr").each(function () {


                var bgcolor = $(this).css('background-color');
                if (bgcolor == 'rgb(60, 179, 113)') {
                    if (!this.rowIndex) return;

                    xml += "<Table>";
                    xml += "<AssetCode>" + $(this).find('.LAssetCode').text() + "</AssetCode>";
                    xml += "<Department>" + $(this).find('.LDepartment').text() + "</Department>";
                    xml += "<Employee>" + $(this).find('.LEmployee').text() + "</Employee>";
                    xml += "<Location>" + $(this).find('.LLocation').text() + "</Location>";
                    xml += "<Block>" + $(this).find('.LBlock').text() + "</Block>";
                    xml += "<Floor>" + $(this).find('.LFloor').text() + "</Floor>";
                    xml += "<Room>" + $(this).find('.LRoom').text() + "</Room>";
                    xml += "<Cubical>" + $(this).find('.LCubical').text() + "</Cubical>";
                    xml += "<Remarks>" + $(this).find('input[id*=txtRemark]').val() + "</Remarks>";
                    xml += "</Table>";
                    num++;

                }


            });

            xml = xml + '</NewDataSet>';
            xml = escape(xml);
            /*  alert(xml);*/
            $('#<%=hdnXmlvalue.ClientID %>').val(xml);
            $('#<%=btnsave.ClientID%>').click();
            return true;

       <%--         obj.AssetCode = $('#<%=txtScanAsset.ClientID %>').val();
                obj.LocationId = $('#<%=ddlLocation.ClientID %>').val();
                obj.BlockId = $('#<%=ddlBlockName.ClientID %>').val();
                obj.FloorId = $('#<%=ddlFloorName.ClientID %>').val();
                obj.RoomId = $('#<%=ddlRoom.ClientID %>').val();
                obj.DepartmentId = $('#<%=ddlDepartment.ClientID %>').val();
                obj.CubicalId = $('#<%=ddlCubical.ClientID %>').val();
                obj.EmployeeId = $('#<%=ddlEmployee.ClientID %>').val();--%>
                <%--   $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/AssetManagement/frmAssetAudit.aspx/fncSaveAssetAudit") %>',
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == 'Success') {
                            ShowPopupMessageBox('Asset Verified..!');
                            $('#<%=txtScanAsset.ClientID %>').val('');
                            $('#<%=txtScanAsset.ClientID %>').attr('readonly', false);
                            $('#<%=txtScanAsset.ClientID %>').select().focus();
                        }
                        else if (msg.d == 'Fail') {
                            ShowToastError('Asset Audit Save operation is Fail.Something Went Wrong..!');
                        }
                        else
                            ShowToastError('Something Went Wrong..!');
                    },
                    error: function (data) {
                        ShowToastError(data.message);
                    }
                });--%>           
        }


        function fncMoveAssetLocation() {
            var obj = {};
            try {
                obj.AssetCode = $('#<%=txtScanAsset.ClientID %>').val();
                obj.LocationId = $('#<%=ddlLocation.ClientID %>').val();
                obj.BlockId = $('#<%=ddlBlockName.ClientID %>').val();
                obj.FloorId = $('#<%=ddlFloorName.ClientID %>').val();
                obj.RoomId = $('#<%=ddlRoom.ClientID %>').val();
                obj.DepartmentId = $('#<%=ddlDepartment.ClientID %>').val();
                obj.CubicalId = $('#<%=ddlCubical.ClientID %>').val();
                obj.EmployeeId = $('#<%=ddlEmployee.ClientID %>').val();
                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/AssetManagement/frmAssetAudit.aspx/fncMoveAssetLocation") %>',
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d == 'Success') {
                            ShowToastError('Asset Moved Successfully..!');
                            $('#<%=txtScanAsset.ClientID %>').val('');
                            $('#<%=txtScanAsset.ClientID %>').attr('readonly', false);
                            $('#<%=txtScanAsset.ClientID %>').select().focus();
                        }
                        else if (msg.d == 'Fail') {
                            ShowToastError('Asset Moved operation is Fail.Something Went Wrong..!');
                        }
                        else
                            ShowToastError('Something Went Wrong..!');
                    },
                    error: function (data) {
                        ShowToastError(data.message);
                    }
                });
            }
            catch (err) {
                ShowToastError(err.Message);
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons"> home</i>Home</a></li>
                <li><a href="javascript:void(0);">Asset Management</a></li>
                <li><a href="javascript:void(0);">Asset Audit</a></li>
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
                                                    <asp:Label ID="Label17" runat="server" Text="Block Name"></asp:Label>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlBlockName" runat="server" CssClass="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
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
                                    </div>
                                    <div class="col-md-12">
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
                                        <div class="col-md-4">
                                            <div class="control-group">
                                                <div class="control-left">
                                                    <asp:Label ID="Label1" runat="server" Text="Method"></asp:Label> <span class="mandatory">*</span>
                                                </div>
                                                <div class="control-right">
                                                    <asp:DropDownList ID="ddlMethod" runat="server" CssClass="form-control">
                                                        <asp:ListItem>--Select--</asp:ListItem>
                                                        <asp:ListItem Value="Assigned">AssignedAsset</asp:ListItem>
                                                        <asp:ListItem Value="UnAssigned">UnAssignedAsset</asp:ListItem>
                                                    </asp:DropDownList>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="control-group">
                                            <div class="button-control">
                                                <asp:LinkButton ID="lnkLoad" runat="server" OnClientClick="return fncAssetAuditValidation();" OnClick="lnkLoad_Click" CssClass="btn btn-success waves-effect">Load</asp:LinkButton>
                                                <asp:LinkButton ID="lnkCancel" runat="server" OnClick="lnkCancel_Click" CssClass="btn btn-warning waves-effect">Cancel</asp:LinkButton>
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
                                                        <asp:BoundField DataField="AssetCode" HeaderText="Asset Code" ItemStyle-CssClass="LAssetCode"></asp:BoundField>
                                                        <asp:BoundField DataField="Department" HeaderText="Department" ItemStyle-CssClass="LDepartment"></asp:BoundField>
                                                        <asp:BoundField DataField="Employee" HeaderText="Employee" ItemStyle-CssClass="LEmployee"></asp:BoundField>
                                                        <asp:BoundField DataField="LocationName" HeaderText="Location" ItemStyle-CssClass="LLocation"></asp:BoundField>
                                                        <asp:BoundField DataField="BlockName" HeaderText="Block" ItemStyle-CssClass="LBlock"></asp:BoundField>
                                                        <asp:BoundField DataField="FloorName" HeaderText="Floor" ItemStyle-CssClass="LFloor"></asp:BoundField>
                                                        <asp:BoundField DataField="RoomName" HeaderText="Room" ItemStyle-CssClass="LRoom"></asp:BoundField>
                                                        <asp:BoundField DataField="Cubical" HeaderText="Cubical" ItemStyle-CssClass="LCubical"></asp:BoundField>
                                                        <asp:BoundField DataField="UserName" HeaderText="Assigned By" ItemStyle-CssClass="LAssignedBY"></asp:BoundField>
                                                        <asp:BoundField DataField="AssignedDate" HeaderText="Assigned Date" ItemStyle-CssClass="LAssignedDate"></asp:BoundField>
                                                        <%--<asp:BoundField DataField="Scan" HeaderText="Scan" ItemStyle-CssClass="LAssetscan"></asp:BoundField>--%>
                                                        <asp:TemplateField HeaderText="Remark">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemark" runat="server" Width="100%" Rows="2"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

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
                                                        <asp:Label ID="Label2" runat="server" Text="Scan Asset"></asp:Label>
                                                    </div>
                                                    <div class="control-right">
                                                        <asp:TextBox ID="txtScanAsset" runat="server" onkeydown="return fncSearchAssetCode(event)" CssClass="form-control"></asp:TextBox>
                                                        <%--<asp:Button Text="" Style="display: none;" ID="btnFetchAssetDetails" runat="server" />--%>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="control-group">
                                                    <div class="control-right">
                                                        <asp:TextBox ID="txtmsg" runat="server" Width="140%" CssClass="form-control"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="control-group">
                                                    <div class="button-control">
                                                        <asp:LinkButton ID="btnsave" runat="server" OnClientClick="return fncSaveAssetAudit();" OnClick="btnsave_Click" CssClass="btn btn-warning waves-effect">Save</asp:LinkButton>
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
        <div id="dialog-confirm" style="display: none;">
            <asp:Label ID="lblDialog" runat="server" Text="This item does not belong to this location. Do you want to move?"></asp:Label>

        </div>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <div class="modal-loader">
                    <div class="center-loader">
                        <img alt="" src="../images/loader1.gif" />
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </div>
</asp:Content>
