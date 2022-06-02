<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="ArtGallery1.OrderDetails" %>
<%@ Register TagPrefix="ORDER" TagName="STATUS" Src="~/orderProgress.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<asp:LinkButton runat="server" class="carousel-btn" ID="returnBtn" PostBackUrl="~/UserControl.aspx?tab=orders">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
        <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
    </svg>&nbsp;<span style="vertical-align:sub;font-size:1.5em">Back</span>
</asp:LinkButton>  
    <br />
    <br />
        <div class="container checkout">
            <div class="row mb-5">
                <div class="col-12 checkout-header">
                    <h1>
                        Order Details
                    </h1>
                    <ORDER:STATUS ID="chekoutStatus" runat="server" CurrentPhase="3" />
                </div>
                <div class="col-12 checkout-orderContent">
                    <div class="checkout-collapse-btn d-flex justify-content-between" data-toggle="collapse" data-target="#checkoutOrderItem">
                        <h1 class="d-inline mb-0">Art Ordered</h1>
                        <i class="fa fa-caret-up" aria-hidden="true"></i>
                    </div>
                    <div class="collapse show" id="checkoutOrderItem">
                        <div class="checkout-orderHeader row border-top border-bottom py-2 mb-3">
                            <div class="col-6">
                                PRODUCT DETAILS
                            </div>
                            <div class="col-2">
                                QUANTITY
                            </div>
                            <div class="col-2">
                                PRICE (RM)
                            </div>
                            <div class="col-2 text-right">
                                TOTAL (RM)
                            </div>
                        </div>
                        <asp:Repeater ID="checkoutItemRepeater" runat="server" DataSourceID="orderDataSource">
                            <ItemTemplate>
                                <div class="checkout-orderItem row align-items-center mb-3">
                                    <div class="col-6 d-flex">
                                        <img src="/source/<%#Eval("picture") %>" alt="checkout Item Picture" class="mr-3" />
                                        <div class="checkoutItem-details">
                                            <p><%#Eval("artName") %></p>
                                            <p>Author: <b><%#Eval("artistName") %></b></p>
                                            <p>Dimension: <b><%#Eval("width") %> x <%#Eval("height") %></b></p>
                                            <p><%#Eval("material") %>, <%#Eval("medium") %>, <%#Eval("style") %></p>
                                            <p><%#Eval("country") %></p>
                                        </div>
                                    </div>
                                    <div class="col-2">
                                        <%#Eval("quantity") %>
                                    </div>
                                    <div class="col-2">
                                        <%# String.Format("{0:n2}", Convert.ToDouble(Eval("price")))%>
                                    </div>
                                    <div class="col-2 text-right">
                                        <%# String.Format("{0:n2}", Convert.ToDouble(Eval("totalPrice1")))%>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="col-12 checkout-summary d-flex justify-content-between">
                    <h1 class="mb-0">Order Summary</h1>
                    <div class="checkout-summary-content d-flex">
                        <div class="itemTotal d-flex align-items-center">
                            <p runat="server" id="orderSummaryItem" class="mr-3"></p>
                            <p class="ml-1 price" runat="server" id="orderSummaryPrice"></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-12 checkout-address">
                    <h1 class="mb-3">Shipping Address</h1>
                    <div class="row">
                        <div class="col-9">
                            <div class="d-flex mb-4">
                                <div class="w-100">
                                    <asp:Label ID="lblShipTo" runat="server" Text="Ship To:" CssClass="d-block"></asp:Label>
                                    <asp:TextBox ID="txtShipTo" runat="server" TextMode="MultiLine" Rows="5" CssClass="d-block w-100" style="max-width: none;"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-3 d-flex flex-column justify-content-between checkout-address-action">
                            <div class="checkout-final">
                                <div class="d-flex justify-content-between">
                                    <p>Art Subtotal</p>
                                    <p runat="server" id="orderTotalArt1"></p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p>Shipping Total</p>
                                    <p runat="server" id="orderTotalShipping1">RM10.00</p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p>Total Payment</p>
                                    <p runat="server" id="orderTotalFinal1" ClientIDMode="Static"></p>
                                </div>
                                <a href="~/Payment.aspx" id="btnPayNow" class="btn btnPrimary w-100" runat="server">Pay Now</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="toast success-toast" role="alert">
                <div class="alert alert-success mb-0" role="alert">
                    <p class="mb-0"><i class="fa fa-check mr-3" aria-hidden="true"></i></p>
                </div>
            </div>
        </div>
        <script>
            const collapsibleBtns = document.querySelectorAll(".checkout-collapse-btn");

            collapsibleBtns.forEach(btn => {
                btn.addEventListener("click", (e) => {
                    var caret;

                    if (e.target.tagName == "DIV")
                        caret = e.target.childNodes[3];
                    else if (e.target.tagName == "H1")
                        caret = e.target.parentNode.childNodes[3];
                    else if (e.target.tagName == "I")
                        caret = e.target;

                    if (caret.style.transform != 'rotate(0deg)')
                        caret.style.transform = 'rotate(0deg)';
                    else
                        caret.style.transform = 'rotate(180deg)';
                })
            });
        </script>
    <asp:SqlDataSource ID="orderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT Orders.orderId, Orders.totalPrice, Orders.orderDate, Orders.shipTo, Cart.cartId, Cart.custId, Cart.artId, Cart.quantity, Cart.orderId AS Expr1, Cart.itemStatus, Art.artId AS Expr2, Art.artistId, Art.artName, Art.price, Art.stock, Art.description, Art.material, Art.medium, Art.style, Art.picture, Art.width, Art.height, Art.date, Artist.artistId AS Expr3, Artist.artistName, Artist.artistEmail, Artist.artistPassword, Artist.artistPhone, Artist.description AS Expr4, Artist.country, Customer.custId AS Expr5, Customer.firstName, Customer.lastName, Customer.custEmail, Customer.custPassword, Customer.custPhone, Cart.quantity * Art.price AS totalPrice1 FROM Orders INNER JOIN Cart ON Orders.orderId = Cart.orderId INNER JOIN Art ON Cart.artId = Art.artId INNER JOIN Artist ON Art.artistId = Artist.artistId INNER JOIN Customer ON Cart.custId = Customer.custId WHERE (Cart.custId = @custId) AND (Cart.itemStatus &gt; 1) AND (Orders.orderId = @orderId)">
        <SelectParameters>
            <asp:SessionParameter Name="custId" SessionField="custId" />
            <asp:QueryStringParameter Name="orderId" QueryStringField="orderId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
