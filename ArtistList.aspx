<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArtistList.aspx.cs" Inherits="ArtGallery1.ArtistList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="art-content row justify-content-start">
    <asp:Repeater ID="repArt" runat="server" DataSourceID="ArtDataSource" >
        <ItemTemplate>
            <div class="col-3">
                <div class="card">
                    <a href="ArtistProfile.aspx?id=<%#Eval("artistId") %>">
                        <img class="card-img-top w-100" src="/usersource/<%#Eval("artistPicture") %>" alt="Card image cap">
                    </a>

                    &nbsp;&nbsp;&nbsp;<div class="card-body">
                        <a href="ArtistProfile.aspx?id=<%#Eval("artistId") %>" class="art-name"><%#Eval("artistName") %></a>                        
                        <p class="art-medium"><%#Eval("country") %></p>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>

    <asp:SqlDataSource ID="ArtDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [artistId], [artistName], [country], [artistPicture] FROM [Artist]">
    </asp:SqlDataSource>
        </div>
</asp:Content>
