<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="ArtGallery1.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%: Page.Title %> - My ASP.NET Application</title>
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=EB+Garamond" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/popper.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
    <webopt:bundlereference runat="server" path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
</head>
<body>
    <form id="form1" runat="server">
       <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                    <div class="modal-header">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                          <li class="nav-item" role="presentation">
                            <a runat="server" class="nav-link active" id="cSign" data-toggle="tab" href="#cSigntab" role="tab">Customer</a>
                          </li>
                          <li class="nav-item" role="presentation">
                            <a runat="server" class="nav-link" id="aSign" data-toggle="tab" href="#aSigntab" role="tab">Artist</a>
                          </li>
                        </ul>
                        <asp:LinkButton ID="signupCancel" class="close" runat="server" OnClick="cancelBtn" PostBackUrl="~/login.aspx">
                            <span class="goldone" aria-hidden="true">&times;</span>
                        </asp:LinkButton>
                    </div>
                <div class="tab-content" id="myTabContent">
                      <div runat="server" class="tab-pane fade show active" id="cSigntab" role="tabpanel" aria-labelledby="home-tab">
                            <div class="modal-body" align="center">
                                    <h4 class="custom-font font-bold mb-3">
                                        Customer Signup
                                    </h4>
                                    <asp:Label class="custom-font text-success" ID="cSignupSuccess" runat="server" Text=""></asp:Label>
                                    <asp:CustomValidator class="validation-msg mb-0 pb-0 custom-font" ValidationGroup="csignup" ID="cSignUpFail" runat="server" Display="Dynamic" 
                                               onservervalidate="CduplicateEmail" ErrorMessage="*Email existed" ForeColor="Red">
                                    </asp:CustomValidator>
                                    <div class="form-group mb-0 pb-0" align="center" >
                                            <asp:TextBox CssClass="form-control custom-field1" ID="cfName" MaxLength="25" placeholder="First name" runat="server" ValidationGroup="csignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="cfNameRequired" runat="server" ErrorMessage="RequiredFieldValidator"
                                                ControlToValidate="cfName" ValidationGroup="csignup" Display="Dynamic">
                                                *First name is required
                                            </asp:RequiredFieldValidator>
                                            <br />
                                            <asp:TextBox CssClass="form-control custom-field1" ID="clName" MaxLength="25" placeholder="Last name" runat="server" ValidationGroup="csignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="clNameRequired" runat="server" ErrorMessage="RequiredFieldValidator"
                                                ControlToValidate="clName" ValidationGroup="csignup" Display="Dynamic">
                                                *Last name is required
                                            </asp:RequiredFieldValidator>
                                            <br />
                                            <asp:TextBox CssClass="form-control custom-field1" ID="sUserName" MaxLength="50" placeholder="Email" runat="server" ValidationGroup="csignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="sUserNameRequired" runat="server" ControlToValidate="sUserName"
                                                ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="csignup" Display="Dynamic">
                                                *Email is required
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator class="validation-msg" ID="cRegEx" runat="server" ErrorMessage="RegularExpressionValidator" 
                                                ValidationGroup="csignup" ControlToValidate="sUserName" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">
                                                *Invalid email address
                                            </asp:RegularExpressionValidator>
                                            <br />
                                            <asp:TextBox CssClass="form-control custom-field1" ID="sPassword" MaxLength="20" placeholder="Password" runat="server" TextMode="Password" ValidationGroup="csignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg mb-0 pb-0" ID="sPasswordRequired" runat="server" ControlToValidate="sPassword" 
                                                ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="csignup" Display="Dynamic">
                                                *Password is required
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator class="validation-msg mb-0 pb-0" ID="cpassLen" runat="server" ErrorMessage="CustomValidator" 
                                                ClientValidationFunction="cPasswordLength" EnableClientScript="true" ValidationGroup="csignup" 
                                                ControlToValidate="sPassword" Display="Dynamic">
                                                *Password length must more or equal 8 characters
                                            </asp:CustomValidator>
                                            <br />
                                            <br />
                                            <asp:Button ID="signupBtn" class="btn custom-login-btn custom-font" runat="server" CommandName="Login" 
                                                Text="SIGN UP" ValidationGroup="csignup" OnClick="csignupBtn_Click"/>
                                            <br />
                                    </div>
                            </div>
                      </div>
                      <div runat="server" class="tab-pane fade" id="aSigntab" role="tabpanel" aria-labelledby="home-tab">
                            <div class="modal-body" align="center">
                                    <h4 class="custom-font font-bold mb-3">
                                        Artist Signup
                                    </h4>
                                    <asp:Label class="custom-font text-success" ID="aSignupSuccess" runat="server" Text=""></asp:Label>
                                    <asp:CustomValidator class="validation-msg mb-0 pb-0 custom-font" ValidationGroup="asignup" ID="aloginFail" runat="server" Display="Dynamic" 
                                                onservervalidate="AduplicateEmail" ErrorMessage="Email existed" ForeColor="Red">
                                    </asp:CustomValidator>
                                    <div class="form-group mb-0 pb-0" align="center" >
                                            <asp:TextBox CssClass="form-control custom-field1" ID="afName" MaxLength="25" placeholder="First name" runat="server" ValidationGroup="asignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="afNameRequired" runat="server" ErrorMessage="RequiredFieldValidator"
                                                ControlToValidate="afName" ValidationGroup="asignup" Display="Dynamic">
                                                *First name is required
                                            </asp:RequiredFieldValidator>
                                            <br />
                                            <asp:TextBox CssClass="form-control custom-field1" ID="alName" MaxLength="25" placeholder="Last name" runat="server" ValidationGroup="asignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="alNameRequired" runat="server" ErrorMessage="RequiredFieldValidator"
                                                ControlToValidate="alName" ValidationGroup="asignup" Display="Dynamic">
                                                *Last name is required
                                            </asp:RequiredFieldValidator>
                                            <br />
                                            <asp:TextBox CssClass="form-control custom-field1" ID="aUserName" MaxLength="50" placeholder="Email" runat="server" ValidationGroup="asignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="aUserNameRequired" runat="server" ControlToValidate="aUserName"
                                                ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="asignup" Display="Dynamic">
                                                *Email is required
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator class="validation-msg" ID="aRegEx" runat="server" ErrorMessage="RegularExpressionValidator" 
                                                ValidationGroup="asignup" ControlToValidate="aUserName" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">
                                                *Invalid email address
                                            </asp:RegularExpressionValidator>
                                            <br />
                                            <asp:TextBox CssClass="form-control custom-field1" ID="aPassword" MaxLength="20" placeholder="Password" runat="server" TextMode="Password" ValidationGroup="asignup"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg mb-0 pb-0" ID="aPasswordRequired" runat="server" ControlToValidate="aPassword" 
                                                ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="asignup" Display="Dynamic">
                                                *Password is required
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator class="validation-msg mb-0 pb-0" ID="apassLen" runat="server" ErrorMessage="CustomValidator" 
                                                ClientValidationFunction="aPasswordLength" EnableClientScript="true" ValidationGroup="asignup" 
                                                ControlToValidate="aPassword" Display="Dynamic">
                                                *Password length must more than 8 characters
                                            </asp:CustomValidator>
                                            <br />
                                            <br />
                                            <asp:Button ID="Button1" class="btn custom-login-btn custom-font" runat="server" CommandName="Login" 
                                                Text="SIGN UP" ValidationGroup="asignup" OnClick="asignuupBtn_Click"/>
                                            <br />
                                    </div>
                            </div>
                      </div>
                </div>
                <div class="modal-footer justify-content-center" >
                    <div class="navi-signup">
                            Already have an account? 
                        <asp:HyperLink class="sign-up-nav" NavigateUrl="~/login.aspx" ID="HyperLink1" runat="server">Log in</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">
    const cPasswordLength = (source, args) => {
        var password = document.getElementById('<%= sPassword.ClientID %>')
        if (password.value.length < 8) {
            args.IsValid = false
        }
        else {
            args.IsValid = true
        }

    }

    const aPasswordLength = (source, args) => {
        var password = document.getElementById('<%= aPassword.ClientID %>')
        if (password.value.length < 8) {
            args.IsValid = false
        }
        else {
            args.IsValid = true
        }

    }

</script>
</html>

