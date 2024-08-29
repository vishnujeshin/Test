<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmFloorMaster.aspx.cs"  EnableEventValidation="false" Inherits="AssetMobileApplication.Asset_Master.frmFloorMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%@ Register Src="~/UserControls/PaginationUserControls.ascx" TagName="PaginationUserControl" TagPrefix="ups" %>ipt>
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
                $("#<%=hdFloorCode.ClientID%>").val($("td", data).eq(2).html().replace(/&nbsp;/g, ''))
                $("#<%=lblDialog_Confirm.ClientID %>").text('Do you want Delete?');
                $("#divDialog_Confirm").dialog('open');
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }
        function fncMaterialChkDialogClose() {
            try {
                $("#divDialog_Confirm").dialog('close');
            }
            catch (err) {
                ShowPopupMessageBox(err.message);
            }
        }
        function ValidateForm() {
            var status = true;
            if ($("#<%=txtFloorCode.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Floor Code');
                status = false;
            }
            else if ($("#<%=txtFloorName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Enter Floor Name');
                status = false;
            }
            else if ($("#<%=ddlLocation.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Choose Location');
                status = false;
            }
            else if ($("#<%=ddlBlockName.ClientID%>").val() == '') {
                ShowPopupMessageBox('Please Choose Block');
                status = false;
            }
            <%-- else if ($("#<%=ddlLocation.ClientID%>").val() == '0') {
                ShowPopupMessageBox('Please Select Location Name');
                status = false;
            }
            else if ($("#<%=ddlBlockName.ClientID%>").val() == '0') {
                ShowPopupMessageBox('Please Select Block Name');
                status = false;
            }--%>
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
 <%--       function clearForm() {
            $('input[type=text]').val('');
            $('#<%=txtFloorCode.ClientID %>').attr('readonly', false);

            var dropdown = $("#ddlLocation");
            dropdown.empty();
            var dropdown = $("#ddlLocation");
            dropdown.find('option:not(:first)').remove();
            $('input[type=dropdown]').val('');
         

        <%--    <%--$('#ContentPlaceHolder1_ddlLocation').html(''); --%>
            <%--$('#<%=ddlLocation.ClientID %>').trigger("liszt:updated");
        }--%>


        function clearForm() {
            $('input[type=text]').val('');
            $('#<%=txtFloorCode.ClientID %>').attr('readonly', false);
            $('#<%=ddlBlockName.ClientID %>').val('');
        }

<%--        function imgbtnEdit_ClientClick(source) {
            var row = $(source).closest("tr");
            DisplayDetails($(source).closest("tr"));
            // Enable editing for specific fields
            //row.find(".editable-field").prop("readonly", false);
            $('#<%=hdBrandId.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
            __doPostBack('ctl00$ContentPlaceHolder1$hidbtnedit', '');
            return false; 
        }--%>
        function imgbtnEdit_ClientClick(source) {
            DisplayDetails($(source).closest("tr"));
            __doPostBack('ctl00$ContentPlaceHolder1$hidbtnedit', '');
            return false;
        }

        //function imgbtnEdit_ClientClick(source) {
        //    DisplayDetails($(source).closest("tr"));
        //}
     <%--   function imgbtnEdit_ClientClick(source) {
          /*  DisplayDetails($(source).closest("tr"));*/
            //$('#<%=hidbtnedit.ClientID %>').click();      
            $('#<%=hdBrandId.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
            __doPostBack('ctl00$ContentPlaceHolder1$hidbtnedit', '');
            return false; // Prevent the default button click behavior
        }
        function lnkSearch_Click(source) {
            DisplayDetails($(source).closest("tr"));
        }--%>
<%-- function DisplayDetails(row) {
     
                 $('#<%=txtFloorCode.ClientID %>').attr('readonly', true);
         $('#<%=txtFloorCode.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
     $('#<%=txtFloorName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));

                $('#<%=ddlLocation.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                __doPostBack('<%=ddlLocation.ClientID %>', '');
                $('#<%=ddlLocation.ClientID %>').trigger("chosen:updated");
     
                $('#<%=ddlBlockName.ClientID %>').val($("td", row).eq(5).html().replace(/&nbsp;/g, ''));
                $('#<%=ddlBlockName.ClientID %>').trigger("chosen:updated");
            }--%>

             function DisplayDetails(row) {
            $('#<%=hdBrandId.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
       $('#<%=txtFloorCode.ClientID %>').attr('readonly', true);
            $('#<%=txtFloorCode.ClientID %>').val($("td", row).eq(2).html().replace(/&nbsp;/g, ''));
            $('#<%=txtFloorName.ClientID %>').val($("td", row).eq(3).html().replace(/&nbsp;/g, ''));
            $('#<%=ddlLocation.ClientID %>').val($("td", row).eq(4).html().replace(/&nbsp;/g, ''));
                 $('#<%=ddlLocation.ClientID %>').trigger("chosen:updated");
                 $('#<%=ddlBlockName.ClientID %>').val($("td", row).eq(5).html().replace(/&nbsp;/g, ''));
                 $('#<%=ddlBlockName.ClientID %>').trigger("chosen:updated");
        }


        function fncGetPODetails() {
            var obj = {}
            obj.PONo = $('#<%=txtFloorCode.ClientID%>').val();
             $.ajax({
                 type: "POST",
                 url: "frmFloorMaster.aspx/GetPODetails",
                 data: JSON.stringify(obj),
                 contentType: "application/json; charset=utf-8",
                 dataType: "json",
                 success: function (response) {
                     var xmlDoc = $.parseXML(response.d);
                     var xml = $(xmlDoc);
                     var PoDetails = xml.find("Table");

                     $('#<%=ddlBlockName.ClientID %>').empty();

                    $('#<%= ddlBlockName.ClientID %>').append($('<option>', {
                        value: '',
                        text: '---SELECT---'
                    }));

                    $.each(PoDetails, function () {
                        var SONo = $(this).find("BlockName").text();
                        alert(SONo)
                        $('#<%=ddlBlockName.ClientID%>').append($("<option></option>").val(SONo).text(SONo));
                    });
                },

                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                }
             });


            $('#<%= ddlBlockName.ClientID %>').append($('<option>', {
                value: '',
                text: '---SELECT---'
            }));
         }

        function fncChangeSubDepartment() {        
            $.ajax({
                type: "POST",
                url: "frmFloorMaster.aspx/gridebind",
                data: "{'floorCode':'" + $('#<%=hdBrandId.ClientID %>').val() + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                <%--    $('#<%=ddlBlockName.ClientID %>').val($("td", row).eq(5).html().replace(/&nbsp;/g, ''));
                    $('#<%=ddlBlockName.ClientID %>').trigger("chosen:updated");   --%>                   },
                      error: function (data) {
                          ShowPopupMessageBox('Something Went Wrong')
                      }
                  });
          }
           
   

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="../DashBord/frmDashBord.aspx"><i class="material-icons">home</i>Home</a></li>
                <li><a href="javascript:void(0);">Master</a></li>
                <li><a href="javascript:void(0);">Floor Master</a></li>
            </ol>
        </div>

        <div class="container-group-top">
            <div class="col-md-12">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label3" runat="server" Text="Location Name"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:DropDownList ID="ddlLocation" runat="server" onSelectedIndexChanged="LoadLocationInBlock" AutoPostBack="True" CssClass="form-control"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="control-group">

                            <div class="control-left">
                                <asp:Label ID="Label2" runat="server" Text="Block Name"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                               <asp:DropDownList ID="ddlBlockName" runat="server"    sClass="form-control"></asp:DropDownList>
                                 <%-- <asp:DropDownList ID="ddlBlockName" runat="server"    CssClass="form-control"></asp:DropDownList>--%>

                                 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label4" runat="server" Text="Floor Code"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtFloorCode" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="control-group">
                            <div class="control-left">
                                <asp:Label ID="Label1" runat="server" Text="Floor Name"></asp:Label> <span class="mandatory">*</span>
                            </div>
                            <div class="control-right">
                                <asp:TextBox ID="txtFloorName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="button-control">
                    <asp:LinkButton ID="lnkSave" runat="server" CssClass="btn btn-success waves-effect" OnClick="lnkSave_Click" OnClientClick="return ValidateForm()">Save</asp:LinkButton>
                    <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-warning waves-effect" OnClientClick="fncclearForm();return false;">Clear</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="col-md-12">
  <%--          <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                <ContentTemplate>--%>
                    <div class="control-group">
                        <div class="col-md-12">
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="lnkSearchGrid">
                                <div class="col-md-4">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter Floor Name  To Search"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <asp:LinkButton ID="lnkSearchGrid" runat="server" class="button-blue" Width="100px" Style="visibility: hidden"
                                        OnClick="lnkSearchGrid_Click" Text="Search"><i class="icon-play"></i></asp:LinkButton>
                                </div>
                            </asp:Panel>
                        </div>
                    </div>
                    <asp:GridView ID="gvFloor" runat="server" Width="100%" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="pshro_GridDgn" AllowPaging="True">
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
<%--                                    <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images/edit-icon.png" OnClientClick="imgbtnEdit_ClientClick(this); return false;"
                                        CommandName="Select" ToolTip="Click here to edit" />--%>
                    <%--                <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images/edit-icon.png" OnClick="gridebind" CommandName="Select" ToolTip="Click here to edit" />--%>
                                    <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images/edit-icon.png"  OnClientClick="imgbtnEdit_ClientClick(this); return false;"
    CommandName="Select" ToolTip="Click here to edit" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images/delete.png" OnClientClick="fncOpenSaveConfirmDialogOpen(this); return false;"
                                        CommandName="Select" ToolTip="Click here to Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="FloorCode" HeaderText="Floor Code"></asp:BoundField>
                            <asp:BoundField DataField="FloorName" HeaderText="Floor Name"></asp:BoundField>
                            <asp:BoundField DataField="LocationId" HeaderText="LocationId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>
                         
                            <asp:BoundField DataField="BlockId" HeaderText="BlockId" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol"></asp:BoundField>   
                             <asp:BoundField DataField="LocationName" HeaderText="Location Name"></asp:BoundField>
                            <asp:BoundField DataField="BlockName" HeaderText="Block Name"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <ups:PaginationUserControl runat="server" ID="FloorPagination" OnPaginationButtonClick="Floor_PaginationButtonClick" />
                 
 <%--               </ContentTemplate>
            </asp:UpdatePanel>--%>
        </div>
        <asp:HiddenField ID="hdFloorCode" runat="server" Value="" />
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
