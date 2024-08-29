<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaginationUserControls.ascx.cs" Inherits="AssetMobileApplication.UserControls.PaginationUserControls" %>
<nav aria-label="Page navigation">
    <ul class="pagination">
        <li class="page-item" runat="server" id="liFirst">
            <asp:LinkButton CssClass="page-link" ID="lnkFirst" Text="First" runat="server" CommandName="First" OnCommand="lnkPageNavigation_Command" aria-label="First">
            </asp:LinkButton>
        </li>
        <li class="page-item" runat="server" id="liPrevious">
            <asp:LinkButton CssClass="page-link" ID="lnkPrevious" runat="server" CommandName="Previous" OnCommand="lnkPageNavigation_Command" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
                <span class="sr-only">Previous</span>            
            </asp:LinkButton>
        </li>
        <asp:Repeater ID="rptrPagination" runat="server" OnItemCommand="rptrPagination_ItemCommand">
            <ItemTemplate>
                <li runat="server" id="liPageItem" class='<%# Convert.ToBoolean(Eval("Enabled")) ? "page-item" : "page-item active" %>'>
                    <asp:LinkButton ID="lnkrptpagination" Text='<%# Eval("Text") %>' CommandName="PageNumber" CommandArgument='<%# Eval("Value") %>' runat="server" 
                        OnClientClick='<%# !Convert.ToBoolean(Eval("Enabled")) ? "return false;" : "" %>'> ></asp:LinkButton>
                </li>
            </ItemTemplate>
        </asp:Repeater>
        <li class="page-item" runat="server" id="liNext">
            <asp:LinkButton CssClass="page-link" ID="lnkNext" runat="server" CommandName="Next" OnCommand="lnkPageNavigation_Command" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
                <span class="sr-only">Next</span>            
            </asp:LinkButton>
        </li>
        <li class="page-item" runat="server" id="liLast">
            <asp:LinkButton CssClass="page-link" ID="lnkLast" Text="LAST" runat="server" CommandName="Last" OnCommand="lnkPageNavigation_Command" aria-label="Last">
            </asp:LinkButton>
        </li>
        <li class="page-item">
            <asp:Label ID="lblPageStatus" runat="server"></asp:Label>            
        </li>
    </ul>
</nav>
<br />
