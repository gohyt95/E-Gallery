<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="ArtGallery1.ForgotPassword" %>

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
                        <asp:LinkButton ID="forgotCancel" class="close" runat="server"  PostBackUrl="~/login.aspx">
                            <span class="goldone" aria-hidden="true">&times;</span>
                        </asp:LinkButton>
                    </div>
                <div class="tab-content" id="myTabContent">
                      <div runat="server" class="tab-pane fade show active" id="cSigntab" role="tabpanel" aria-labelledby="home-tab">
                            <div class="modal-body" align="center">
                                    <h4 class="custom-font font-bold mb-3">
                                        Customer Forgot Password
                                    </h4>
                                    <asp:Label class="custom-font text-success" ID="cResetResponse" runat="server" Text=""></asp:Label>
                                    <div class="form-group mb-0 pb-0" align="center" >
                                            <asp:TextBox CssClass="form-control custom-field1" ID="cResetEmail" placeholder="Email" runat="server" ValidationGroup="cReset"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="cResetEmailRequired" runat="server" ControlToValidate="cResetEmail"
                                                ErrorMessage="Email is required." ToolTip="Email is required." MaxLength="50" ValidationGroup="cReset" Display="Dynamic">
                                                *Email is required
                                            </asp:RequiredFieldValidator>
                                            <asp:CustomValidator class="validation-msg mb-0 pb-0 custom-font" ValidationGroup="cReset" ID="cResetFail" runat="server" Display="Dynamic"
                                                ErrorMessage="*Email not existed" ForeColor="Red" ControlToValidate="cResetEmail" OnServerValidate="cFindUser"></asp:CustomValidator>
                                            <asp:RegularExpressionValidator class="validation-msg mb-0 pb-0" ID="cRegEx" runat="server" ErrorMessage="RegularExpressionValidator" 
                                                ValidationGroup="cReset" ControlToValidate="cResetEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">
                                                *Invalid email address
                                            </asp:RegularExpressionValidator>
                                            <br />
                                            <br />
                                            <asp:Button ID="cResetBtn" class="btn custom-login-btn custom-font" runat="server" CommandName="Login"
                                                Text="Reset Password" ValidationGroup="cReset" OnClick="cReset_Password"/>
                                            <br />
                                    </div>
                            </div>
                      </div>
                      <div runat="server" class="tab-pane fade" id="aSigntab" role="tabpanel" aria-labelledby="home-tab">
                            <div class="modal-body" align="center">
                                    <h4 class="custom-font font-bold mb-3">
                                        Artist Forgot Password
                                    </h4>
                                    <asp:Label class="custom-font text-success" ID="aResetResponse" runat="server" Text=""></asp:Label>
                                    <div class="form-group mb-0 pb-0" align="center" >
                                            <asp:TextBox CssClass="form-control custom-field1" ID="aResetEmail" MaxLength="50" placeholder="Email" runat="server" ValidationGroup="aReset"></asp:TextBox>
                                            <asp:RequiredFieldValidator class="validation-msg" ID="aResetEmailRequired" runat="server" ControlToValidate="aResetEmail"
                                                ErrorMessage="Email is required." ToolTip="Email is required." ValidationGroup="aReset" Display="Dynamic">
                                                *Email is required
                                            </asp:RequiredFieldValidator>                                            
                                            <asp:CustomValidator class="validation-msg mb-0 pb-0 custom-font" ValidationGroup="aReset" ID="aResetFail" runat="server" Display="Dynamic" 
                                                ErrorMessage="*Email not existed" ForeColor="Red" ControlToValidate="aResetEmail"  OnServerValidate="aFindUser"></asp:CustomValidator>
                                            <asp:RegularExpressionValidator class="validation-msg" ID="aRegEx" runat="server" ErrorMessage="RegularExpressionValidator" 
                                                ValidationGroup="aReset" ControlToValidate="aResetEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic">
                                                *Invalid email address
                                            </asp:RegularExpressionValidator>
                                            <br />
                                            <br />
                                            <asp:Button ID="aResetBtn" class="btn custom-login-btn custom-font" runat="server" CommandName="Login" 
                                                Text="Reset Password" ValidationGroup="aReset" OnClick="aReset_Password" />
                                            <br />
                                    </div>
                            </div>
                      </div>
                </div>
                <div class="modal-footer justify-content-center" >
                    <div class="navi-signup">
                            
                        </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

