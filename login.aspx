<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="ArtGallery1.login" %>

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
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <div class="container">
            <div class="modal-dialog modal-dialog-centered w-50">
                <div class="modal-content">
                    <div class="modal-header">
                        <!--<h5 class="modal-title custom-font">The A4 Gallery</h5>-->
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                          <li class="nav-item" role="presentation">
                            <a runat="server" class="nav-link active" id="cLog" data-toggle="tab" href="#cLogtab" role="tab">Customer</a>
                          </li>
                          <li class="nav-item" role="presentation">
                            <a runat="server" class="nav-link" id="aLog" data-toggle="tab" href="#aLogtab" role="tab">Artist</a>
                          </li>
                        </ul>
                        <asp:LinkButton ID="loginCancel" class="close" runat="server" OnClick="cancelBtn">
                            <span class="goldone" aria-hidden="true">&times;</span>
                        </asp:LinkButton>
                    </div>
                    <div class="tab-content" id="myTabContent">
                      <div runat="server" class="tab-pane fade show active" id="cLogtab" role="tabpanel" aria-labelledby="home-tab">
                          <div class="modal-body" align="center">
                                <h4 class="custom-font font-bold mb-3">
                                    Customer Login
                                </h4>
                                <div class="form-group mb-0 pb-0">
                                        <asp:TextBox CssClass="form-control custom-field1" ID="clUserName" MaxLength="50" placeholder="Email" runat="server" ValidationGroup="clogin"></asp:TextBox>
                                        <asp:RequiredFieldValidator class="validation-msg" ID="clUserNameRequired" runat="server" ControlToValidate="clUserName"
                                            ErrorMessage="Email is required." ToolTip="User Name is required." ValidationGroup="clogin" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator class="validation-msg" ID="clRegEx" runat="server" ErrorMessage="RegularExpressionValidator" 
                                            ValidationGroup="clogin" ControlToValidate="clUserName" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">
                                            *Invalid email address
                                        </asp:RegularExpressionValidator>
                                        <br />
                                        <asp:TextBox CssClass="form-control custom-field1" ID="clPassword" MaxLength="20" placeholder="Password" runat="server" TextMode="Password" ValidationGroup="clogin"></asp:TextBox>
                                        <asp:RequiredFieldValidator class="validation-msg mb-0 pb-0" ID="clPasswordRequired" runat="server" ControlToValidate="clPassword" 
                                            ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="clogin" Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator class="validation-msg mb-0 pb-0" ID="cpassLen" runat="server" ErrorMessage="CustomValidator" 
                                            ClientValidationFunction="cPasswordLength" EnableClientScript="true" ValidationGroup="clogin" 
                                            ControlToValidate="clPassword" Display="Dynamic">
                                            *Password length must more than 8 characters
                                        </asp:CustomValidator>
                                        <br />
                                        <asp:CustomValidator class="validation-msg mb-0 pb-0 custom-font" ValidationGroup="clogin" ID="cloginFail" runat="server" Display="Dynamic" ErrorMessage="Wrong email or password" ForeColor="Red" OnServerValidate="loginFail_ServerValidate"></asp:CustomValidator>
                                        <br />                                        
                                        <asp:Button ID="forgotBtn" runat="server" CssClass="forgot-pass"  Text="-Forgot Password?-" OnClick="forgotPwd_Click"/> 
                                        <br />
                                        <br />
                                        <asp:Button ID="cloginBtn" class="btn custom-login-btn custom-font" runat="server" CommandName="Login" 
                                            Text="LOG IN" ValidationGroup="clogin" OnClick="cloginBtn_Click"/>
                                        <br />
                                </div>
                            </div>
                      </div>
                      <div runat="server" class="tab-pane fade" id="aLogtab" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="modal-body" align="center">
                                <h4 class="custom-font font-bold mb-3">
                                    Artist Login
                                </h4>
                                <div class="form-group mb-0 pb-0">
                                        <asp:TextBox CssClass="form-control custom-field1" ID="alUserName" MaxLength="50" placeholder="Email" runat="server" ValidationGroup="alogin"></asp:TextBox>
                                        <asp:RequiredFieldValidator class="validation-msg" ID="alUserNameRequired" runat="server" ControlToValidate="alUserName"
                                            ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="alogin" Display="Dynamic">
                                            *Email is required
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator class="validation-msg" ID="alRegEx" runat="server" ErrorMessage="RegularExpressionValidator" 
                                            ValidationGroup="alogin" ControlToValidate="alUserName" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">
                                            *Invalid email address
                                        </asp:RegularExpressionValidator>
                                        <br />
                                        <asp:TextBox CssClass="form-control custom-field1" ID="alPassword" MaxLength="20" placeholder="Password" runat="server" TextMode="Password" ValidationGroup="alogin"></asp:TextBox>
                                        <asp:RequiredFieldValidator class="validation-msg mb-0 pb-0" ID="alPasswordRequired" runat="server" ControlToValidate="alPassword" 
                                            ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="alogin" Display="Dynamic">
                                            *Password is required
                                        </asp:RequiredFieldValidator>
                                        <asp:CustomValidator class="validation-msg mb-0 pb-0" ID="apassLen" runat="server" ErrorMessage="CustomValidator" 
                                            ClientValidationFunction="aPasswordLength" EnableClientScript="true" ValidationGroup="alogin" 
                                            ControlToValidate="alPassword" Display="Dynamic">
                                            *Password length must more than 8 characters
                                        </asp:CustomValidator>
                                        <br />
                                        <asp:CustomValidator class="validation-msg mb-0 pb-0 custom-font" ValidationGroup="alogin" ID="aloginFail" runat="server" Display="Dynamic" ErrorMessage="Wrong email or password" ForeColor="Red" OnServerValidate="loginFail_ServerValidate"></asp:CustomValidator>
                                        <br />
                                        <asp:Button ID="Button1" runat="server" CssClass="forgot-pass"  Text="-Forgot Password?-" OnClick="forgotPwd_Click"/> 
                                        <br />
                                        <br />
                                        <asp:Button ID="aloginBtn" class="btn custom-login-btn custom-font" runat="server" CommandName="Login" 
                                            Text="LOG IN" ValidationGroup="alogin" OnClick="aloginBtn_Click"/>
                                        <br />
                                </div>
                            </div>
                      </div>
                    </div>
                    
                    <div class="modal-footer justify-content-center" >
                        <div class="navi-signup">
                                Don't have an account? 
                            <asp:HyperLink class="sign-up-nav" NavigateUrl="~/signup.aspx" ID="HyperLink1" runat="server">Sign Up</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">
    function displayLogin() {
        $("#cLog").removeClass("active");
        $("#cLogtab").removeClass("show");
        $("#cLogtab").removeClass("active");
        $("#aLog").addClass("active");
        $("#aLogtab").addClass("show");
        $("#aLogtab").addClass("active");
    }

    const cPasswordLength = (source, args) => {
        var password = document.getElementById('<%= clPassword.ClientID %>')
        if (password.value.length < 8) {
            args.IsValid = false
        }
        else {
            args.IsValid = true
        }

    }

    const aPasswordLength = (source, args) => {
        var password = document.getElementById('<%= alPassword.ClientID %>')
        if (password.value.length < 8) {
            args.IsValid = false
        }
        else {
            args.IsValid = true
        }

    }
</script>
</html>
