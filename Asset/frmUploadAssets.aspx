<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="frmUploadAssets.aspx.cs" Inherits="AssetMobileApplication.Asset.frmUploadAssets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container-fluid">
        <div class="block-header">
            <ol class="breadcrumb breadcrumb-col-indigo">
                <li><a href="javascript:void(0);"><i class="material-icons">home</i> Home</a></li>
                <li><a href="javascript:void(0);"><i class="material-icons">create</i> Masters </a>
                <li><a href="javascript:void(0);"> Asset Upload </a> </li>
            <div class="inventory_download" style="background-color: linen; height: 1px; padding-left: 900px;">
    <a href="../Template/testupload.xlsx" style="font-size: initial; color: black; text-decoration: underline; font-family:''">
        Download Template
    </a>   
</div>

               
              <%--  <li class="active">Asset Upload</li>--%>
            </ol>
        </div>
        <div class="container-group">
            <div class="col-md-6">
                <div class="control-group">
                    <div style="margin-left: 125px" class="control-left">
                        <asp:Label ID="Label2" runat="server" Text="Select File"></asp:Label>
                        <span class="mandatory">*</span>
                    </div>
                    <div style="margin-left: -140px" class="control-right">
                        <asp:FileUpload ID="FileUpload1" Style="display: inline-block" runat="server" ClientIDMode="Static" />
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="control-left">
                    <asp:LinkButton ID="butload" ToolTip="Save the Details" runat="server" CssClass="btn btn-primary waves-effect"
                        OnClick="butload_Click">LoadData</asp:LinkButton>
                </div>
            </div>
            <div style="margin-top:5px" class="col-md-12">
                <asp:Label ID="Label1" runat="server"></asp:Label>
                <asp:UpdatePanel ID="UpdatePanel2" runat="Server">
                    <ContentTemplate>
                        <div class="GridDetails" style="overflow-x: hidden; overflow-y: scroll; height: 400px; width: 100%; background-color: aliceblue; text-align: center; margin-top: 20px;">
                            <asp:GridView ID="gvItemupload" runat="server" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true"
                                CssClass="pshro_GridDgn" AllowPaging="false" >
                                <EmptyDataTemplate>
                                    <asp:Label ID="Label3" runat="server" Text="No Records Found"></asp:Label>
                                </EmptyDataTemplate>
                                <HeaderStyle CssClass="pshro_GridDgnHeaderCellCenter" />
                                <RowStyle CssClass="pshro_GridDgnStyle" />
                                <AlternatingRowStyle CssClass="pshro_GridDgnStyle_Alternative" />
                                <PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last"
                                    NextPageText="Next" PreviousPageText="Previous" Position="Bottom" />
                                <PagerStyle CssClass="pshro_text" />
                                <Columns>                                
                                </Columns>
                            </asp:GridView>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col-md-12">
                <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                    <ContentTemplate>
                        <div class="button-control">
                            <asp:LinkButton ID="lnkUpload" runat="server" CssClass="btn btn-primary waves-effect" OnClick="lnkUpload_Click">Upload</asp:LinkButton>
                            <asp:LinkButton ID="lnkClear" runat="server" CssClass="btn btn-danger waves-effect" OnClick="lnkClear_Click" >Clear</asp:LinkButton>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </div>

</asp:Content>
