<%@ Page Title="Artist Control" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArtistControl.aspx.cs" Inherits="ArtGallery1.ArtistControl" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <div class="row custom-font">

        <div class="col-2">
            <div class="list-group" id="list-tab" role="tablist">
                <asp:HyperLink runat="server" class="ctm-list ctm-list-action px-2 active" ID="accountCategory" NavigateURL="~/ArtistControl.aspx?tab=account" role="tab">Account Info</asp:HyperLink>
            </div>
            <br />
            <div>
                <asp:Button class="btn custom-login-btn" ID="logoutBtn" runat="server" Text="LOGOUT" OnClick="logoutBtn_Click" Style="height: 27px" />
            </div>
        </div>
        <div class="col-10">
            <div class="tab-content" id="nav-tabContent">

                <div class="tab-pane fade col-8 show active" id="list-account" role="tabpanel">
                    <!-- account info tab -->
                    <h2>Account Information</h2>
                    <div runat="server" ID="profile1" class="alert alert-success hidden-control" role="alert">
                        Profile info updated successfully.
                    </div>
                    <div runat="server" ID="profile2" class="alert alert-danger hidden-control" role="alert">
                        Profile info update failed.
                    </div>
                    <div runat="server" ID="profile3" class="alert alert-success hidden-control" role="alert">
                        Password updated successfully.
                    </div>
                    <div runat="server" ID="profile4" class="alert alert-danger hidden-control" role="alert">
                        Password update failed.
                    </div>
                    <br />
                    <!-- image -->
                    <img id="artistImage" style="max-width: 180px;max-height: 180px;object-fit:cover;" runat="server" ClientIDMode="Static"/>
                    <br /><br />
                    <asp:FileUpload runat="server" class="form-control-file" accept="image/*" name="image" ValidationGroup="account1" id="file" onchange="loadFile(event)"/>
                    <br />
                    <div class="form-group">
                        <!--email-->
                        <asp:Label ID="Label13" runat="server" Text="Email" ForeColor="#CCCCCC"></asp:Label>
                        <asp:TextBox runat="server" class="form-control custom-field1" ID="email" ValidationGroup="account1" TextMode="Email" ReadOnly="True"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <!--First name-->
                        <asp:Label ID="Label1" runat="server" Text="First Name *"></asp:Label>
                        <asp:TextBox ID="firstName" class="form-control custom-field1" runat="server" ValidationGroup="account1" MaxLength="25"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg mb-0 pb-0" ID="fNameRequired" runat="server" ErrorMessage="*First name is required" 
                            ControlToValidate="firstName" ValidationGroup="account1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <!--Last name-->
                        <asp:Label ID="Label2" runat="server" Text="Last Name *"></asp:Label>
                        <asp:TextBox ID="lastName" class="form-control custom-field1" runat="server" ValidationGroup="account1" MaxLength="25"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg mb-0 pb-0" ID="lNameRequired" runat="server" ErrorMessage="*Last name is required" 
                            ControlToValidate="lastName" ValidationGroup="account1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <!--Phone-->
                        <asp:Label ID="Label6" runat="server" Text="Phone *"></asp:Label>
                        <asp:TextBox ID="Phone" class="form-control custom-field1" runat="server" ValidationGroup="account1"  MaxLength="50"></asp:TextBox>
                        <asp:RegularExpressionValidator class="validation-msg mb-0 pb-0" ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Please input a proper phonenumber" 
                            ControlToValidate="Phone" ValidationExpression="^(\+?6?01)[0-46-9]-*[0-9]{7,8}$" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <!--Country-->
                        <asp:Label ID="Label7" runat="server" Text="Country *"></asp:Label>
                        <asp:DropDownList class="form-control custom-field1" ID="countryList" runat="server">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator class="validation-msg mb-0 pb-0" ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Country is required" 
                            ControlToValidate="countryList" ValidationGroup="account1" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <!--Description-->
                        <asp:Label ID="Label8" runat="server" Text="Description *"></asp:Label>
                        <asp:TextBox ID="Description" class="form-control custom-field1" runat="server" ValidationGroup="account1" rows="4" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <br />
                    <br />
                    <asp:Button class="btn custom-login-btn py-2" OnClick="updateBtn_Click" ID="updateBtn1" runat="server" ValidationGroup="account1" Text="UPDATE" />
                    <br />
                    <br />
                    <hr />

                    <!-- Password part -->
                    <h2>
                        Change Password 
                    </h2>
                    <div class="form-group">
                        <!--Old password-->
                        <asp:Label ID="Label3" runat="server" Text="Old Password *"></asp:Label>
                        <asp:TextBox ID="oldPass" class="form-control custom-field1" runat="server" TextMode="Password" ValidationGroup="account2"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" class="validation-msg" ID="lUserNameRequired" runat="server" ControlToValidate="oldPass"
                            ErrorMessage="Password is incorrect" ValidationGroup="account2" />
                    </div>
                    <div class="form-group">
                        <!--New password-->
                        <asp:Label ID="Label4" runat="server" Text="New Password *"></asp:Label>
                        <asp:TextBox ID="newPass" class="form-control custom-field1" runat="server" TextMode="Password" ValidationGroup="account2" ControlToCompare="newPass" ViewStateMode="Inherit"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" class="validation-msg" ID="RequiredFieldValidator1" runat="server" ControlToValidate="newPass"
                            ErrorMessage="Please fill in a new password" ValidationGroup="account2" />
                        <asp:CustomValidator class="validation-msg mb-0 pb-0" ID="CustomValidator2" runat="server" ErrorMessage="CustomValidator" 
                            ClientValidationFunction="cPasswordLength" EnableClientScript="true" ValidationGroup="account2" 
                            ControlToValidate="newPass" Display="Dynamic">
                            *Password length must more than 8 characters
                        </asp:CustomValidator>
                    </div>
                    <div class="form-group">
                        <!--Confirm new password-->
                        <asp:Label ID="Label5" runat="server" Text="Confirm New Password *"></asp:Label>
                        <asp:TextBox ID="newPass2" class="form-control custom-field1" runat="server" TextMode="Password" ValidationGroup="account2"></asp:TextBox>
                        <asp:RequiredFieldValidator Display="Dynamic" class="validation-msg" ID="RequiredFieldValidator2" runat="server" ControlToValidate="newPass2"
                            ErrorMessage="Please reenter new password" ValidationGroup="account2" />
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password not match" ValidationGroup="account2" ControlToValidate="newPass2" ControlToCompare="newPass" ForeColor="Red"></asp:CompareValidator>
                    </div>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="account2" ErrorMessage="*Old password not match" ForeColor="Red" OnServerValidate="validatePassword" Display="None"></asp:CustomValidator>
                    <br />
                    <asp:Button class="btn custom-login-btn py-2" OnClick="updateBtn1_Click" ID="updateBtn2" runat="server" Text="UPDATE PASSWORD" ValidationGroup="account2" />
                    <br />
                    <br />
                    <hr />
                </div>

            </div>
        </div>
    </div>
    <div class="toast success-toast" role="alert">
        <div class="alert alert-success mb-0" role="alert">
            <p class="mb-0"><i class="fa fa-check mr-3" aria-hidden="true"></i></p>
        </div>
    </div>
    <div class="toast fail-toast" role="alert">
        <div class="alert alert-danger mb-0" role="alert">
            <p class="mb-0"><i class="fa fa-info-circle mr-3" aria-hidden="true"></i></p>
        </div>
    </div>
    <script type="text/javascript">
        function displayTab(tab) {
            var selector = tab.toString();
            $("#list-" + selector).addClass("show");
            $("#list-" + selector).addClass("active");
        }

        const toast = (msg, status) => {

            var targetToast = "";

            if (status == "fail") {
                targetToast = ".fail-toast";
            } else if (status == "success") {
                targetToast = ".success-toast";
            }

            $(targetToast).toast({ delay: 5000 });
            $(targetToast).toast('show');

            console.log(document.querySelector(targetToast).childNodes[0]);
            document.querySelector(targetToast).childNodes[1].childNodes[1].innerHTML += msg;
        }

        const cPasswordLength = (source, args) => {
            var password = document.getElementById('<%= newPass.ClientID %>')
            if (password.value.length < 8) {
                args.IsValid = false
            }
            else {
                args.IsValid = true
            }

        }

        var loadFile = function (event) {
            var image = document.getElementById('artistImage');
            image.src = URL.createObjectURL(event.target.files[0]);
        }
    </script>

    <asp:SqlDataSource ID="ArtDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    
        SelectCommand="SELECT  a.artId, a.artistId, a.artName, a.price, 
        a.medium, a.picture, u.artistName, u.country 
        FROM Art a
        JOIN Artist u
        ON a.artistId = u.artistId
        JOIN Wishlist w
        ON a.artId = w.artId
        JOIN Customer c
        ON w.custId = c.custId
        WHERE c.custId = @custId
                    
                       
        ">
        <SelectParameters>
            <asp:SessionParameter Name="custId" SessionField="custId" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="orderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT Orders.orderId, Orders.totalPrice, Orders.orderDate, Orders.shipTo, Cart.cartId, Cart.custId, Cart.artId, Cart.quantity, Cart.orderId AS Expr1, Cart.itemStatus, Art.artId AS Expr2, Art.artistId, Art.artName, Art.price, Art.stock, Art.description, Art.material, Art.medium, Art.style, Art.picture, Art.width, Art.height, Art.date, Artist.artistId AS Expr3, Artist.artistName, Artist.artistEmail, Artist.artistPassword, Artist.artistPhone, Artist.description AS Expr4, Artist.country, Customer.custId AS Expr5, Customer.firstName, Customer.lastName, Customer.custEmail, Customer.custPassword, Customer.custPhone, Cart.quantity * Art.price AS totalPrice FROM Orders INNER JOIN Cart ON Orders.orderId = Cart.orderId INNER JOIN Art ON Cart.artId = Art.artId INNER JOIN Artist ON Art.artistId = Artist.artistId INNER JOIN Customer ON Cart.custId = Customer.custId WHERE (Cart.custId = @custId) AND (Cart.itemStatus &gt; 1)">
        <SelectParameters>
            <asp:SessionParameter Name="custId" SessionField="custId" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ordersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="SELECT Orders.orderId, Orders.totalPrice, Orders.orderDate FROM Orders INNER JOIN Cart ON Orders.orderId = Cart.orderId INNER JOIN Art ON Cart.artId = Art.artId INNER JOIN Artist ON Art.artistId = Artist.artistId INNER JOIN Customer ON Cart.custId = Customer.custId WHERE (Cart.custId = @custId) AND (Cart.itemStatus &gt; 1) GROUP BY Orders.orderId, Orders.totalPrice, Orders.orderDate">
        <SelectParameters>
            <asp:SessionParameter Name="custId" SessionField="custId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

