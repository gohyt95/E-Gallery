<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="ArtGallery1.Checkout" %>
<%@ Register TagPrefix="ORDER" TagName="STATUS" Src="~/orderProgress.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <asp:SqlDataSource ID="checkoutDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Art.artName, Artist.artistName, Art.width, Art.height, Art.picture, Art.material, Art.medium, Art.style, Artist.country, Cart.quantity, Art.price, Cart.quantity * Art.price AS totalPrice, Art.stock, Art.artId
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
        <div class="container checkout">
            <div class="row mb-5">
                <div class="col-12 checkout-header">
                    <h1>Checkout</h1>
                    <ORDER:STATUS ID="chekoutStatus" runat="server" CurrentPhase="1" />
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
                        <asp:Repeater ID="checkoutItemRepeater" runat="server" DataSourceID="checkoutDataSource">
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
                                        <%# String.Format("{0:n2}", Convert.ToDouble(Eval("totalPrice")))%>
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
                            <p runat="server" id="checkoutSummaryItem" class="mr-3"></p>
                            <p class="ml-1 price" runat="server" id="checkoutSummaryPrice"></p>
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
                                <div class="w-100 mr-5">
                                    <asp:Label ID="lblFirstNameCheckout" runat="server" Text="FirstName"></asp:Label>
                                    <asp:TextBox ID="txtFirstNameCheckout" runat="server" ControlToValidate="txtFirstNameCheckout"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="First Name is Required" ControlToValidate="txtFirstNameCheckout" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtFirstNameCheckout"
                                        ErrorMessage="First Name cannot contains symbol/number and must between 2 to 50 characters" 
                                        ValidationExpression="[a-zA-Z ]{2,50}" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                                <div class="w-100">
                                    <asp:Label ID="lblLastNameCheckout" runat="server" Text="LastName"></asp:Label>
                                    <asp:TextBox ID="txtLastNameCheckout" runat="server" MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Last Name is Required" ControlToValidate="txtLastNameCheckout" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtLastNameCheckout"
                                        ErrorMessage="Last Name cannot contains symbol/number and must between 2 to 50 characters" 
                                        ValidationExpression="[a-zA-Z ]{2,50}" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="mb-4">
                                <asp:Label ID="lblStreetCheckout" runat="server" Text="Street"></asp:Label>
                                <asp:TextBox ID="txtStreetCheckout" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Street is Required" ControlToValidate="txtStreetCheckout" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                            <div class="d-flex mb-4">
                                <div class="w-100 mr-5">
                                    <asp:Label ID="lblCityCheckout" runat="server" Text="City"></asp:Label>
                                    <asp:TextBox ID="txtCityCheckout" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="City is Required" ControlToValidate="txtCityCheckout" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtCityCheckout"
                                        ErrorMessage="City cannot contains symbol/number and must between 2 to 50 characters" 
                                        ValidationExpression="[a-zA-Z ]{2,50}" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                                <div class="w-100">
                                    <asp:Label ID="lblStateCheckout" runat="server" Text="Label">State</asp:Label>
                                    <asp:TextBox ID="txtStateCheckout" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="State is Required" ControlToValidate="txtStateCheckout" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        ID="RegularExpressionValidator5" runat="server" ControlToValidate="txtStateCheckout"
                                        ErrorMessage="State cannot contains symbol/number and must between 2 to 50 characters" 
                                        ValidationExpression="[a-zA-Z ]{2,50}" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="d-flex mb-4">
                                <div class="w-100 mr-5">
                                    <asp:Label ID="lblPostalCheckout" runat="server" Text="Label">Postal Code</asp:Label>
                                    <asp:TextBox ID="txtPostalCheckout" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Postal Code is Required" ControlToValidate="txtPostalCheckout" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtPostalCheckout"
                                        ErrorMessage="Incorrect Postal Code Format (eg 89500)" 
                                        ValidationExpression="[0-9]{5}" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                                <div class="w-100">
                                    <asp:Label ID="lblPhoneCheckout" runat="server" Text="Label">Phone</asp:Label>
                                    <asp:TextBox ID="txtPhoneCheckout" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Phone is Required" ControlToValidate="txtPhoneCheckout" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtPhoneCheckout"
                                        ErrorMessage="Incorrect phone format (eg 0123456789)" 
                                        ValidationExpression="01(1\d{8}|[2-9]\d{7})" Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                        </div>
                        <div class="col-3 d-flex flex-column justify-content-between checkout-address-action">
                            <asp:RadioButtonList ID="rbCheckoutAddress" runat="server" ClientIDMode="Static" AutoPostBack="true">
                                <asp:ListItem Value="0" Selected="True">Use My Address</asp:ListItem>
                                <asp:ListItem Value="1">Use Another Address</asp:ListItem>
                            </asp:RadioButtonList>
                            <hr />
                            <div class="checkout-final">
                                <div class="d-flex justify-content-between">
                                    <p>Art Subtotal</p>
                                    <p runat="server" id="orderTotalArt"></p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p>Shipping Total</p>
                                    <p runat="server" id="orderTotalShipping">RM10.00</p>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <p>Total Payment</p>
                                    <p runat="server" id="orderTotalFinal" ClientIDMode="Static"></p>
                                </div>
                                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btnPrimary w-100" OnClick="btnPlaceOrder_Click" UseSubmitBehavior="false"/>
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

</asp:Content>
