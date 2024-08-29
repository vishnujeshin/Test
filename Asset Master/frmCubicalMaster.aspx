<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmCubicalMaster.aspx.cs" Inherits="AssetMobileApplication.Asset_Master.frmCubicalMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Src="~/UserControls/PaginationUserControls.ascx" TagName="PaginationUserControl" TagPrefix="ups" %>
    <script type="text/javascript">
        $(function () {
            $("#divDialog_Confirm").dialog({
                autoOpen: false,
                resizable: false,
                height: 130,
                width: 240,
                modal: true,
                title: "",
                appendTo: 'form:first'
            });
        });

        function fncOpenSaveConfirmDialogOpen(source) {
            try {
                var data = $(source).closest("tr");
                $("#<%=hdCubicalId.ClientID%>").val($("td", data).eq(2).html().replace(/&nbsp;/g, ''))
                $("#<%=lblDialog_Confirm.ClientID %>").text('Do you want Delete?');
                $("#divDialog_Confirm").dialog('open');
            }
            catch (err) {
                alert(err.message);
            }
        }

        function fncMaterialChkDialogClose() {
            try {
                $("#divDialog_Confirm").dialog('close');
            }
            catch (err) {
                alert(err.message);
            }
        }

        function ValidateForm() {
            var status = true;
            if ($("#<%=txtRemarks.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Select CubicalCode');
                status = false;
            }
            else if ($("#<%=txtCubicalName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Cubical Name');
                status = false;
            }
            else if ($("#<%=ddlLocation.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Choose Location');
                status = false;
            }
            else if ($("#<%=ddlBlock.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Choose Block');
                status = false;
            }
            else if ($("#<%=ddlFloor.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Choose Floor');
                status = false;
            }
            else if ($("#<%=ddlRoom.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Choose Room');
                status = false;
            }
            return status;
        }
        function fncPopupMessageBox(msg) {
            clearForm()
            ShowPopupMessageBox(msg);
        }


        function ShowPopupMessageBox1(msg) {
            $(function () {

                $("#dialog-MessageBox1").html(msg);
                $("#dialog-MessageBox1").dialog({
                    title: "Room",
                    buttons: {
                        Ok: function () {
                            //$(this).dialog('close');                            
                            $("#<%=btnsavenew.ClientID %>").click();
                            clearForm()

                        }
                    },
                    modal: true
                });
            });
        }


        function clearForm() {
            $('input[type=text]').val('');
            $('#<%=txtRemarks.ClientID %>').attr('readonly', false);
            $('#<%=ddlBlock.ClientID %>').val('');
            $('#<%=ddlFloor.ClientID %>').val('');
            $('#<%=ddlRoom.ClientID %>').val('');
        }

        function imgbtnEdit_ClientClick(source) {
            DisplayDetails($(source).closest("tr"));
            __doPostBack('ctl00$ContentPlaceHolder1$hidbtnedit', '');
            return false;
        }

        function DisplayDetails(row) {
            try {
                $('#<%=hdBrandId.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                $('#<%=hdCubicalId.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
                $('#<%=txtCubicalName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
                $('#<%=txtRemarks.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                $('#<%=ddlLocation.ClientID %>').val($("td", row).eq(9).html().replace(/&nbsp;/g, ''));
                $('#<%=ddlLocation.ClientID %>').trigger("chosen:updated");
                $('#<%=ddlBlock.ClientID %>').val($("td", row).eq(10).html().replace(/&nbsp;/g, ''));
                $('#<%=ddlBlock.ClientID %>').trigger("chosen:updated");
                $('#<%=ddlFloor.ClientID %>').val($("td", row).eq(11).html().replace(/&nbsp;/g, ''));
                $('#<%=ddlFloor.ClientID %>').trigger("chosen:updated");
                $('#<%=ddlRoom.ClientID %>').val($("td", row).eq(12).html().replace(/&nbsp;/g, ''));
                $('#<%=ddlRoom.ClientID %>').trigger("chosen:updated");
            }
            catch (err) {
                alert(err.message);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Master</a></li>
                <li><a href="javascript:void(0);">Cubical Master</a></li>
            </ol>
        </div>
        <div class="container-group-top">
            <div class="col-md-12">
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label2" runat="server" Text="Location"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlLocation" runat="server" onSelectedIndexChanged="LoadLocationInBlock" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label5" runat="server" Text="Block"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlBlock" runat="server"  onSelectedIndexChanged="LoadBlockInfloor" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label6" runat="server" Text="Floor"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlFloor" runat="server" onSelectedIndexChanged="LoadFloorInRoom" AutoPostBack="True"  CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-md-12">
            <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label3" runat="server" Text="Room"></asp:Label>  <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                </div>
           
                 <div class="col-md-4">
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label4" runat="server" Text="CubicalCode"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" >
                    <div class="control-group">
                        <div class="control-left">
                            <asp:Label ID="Label1" runat="server" Text="Cubical Name"></asp:Label> <span class="mandatory">*</span>
                        </div>
                        <div class="control-right">
                            <asp:TextBox ID="txtCubicalName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>  
            </div>

            <div class="button-control">
                <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkSave_Click" OnClientClick="return ValidateForm()">Save</asp:LinkButton>
                <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClick="lnkClear_Click" OnClientClick="return clearForm();">Clear</asp:LinkButton>
            </div>
        </div>
        <div class="col-md-12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                <ContentTemplate>
                    <div class="control-group">
                        <div class="col-md-12">
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="lnkSearchGrid">
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter Cubical Name To Search"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:LinkButton ID="lnkSearchGrid" runat="server" class="button-blue" Width="100px" Style="visibility: hidden"
                                        OnClick="lnkSearchGrid_Click" Text="Search"><i class="icon-play"></i></asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <asp:GridView ID="gvCubical" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="True">
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
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images/edit-icon.png" OnClientClick="imgbtnEdit_ClientClick(this); return false;"
                                        CommandName="Select" ToolTip="Click here to edit" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images/delete.png" OnClientClick="fncOpenSaveConfirmDialogOpen(this); return false;"
                                        CommandName="Select" ToolTip="Click here to Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Id" HeaderText="Cubical Id"  ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                            <asp:BoundField DataField="CubicalName" HeaderText="Cubical Name"></asp:BoundField>
                            <asp:BoundField DataField="CubicalCode" HeaderText="CubicalCode"></asp:BoundField>
                            <asp:BoundField DataField="LocationName" HeaderText="Location Name"></asp:BoundField>
                            <asp:BoundField DataField="BlockName" HeaderText="Block Name"></asp:BoundField>
                            <asp:BoundField DataField="FloorName" HeaderText="Floor Name"></asp:BoundField>
                            <asp:BoundField DataField="RoomName" HeaderText="Room Name"></asp:BoundField>   
                            <asp:BoundField DataField="LocationId" HeaderText="LocationId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                            <asp:BoundField DataField="BlockId" HeaderText="BlockId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                            <asp:BoundField DataField="FloorId" HeaderText="FloorId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                            <asp:BoundField DataField="RoomId" HeaderText="RoomId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <ups:PaginationUserControl runat="server" ID="CubicalMasterPagination" OnPaginationButtonClick="CubicalMasterPagination_PaginationButtonClick" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <asp:HiddenField ID="hdCubicalId" runat="server" Value="" />
        <div id="divDialog_Confirm" style="display: none;">
            <div>
                <asp:Label ID="lblDialog_Confirm" runat="server"></asp:Label>
            </div>
            <div class="Dialog_Confirm_Center">
                <div class="Dialog_Confirm_yes">
                    <asp:UpdatePanel ID="upDialog_Confirm" runat="server">
                        <ContentTemplate>
                            <asp:LinkButton ID="lnkbtnYes" runat="server" class="btn btn-success waves-effect" Text='Yes' OnClick="lnkDelete_Click"
                                OnClientClick="fncMaterialChkDialogClose();"> </asp:LinkButton>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="Dialog_Confirm_No">
                    <asp:LinkButton ID="lnlbtnNo" runat="server" class="btn btn-warning waves-effect" Text='No'
                        OnClientClick="fncMaterialChkDialogClose();return false;"> </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
                 <asp:HiddenField ID="hdBrandId" runat="server" />
   <div style="display:none"> 
       <asp:LinkButton ID="hidbtnedit" runat="server" class="btn btn-warning waves-effect"   OnClick="gridebind" > </asp:LinkButton>
   </div>
       <asp:Button ID="btnsavenew" runat="server" style="display:none"  OnClick="btn_save_Click" />
      <div id="dialog-MessageBox1" style="display: none"></div>
</asp:Content>
