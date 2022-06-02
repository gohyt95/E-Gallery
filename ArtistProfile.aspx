<%@ Page Title="Artist Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArtistProfile.aspx.cs" Inherits="ArtGallery1.ArtistProfile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<asp:LinkButton runat="server" class="carousel-btn" ID="backBtn" OnClick="returnBtn_Click">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
        <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
    </svg>&nbsp;<span style="vertical-align:sub;font-size:1.5em">Back</span>
</asp:LinkButton>  
<br />
<br />
<div class="card mb-3" style="border: none;outline: none;">
  <div class="row no-gutters">
    <div class="col-md-3">
      <div class="card-body h-100">
        <div class="card-body d-flex h-100" >
                <img src="usersource/" runat="server" id="artDetailArtistPic" alt="artistProfile" class="align-self-center w-100 artist-profile-img"/>
        </div>
      </div>
    </div>
    <div class="col-md-9 ">
        <div class="card-body mt-3">
            <h2 runat="server" class="card-title custom-font" ID="artistName"></h2>
            <p runat="server" class="card-text" id="artistCountry" style="font-size:1.1em">Country: </p>
            <p runat="server" class="card-text" id="artistEmail" style="font-size:1.1em">Email: </p>
            <p runat="server" class="card-text" id="artistDesc" style="font-size:1.1em"></p>
            <!--<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>-->
        </div>
    </div>
  </div>
</div>
<hr />
<h4 class="custom-font">Arts</h4>
<br />
<div class="art-content row justify-content-start">
    <asp:Repeater ID="repArt" runat="server" DataSourceID="SqlDataSource1">
        <ItemTemplate>
            <div class="col-3">
            <div class="card">
                <a href="ArtDetail.aspx?art=<%#Eval("artId") %>">
                    <img class="card-img-top w-100" src="/source/<%#Eval("picture") %>" alt="Card image cap">
                </a><div class="card-body">
                    <a href="ArtDetail.aspx?art=<%#Eval("artId") %>" class="art-name"><%#Eval("artName") %></a>
                    <p class="art-medium"><%#Eval("medium") %></p>
                    <p class="art-price">RM <%# String.Format("{0:n2}", Convert.ToDouble(Eval("price")))%></p>
                </div>
            </div>
                </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="SELECT artId, artistId, artName, price, stock, description, material, medium, style, picture, width, height, date, isDelete FROM Art WHERE (artistId = @artistId)">
    <SelectParameters>
        <asp:QueryStringParameter Name="artistId" QueryStringField="id" />
    </SelectParameters>
</asp:SqlDataSource>

</asp:Content>

