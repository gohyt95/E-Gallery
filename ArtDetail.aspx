<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArtDetail.aspx.cs" Inherits="ArtGallery1.ArtDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
        <div class="container artDetail">
            <div class="row">
                <div class="col artPicture border">
                    <img src="" alt="" runat="server" id="artDetailPicture" data-toggle="modal" data-target="#artDetailImageModal"/>
                </div>
                <div class="col artContent">
                    <div class="artDetail-heading mb-1">
                        <h2 class="artName mb-0 artDetailTitleKit" runat="server" id="artDetailArtName"></h2>
                        <button runat="server" id="btnAddToFavourite" class="rounded-circle artFavouriteBtn" onServerClick="artAddToFavourite" ClientIDMode="Static">
                            <i class="fa fa-heart" aria-hidden="true"></i>
                            <p>FAVOURITE</p>
                        </button>
                    </div>
                    <div class="artDetail-pricing mb-4">
                        <h1 class="artPrice mb-0 artDetailTitleKit" runat="server" id="artDetailPrice"></h1>
                    </div>
                    <div class="artDetail-quantity mb-3 d-flex align-items-center">
                        <p class="mb-0 artDetailTitleKit">Quantity: </p>
                        <div class="inputNumber ml-2">
                            <button class="minus" onclick="return false;">-</button>
                            <asp:TextBox ID="artDetailQuantity" runat="server" Text="1" data-stock=''></asp:TextBox>
                            <button class="plus" onclick="return false;">+</button>
                        </div>
                        <button runat="server" id="btnAddToCart" title="Search" class="btn btnPrimary btn-lg px-3 ml-auto" onServerClick="artAddToCart" ClientIDMode="Static">
                            <i class="fa fa-cart-plus" aria-hidden="true"></i> 
                            Add To Cart
                        </button>
                    </div>
                    <hr />
                    <div class="artDetail-properties">
                        <div class="artDetail-collapse-btn" data-toggle="collapse" data-target="#artDetailPropertiesCollapse">
                            <h5>Properties</h5>
                            <i class="fa fa-caret-up" aria-hidden="true"></i>
                        </div>
                        <div class="collapse show" id="artDetailPropertiesCollapse">
                            <div class="content py-2 mt-3">
                                <p class="artMaterial" runat="server" id="artDetailMaterial"></p>
                                <p class="artMedium" runat="server" id="artDetailMedium"></p>
                                <p class="artStyle" runat="server" id="artDetailStyle"></p>
                                <p class="artDimension mb-0" runat="server" id="artDetailDimension"></p>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="artDetail-description">
                        <div class="artDetail-collapse-btn" data-toggle="collapse" data-target="#artDetailDescriptionCollapse">
                            <h5>Description</h5>
                            <i class="fa fa-caret-up" aria-hidden="true"></i>
                        </div>
                        <div class="collapse show" id="artDetailDescriptionCollapse">
                            <div class="content py-2 mt-3">
                                <p class="artDescription mb-0" runat="server" id="artDetailDescription"></p>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="artDetail-artist">
                        <div class="artDetail-collapse-btn" data-toggle="collapse" data-target="#artDetailArtistCollapse">
                            <h5>By Artist</h5>
                            <i class="fa fa-caret-up" aria-hidden="true"></i>
                        </div>
                        <div class="collapse show" id="artDetailArtistCollapse">
                            <div class="content py-2 mt-3 row">
                                <div class="col-4">
                                    <img src="usersource/userNoProfilePicture.png" runat="server" id="artDetailArtistPic" alt="artistProfile" class="artistProfilePic" />
                                </div>
                                <div class="col-8">
                                    <h1 runat="server" class="artDetailTitleKit mb-3" id="artDetailArtistName"></h1>
                                    <div class="d-flex">
                                        <i class="fa fa-envelope mr-2" aria-hidden="true"></i>
                                        <p runat="server" class="mb-2" id="artDetailArtistEmail"></p>
                                    </div>
                                    <div class="d-flex">
                                        <i class="fa fa-flag mr-2" aria-hidden="true"></i>
                                        <p runat="server" id="artDetailArtistCountry"></p>
                                    </div>
                                    <a href="" class="btn btnPrimaryLink" runat="server" id="artDetailArtistView">View Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="mb-0"/>
                </div>
            </div>
        </div>
        <div class="modal fade artDetail-pictureModal" id="artDetailImageModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row h-100">
                            <div class="col-2 h-100 d-flex flex-column justify-content-center position-relative">
                                <img src="" alt="" runat="server" id="artDetailPicturePreview" onmousemove="zoomIn(event)" onmouseout="zoomOut()"/>
                                <button type="button" class="btn closeModal" data-dismiss="modal">
                                    <i class="fa fa-times" aria-hidden="true"></i>
                                </button>
                            </div>
                            <div class="col-10">
                                <div class="artDetailPictureZoom" id="artDetailPictureZoom">
                                    <div class="instruction">
                                        <div class="iconCombine">
                                            <i class="fa fa-search-plus" aria-hidden="true"></i>
                                            <i class="fa fa-picture-o" aria-hidden="true"></i>
                                        </div>
                                        <h1><i class="fa fa-arrow-left" aria-hidden="true"></i> Point Your Cursor To The Left Image</h1>
                                    </div>
                                </div>
                            </div>
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
        <div class="toast info-toast" role="alert">
            <div class="alert alert-info mb-0" role="alert">
                <p class="mb-0"><i class="fa fa-info-circle mr-3" aria-hidden="true"></i></p>
            </div>
        </div>

        <script src="Scripts/myscript2.js"></script>
        <script>
            const collapsibleBtns = document.querySelectorAll(".artDetail-collapse-btn");

            collapsibleBtns.forEach(btn => {
                btn.addEventListener("click", (e) => {
                    var caret;

                    if (e.target.tagName == "DIV")
                        caret = e.target.childNodes[3];
                    else if (e.target.tagName == "H5")
                        caret = e.target.parentNode.childNodes[3];
                    else if (e.target.tagName == "I")
                        caret = e.target;

                    if (caret.style.transform != 'rotate(0deg)')
                        caret.style.transform = 'rotate(0deg)';
                    else
                        caret.style.transform = 'rotate(180deg)';
                })
            });
            
            var img = document.querySelector(".artPicture img");

            const zoomIn = (event) => {
                var pre = document.querySelector(".artDetail-pictureModal img");
                var zoom = document.querySelector("#artDetailPictureZoom");

                var realWidth = pre.naturalWidth;
                var realHeight = pre.naturalHeight;
                var preWidth = pre.clientWidth;
                var preHeight = pre.clientHeight;

                var adjustX = zoom.clientWidth / 2;
                var adjustY = zoom.clientHeight / 2;

                const widthMult = realWidth / preWidth;
                const heightMult = realHeight / preHeight;

                zoom.style.backgroundImage = "url('"+ img.src +"')";

                var posX = event.offsetX;
                var posY = event.offsetY;

                zoom.style.backgroundPosition = (-posX * widthMult + adjustX) + "px " + (-posY * heightMult + adjustY) + "px";
                document.querySelector(".instruction").style.visibility = "hidden";
            }

            const zoomOut = () => {
                const zoom = document.querySelector("#artDetailPictureZoom");
                zoom.style.backgroundImage = "url('')";

                document.querySelector(".instruction").style.visibility = "visible";
            }

            // Cart Quantity Input Validation
            const cartInputsNumber = document.querySelectorAll(".inputNumber");
            cartInputsNumber.forEach(inputBox => {
                inputBox.childNodes[1].addEventListener("click", (e) => {
                    const numberInput = e.target.parentNode.childNodes[3];
                    if (parseInt(numberInput.value) < 1) {
                        numberInput.value = 1;
                    }
                });

                inputBox.childNodes[5].addEventListener("click", (e) => {
                    const numberInput = e.target.parentNode.childNodes[3];
                    const stock = parseInt(numberInput.dataset.stock);

                    if (parseInt(numberInput.value) >= stock) {
                        numberInput.value = stock;
                    }
                });

                inputBox.childNodes[3].addEventListener("change", (e) => {
                    const numberInput = e.target.parentNode.childNodes[3];
                    const stock = parseInt(numberInput.dataset.stock);

                    if (parseInt(numberInput.value) >= stock) {
                        numberInput.value = stock;
                    } else if (parseInt(numberInput.value) < 1) {
                        numberInput.value = 1;
                    }
                });
            });

            const toast = (msg, status) => {

                var targetToast = "";

                if (status == "info") {
                    targetToast = ".info-toast";
                } else if (status == "success") {
                    targetToast = ".success-toast";
                }

                $(targetToast).toast({ delay: 5000 });
                $(targetToast).toast('show');

                console.log(document.querySelector(targetToast).childNodes[0]);
                document.querySelector(targetToast).childNodes[1].childNodes[1].innerHTML += msg;
            }

            const updateCartBtn = () => {
                document.querySelector("#btnAddToCart").innerHTML = "<i class='fa fa-shopping-cart'></i> Update Cart";
            }

            const updateWishBtn = (exist) => {
                const btn = document.querySelector("#btnAddToFavourite");

                if (exist) {
                    btn.style.backgroundColor = "#c8af6a";
                    btn.childNodes[1].style.color = "#ffffff";
                    btn.childNodes[3].innerHTML = "UNFAVOURITE";
                    btn.childNodes[3].style.left = "-24px";
                } else {
                    btn.style.backgroundColor = "#c8af6a";
                    btn.childNodes[1].style.color = "#ffffff";
                    btn.childNodes[3].innerHTML = "FAVOURITE";
                    btn.childNodes[3].style.left = "-12px";
                }
                
            }
        </script>

</asp:Content>
