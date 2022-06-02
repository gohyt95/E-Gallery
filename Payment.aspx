<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="ArtGallery1.Payment" %>
<%@ Register TagPrefix="ORDER" TagName="STATUS" Src="~/orderProgress.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container payment">
        <div class="row">
            <div class="col-12">
                <div class="checkout-header">
                    <div class="checkoutProcess position-relative">
                        <ORDER:STATUS ID="chekoutStatus" runat="server" CurrentPhase="2" />
                    </div>
                </div>
                <div class="card w-50 mx-auto">
                    <div class="card-body">
                        <h5 class="card-title">Total Payment Amount</h5>
                        <p class="card-text mb-4">
                            <asp:TextBox ID="txtPayAmount" runat="server" ReadOnly="true" Enabled="false" CssClass="w-100"></asp:TextBox>
                        </p>
                        <h5 class="card-title">Payment Method</h5>
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="onlinebanking-tab" data-toggle="tab" href="#onlinebanking" role="tab">Online Banking</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="creditcard-tab" data-toggle="tab" href="#creditcard" role="tab">Credit / Debit Card</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active py-3" id="onlinebanking" role="tabpanel">
                                <asp:RadioButtonList ID="rbBank" runat="server" ClientIDMode="Static" CssClass="rbBank">
                                    <asp:ListItem Value="Maybank2u" Selected="True"><img src="source/maybank2upng.png">Maybank2u</asp:ListItem>
                                    <asp:ListItem Value="CIMB Clicks"><img src="source/cimbclick.png">CIMB Clicks</asp:ListItem>
                                    <asp:ListItem Value="RHB Now"><img src="source/rhbnow.png">RHB Now</asp:ListItem>
                                    <asp:ListItem Value="Hong Leong Connect"><img src="source/hongleongconnect.png">Hong Leong Connect</asp:ListItem>
                                    <asp:ListItem Value="Ambank"><img src="source/ambank.png">Ambank</asp:ListItem>
                                    <asp:ListItem Value="MyBSN"><img src="source/mybsn.png">MyBSN</asp:ListItem>
                                    <asp:ListItem Value="Bank Rakyat"><img src="source/bankrakyat.png">Bank Rakyat</asp:ListItem>
                                    <asp:ListItem Value="UOB"><img src="source/uob.png">UOB</asp:ListItem>
                                    <asp:ListItem Value="Affin Bank"><img src="source/affinbank.png">Affin Bank</asp:ListItem>
                                    <asp:ListItem Value="Bank Islam"><img src="source/bankislam.png">Bank Islam</asp:ListItem>
                                    <asp:ListItem Value="HSBC Online"><img src="source/hsbconline.png">HSBC Online</asp:ListItem>
                                    <asp:ListItem Value="Standard Chartered Bank"><img src="source/standardcharteredbank.png">Standard Chartered Bank</asp:ListItem>
                                    <asp:ListItem Value="Kuwait Finance House"><img src="source/kuwait.png">Kuwait Finance House</asp:ListItem>
                                    <asp:ListItem Value="Bank Muamalat"><img src="source/bankmuamalat.png">Bank Muamalat</asp:ListItem>
                                    <asp:ListItem Value="OCBC Online"><img src="source/ocbconline.png">OCBC Online</asp:ListItem>
                                    <asp:ListItem Value="Alliance Bank (Personal)"><img src="source/alliancebank.png">Alliance Bank (Personal)</asp:ListItem>
                                </asp:RadioButtonList>
                                <div class="py-3">
                                    <asp:Label ID="lblBankAccNum" runat="server" Text="Bank Account Number"></asp:Label>
                                        <asp:TextBox ID="txtBankAccNum" runat="server" placeholder="Card Number" CssClass="w-100 mb-0" ClientIDMode="Static"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Bank Account Number is required." ControlToValidate="txtBankAccNum" 
                                            Display="Dynamic" ForeColor="Red"
                                            ValidationGroup="onlineBanking"></asp:RequiredFieldValidator>

                                    <asp:Label ID="lblPac" runat="server" Text="PAC" CssClass="d-block mt-3"></asp:Label>
                                    <div class="d-flex">
                                        <asp:TextBox ID="txtPac" runat="server" placeholder="xxxxxx" CssClass="w-100 mb-0" ClientIDMode="Static"></asp:TextBox>
                                        <button class="btn btnPrimary w-25" id="sendPac" onclick="return false">Send PAC</button>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="PAC is required." ControlToValidate="txtPac"
                                            Display="Dynamic" ForeColor="Red"
                                            ValidationGroup="onlineBanking"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="tab-pane fade" id="creditcard" role="tabpanel">
                                <div class="creditCardForm py-3">
                                    <p>We accept: <img src="source/visamaster.jpg" alt="visamastercard" style="width:100px;" /></p>
                                    <div class="mb-3">
                                        <asp:Label ID="lblCardNumber" runat="server" Text="Card Number"></asp:Label>
                                        <asp:TextBox ID="txtCardNumber" runat="server" placeholder="Card Number" CssClass="w-100 mb-0" ClientIDMode="Static"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator" runat="server" ErrorMessage="Card Number is required" ControlToValidate="txtCardNumber" Display="Dynamic" ForeColor="Red" ValidationGroup="creditCard"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator
                                            ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCardNumber"
                                            ErrorMessage="Invalid Card Number, must be 16 digits."
                                            ValidationExpression="[3-4]\d{3} \d{4} \d{4} \d{4}" ForeColor="Red"
                                            ValidationGroup="creditCard"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <!-- Expire Date -->
                                        <div class="w-100 mb-3">
                                            <asp:Label ID="lblExpDate" runat="server" Text="Exp Date"></asp:Label>
                                            <asp:TextBox ID="txtExpDate" runat="server" placeholder="mm/yy" CssClass="payment-expDate w-100 mb-0"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Expire Date is required" ControlToValidate="txtExpDate" Display="Dynamic" ForeColor="Red" ValidationGroup="creditCard"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtExpDate"
                                                ErrorMessage="Invalid Expire Date, eg: 01/01"
                                                ValidationExpression="((^1[02]|0[13578])\/(31))|((^1[0-2]|0[13-9])\/(30|[1-2]\d|0[1-9]))|(2\/(2[0-8]|1\d|0[1-9]))" ForeColor="Red"
                                                ValidationGroup="creditCard"></asp:RegularExpressionValidator>
                                        </div>
                                        <!-- CVV -->
                                        <div class="w-100 mb-3">
                                            <asp:Label ID="lblCvv" runat="server" Text="CVV"></asp:Label>
                                            <asp:TextBox ID="txtCVV" runat="server" placeholder="cvv" CssClass="payment-cvv w-100 mb-0"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="CVV is required" ControlToValidate="txtCVV" Display="Dynamic" ForeColor="Red" ValidationGroup="creditCard"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator
                                                ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtCVV"
                                                ErrorMessage="Invalid CVV, must be 3-4 digits"
                                                ValidationExpression="^[0-9]{3,4}$" ForeColor="Red"
                                                ValidationGroup="creditCard"></asp:RegularExpressionValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <asp:Button ID="btnPay" runat="server" Text="Pay" CssClass="btn btnPrimary w-100" OnClick="btnPay_Click" UseSubmitBehavior="false"/>
                        <asp:TextBox ID="txtPaymentType" runat="server" ClientIDMode="Static" Text="0" CssClass="hiddenTextField"></asp:TextBox>
                        <asp:TextBox ID="txtPhoneNumber" runat="server" ClientIDMode="Static" Text="0" CssClass="hiddenTextField"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>

    
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script>
        $(function () {
            if (document.querySelector("#txtPaymentType").value == 1) {
                $('#myTab li:last-child a').tab('show')
            }
        })

        document.querySelector("#onlinebanking-tab").addEventListener("click", () => {
            document.querySelector("#txtPaymentType").value = "0";
        });

        document.querySelector("#creditcard-tab").addEventListener("click", () => {
            document.querySelector("#txtPaymentType").value = "1";
        });

        document.querySelector("#txtCardNumber").addEventListener("keyup", (e) => {
            var cardNum = e.target.value.toString().replace(/\s+/g, '');
            console.log(cardNum.charAt(0) + "lj");
            var formatCardNum = "";
            console.log(cardNum.length)
            for (var i = 0; i < cardNum.length && i < 16; i++) {
                console.log((i + 1) / 4);
                if ((i + 1) % 4 == 0 && i != 15) {
                    console.log("yo");
                    formatCardNum += cardNum.charAt(i);
                    formatCardNum += " ";
                }
                else {
                    console.log("vat");
                    formatCardNum += cardNum.charAt(i);
                }
            }
            e.target.value = formatCardNum;
        });

        document.querySelector("#sendPac").addEventListener("click", () => {
            const bankAcc = document.querySelector("#txtBankAccNum").value;

            if (bankAcc != "") {
                const phoneNo = document.querySelector("#txtPhoneNumber").value;
                alert("PAC has sent to " + phoneNo);
            } else {
                alert("Plase enter you bank account number first.");
            }
            
        })
    </script>
</asp:Content>
