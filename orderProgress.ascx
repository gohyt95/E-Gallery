<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="orderProgress.ascx.cs" Inherits="ArtGallery1.orderProgress" %>
<div class="checkoutProcess position-relative">
    <div class="progressBar">
        <div class="progressLine">
            <div id="progressLine" class="percent" runat="server"></div>
        </div>
        <div class="steps">
            <div id="checkout0" class="step" runat="server">
                <p>Checkout</p>
            </div>
            <div id="checkout1" class="step" runat="server">
                <p>Delivery & Shipping</p>
            </div>
            <div id="checkout2" class="step" runat="server">
                <p>Payment</p>
            </div>
            <div id="checkout3" class="step" runat="server">
                <p>Delivered</p>
            </div>
        </div>
    </div>
</div>
