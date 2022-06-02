<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="ArtGallery1.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container cart">
            <div class="row">
                <div class="col-12 cart-content">
                        <asp:SqlDataSource ID="cartDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Art.artName, Artist.artistName, Art.width, Art.height, Art.picture, Art.material, Art.medium, Art.style, Artist.country, Cart.quantity, Art.price, Cart.quantity * Art.price AS totalPrice, Art.stock, Art.artId
FROM Cart
Join Customer ON Cart.custId = Customer.custId
Join Art ON Cart.artId = Art.artId
Join Artist On Artist.artistId = Art.artistId
WHERE cart.custId = @custId
AND cart.itemStatus = 1">
                            <SelectParameters>
                                <asp:SessionParameter Name="custId" SessionField="custId" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <h1>Your Cart</h1>
                    <div class="cart-header row border-top border-bottom py-2 mb-3">
                        <div class="col-5">
                            PRODUCT DETAILS
                        </div>
                        <div class="col-2">
                            QUANTITY
                        </div>
                        <div class="col-2">
                            PRICE (RM)
                        </div>
                        <div class="col-2">
                            TOTAL (RM)
                        </div>
                        <div class="col-1">
                            ACTION
                        </div>
                    </div>
                    <asp:Repeater ID="cartItemRepeater" runat="server" DataSourceID="cartDataSource">
                        <ItemTemplate>
                            <div class="cart-item row align-items-center mb-3">
                                <div class="col-5 d-flex">
                                    <a href="ArtDetail.aspx?art=<%#Eval("artId") %>">
                                        <img src="/source/<%#Eval("picture") %>" alt="Cart Item Picture" class="mr-3"/>
                                    </a>
                                    <div class="cartItem-details">
                                        <a href="ArtDetail.aspx?art=<%#Eval("artId") %>"><%#Eval("artName") %></a>
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
                                <div class="col-2">
                                    <%# String.Format("{0:n2}", Convert.ToDouble(Eval("totalPrice")))%>
                                </div>
                                <div class="col-1">
                                    <asp:Button ID="btnDeleteCartItem" runat="server" Text="Delete" CssClass="btn btn-link text-danger p-0" OnClick="cartDeleteItem" data-id='<%#Eval("artId") %>'/>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <hr />
            <div class="row justify-content-end my-4">
                <div class="col-12 cart-summary d-flex justify-content-between">
                    <h1 class="mb-0">Order Summary</h1>
                    <div class="cart-summary-content d-flex">
                        <div class="itemTotal d-flex align-items-center">
                            <p runat="server" id="cartSummaryItem"></p>
                            <p class="ml-1 price" runat="server" id="cartSummaryPrice"></p>
                        </div>
                        <a href="Checkout.aspx" class="btn btnPrimary ml-3">Checkout</a>
                    </div>
                </div>
            </div>
            <div class="toast success-toast" role="alert">
                <div class="alert alert-success mb-0" role="alert">
                    <p class="mb-0"><i class="fa fa-check mr-3" aria-hidden="true"></i></p>
                </div>
            </div>
        </div>
        <div class="container empty-cart d-flex flex-column align-items-center">
            <div class="cart-empty-pic d-flex justify-content-center align-items-center p-3">
                <img src="source/cartEmpty.png" alt="cart empty" />
            </div>
            <h1 class="mb-4">Your Cart Is Empty!</h1>
            <a href="Art.aspx" class="btn btnPrimary">Browse Some Arts</a>
        </div>
        <script>
            const toast = (msg, status) => {

                var targetToast = "";

                if (status == "info") {
                    targetToast = ".info-toast";
                } else if (status == "success") {
                    targetToast = ".success-toast";
                }

                $(targetToast).toast({ delay: 5000 });
                $(targetToast).toast('show');

                document.querySelector(targetToast).childNodes[1].childNodes[1].innerHTML += msg;
            }

            const emptyCart = () => {
                document.querySelector(".cart").classList.add("d-none");
                document.querySelector(".empty-cart").style.visibility = "visible";
            }
        </script>


</asp:Content>
