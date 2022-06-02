<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PaymentSuccess.aspx.cs" Inherits="ArtGallery1.PaymentSuccess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-column align-items-center">
        <img src='/source/ordersuccess.jpg' class="w-25"/>
        <h1>Payment Successfully!</h1>
        <p>We have send an email receipt to <asp:Label ID="txtEmail" runat="server" Text=""></asp:Label></p>
        <p>We will deliver your product in no time!</p>
        <a href="Art.aspx" class="btn btnPrimary">View More Arts</a>
    </div>
</asp:Content>
