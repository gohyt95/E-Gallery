<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Art.aspx.cs" Inherits="ArtGallery1.Art" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <script src="//code.jquery.com/jquery-1.12.4.js"></script>
        <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <br />
        <div class="container art">
            <h1 class="art-heading">Original Contemporary Art for Sale</h1>
            <div class="row my-3">
                <!-- Filter Section -->
                <div class="d-none d-md-block col-md-4 col-lg-3 art-filter">
                    <div class="filter-collapsible filter-price">
                        <div class="art-collapse-btn" data-toggle="collapse" data-target="#artFilterPrice">
                            <p class="filter-text">
                                Price (MYR)
                            </p>
                            <i class="fa fa-caret-up" id="priceFilterCaret"></i>
                        </div>
                        
                        <div class="collapse show" id="artFilterPrice">
                            <div class="content py-2">
                                <p id="priceAmount" class="text-right"></p>
                                <div id="priceSlider" class="mx-2"></div>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <div class="filter-collapsible filter-artist">
                        <div class="art-collapse-btn" data-toggle="collapse" data-target="#artFilterArtist">
                            <p class="filter-text">
                                Artist From
                            </p>
                            <i class="fa fa-caret-up" aria-hidden="true"></i>
                        </div>
                        <div class="collapse show" id="artFilterArtist">
                            <div class="content py-2">
                                <asp:DropDownList ID="ddlFilterArtist" runat="server" AutoPostBack="True" CssClass="d-block w-100 border-0 p-2" BackColor="#efefef" Font-Names="EB Garamond" OnSelectedIndexChanged="artFilter">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Malaysia</asp:ListItem>
                                    <asp:ListItem>Singapore</asp:ListItem>
                                    <asp:ListItem>Thailand</asp:ListItem>
                                    <asp:ListItem>India</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <div class="filter-collapsible filter-medium">
                        <div class="art-collapse-btn" data-toggle="collapse" data-target="#artFilterMedium">
                            <p class="filter-text">
                                Medium
                            </p>
                            <i class="fa fa-caret-up" aria-hidden="true"></i>
                        </div>
                        <div class="collapse show" id="artFilterMedium">
                            <div class="content py-2">
                                <asp:DropDownList ID="ddlFilterMedium" runat="server" AutoPostBack="True" CssClass="d-block w-100 border-0 p-2" BackColor="#efefef" Font-Names="EB Garamond" OnSelectedIndexChanged="artFilter">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Painting</asp:ListItem>
                                    <asp:ListItem>Photography</asp:ListItem>
                                    <asp:ListItem>Sculpture</asp:ListItem>
                                    <asp:ListItem>Drawing</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <div class="filter-collapsible filter-artist">
                        <div class="art-collapse-btn" data-toggle="collapse" data-target="#artFilterStyle">
                            <p class="filter-text">
                                Artwork Style
                            </p>
                            <i class="fa fa-caret-up" aria-hidden="true"></i>
                        </div>
                        <div class="collapse show" id="artFilterStyle">
                            <div class="content py-2">
                                <asp:DropDownList ID="ddlFilterStyle" runat="server" AutoPostBack="True" CssClass="d-block w-100 border-0 p-2" BackColor="#efefef" Font-Names="EB Garamond" OnSelectedIndexChanged="artFilter">
                                    <asp:ListItem>All</asp:ListItem>
                                    <asp:ListItem>Abstract</asp:ListItem>
                                    <asp:ListItem>Figurative</asp:ListItem>
                                    <asp:ListItem>Geometric</asp:ListItem>
                                    <asp:ListItem>Minimalist</asp:ListItem>
                                    <asp:ListItem>Nature</asp:ListItem>
                                    <asp:ListItem>Pop</asp:ListItem>
                                    <asp:ListItem>Street Art</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <hr />

                    <div class="filter-collapsible filter-size">
                        <div class="art-collapse-btn" data-toggle="collapse" data-target="#artFilterSize">
                            <p class="filter-text">
                                Size
                            </p>
                            <i class="fa fa-caret-up" aria-hidden="true"></i>
                        </div>
                        <div class="collapse show" id="artFilterSize">
                            <div class="content py-2">
                                <div class="titleValue d-flex justify-content-between">
                                    <p class="title">Width:</p>
                                    <p id="widthAmount" class="text-right"></p>
                                </div>
                                <div id="widthSlider" class="mx-2 mb-3"></div>

                                <div class="titleValue d-flex justify-content-between">
                                    <p class="title">Height:</p>
                                    <p id="heightAmount" class="text-right"></p>
                                </div>
                                <div id="heightSlider" class="mx-2"></div>
                            </div>
                        </div>
                    </div>
                    <hr />
                </div>

                <!-- Items Section -->
                <div class="col-12 col-md-8 col-lg-9">
                    <div class="art-sort d-flex justify-content-end mb-3">
                        <asp:DropDownList ID="ddlSortArt" runat="server" CssClass="d-block w-100 border-0 p-2" BackColor="#efefef" AutoPostBack="True" >
                            <asp:ListItem Value="0">Sort By</asp:ListItem>
                            <asp:ListItem Value="1">Newest</asp:ListItem>
                            <asp:ListItem Value="2">Price Low to High</asp:ListItem>
                            <asp:ListItem Value="3">Price High to Low</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="art-content row justify-content-start">
                        <asp:Repeater ID="repArt" runat="server" DataSourceID="ArtDataSource">
                            <ItemTemplate>
                                <div class="col-4">
                                <div class="card">
                                    <a href="ArtDetail.aspx?art=<%#Eval("artId") %>">
                                        <img class="card-img-top w-100" src="/source/<%#Eval("picture") %>" alt="Card image cap">
                                    </a><div class="card-body">
                                        <a href="ArtDetail.aspx?art=<%#Eval("artId") %>" class="art-name"><%#Eval("artName") %></a>
                                        <a href="ArtistProfile.aspx?id=<%#Eval("artistId") %>" class="art-artist"><%#Eval("artistName") %>, <%#Eval("country") %></a>
                                        <p class="art-medium"><%#Eval("medium") %></p>
                                        <p class="art-price">RM <%# String.Format("{0:n2}", Convert.ToDouble(Eval("price")))%></p>
                                    </div>
                                </div>
                                    </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <nav class="art-pagination mt-5">
                        <ul class="pagination pagination-lg justify-content-end">
                            
                        </ul>
                    </nav>
                    <div class="d-flex art-NoResult flex-column align-items-center">
                        <div class="cart-empty-pic d-flex justify-content-center align-items-center p-3 mt-5">
                            <img src="source/noResult.png" alt="cart empty" />
                        </div>
                        <h1 class="my-4">Opps, No Result Found :(</h1>
                    </div>
                </div>

                <div class="hidden">
                    <asp:TextBox ID="artFilterWidthMinValue" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="0" CssClass="hiddenTextField" OnTextChanged="artFilter"></asp:TextBox>
                    <asp:TextBox ID="artFilterWidthMaxValue" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="550" CssClass="hiddenTextField" OnTextChanged="artFilter"></asp:TextBox>
                    <asp:TextBox ID="artFilterPriceMinValue" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="0" CssClass="hiddenTextField" OnTextChanged="artFilter"></asp:TextBox>
                    <asp:TextBox ID="artFilterPriceMaxValue" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="10500" CssClass="hiddenTextField" OnTextChanged="artFilter"></asp:TextBox>
                    <asp:TextBox ID="artFilterHeightMinValue" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="0" CssClass="hiddenTextField" OnTextChanged="artFilter"></asp:TextBox>
                    <asp:TextBox ID="artFilterHeightMaxValue" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="550" CssClass="hiddenTextField" OnTextChanged="artFilter"></asp:TextBox>
                    <asp:TextBox ID="artPage" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="1" CssClass="hiddenTextField"></asp:TextBox>
                    <asp:TextBox ID="artRecords" runat="server" AutoPostBack="True" ClientIDMode="Static" Text="1" CssClass="hiddenTextField"></asp:TextBox>
                    <asp:SqlDataSource ID="ArtDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT  a.artId, a.artistId, a.artName, a.price, a.medium, a.picture, u.artistName, u.country
FROM Art a
JOIN Artist u
ON a.artistId = u.artistId
WHERE u.country LIKE
CASE WHEN (@country = 'All') THEN '%'  ELSE @country END
AND
a.medium LIKE
CASE WHEN (@medium = 'All') THEN '%'  ELSE @medium END
AND
a.style LIKE
CASE WHEN (@style = 'All') THEN '%'  ELSE @style END
AND
a.width BETWEEN CAST(@widthMin AS INT) AND
CASE WHEN (CAST(@widthMax AS INT) = 505) THEN 100000  ELSE CAST(@widthMax AS INT) END
AND
a.height BETWEEN CAST(@heightMin AS INT) AND
CASE WHEN (CAST(@heightMax AS INT) = 505) THEN 100000  ELSE CAST(@heightMax AS INT) END
AND
a.price BETWEEN CAST(@priceMin AS INT) AND
CASE WHEN (CAST(@priceMax AS INT) = 10500) THEN 1000000  ELSE CAST(@priceMax AS INT) END
AND a.stock &gt; 0
AND a.isDelete = 0
ORDER BY
(CASE WHEN @order = 0 THEN a.artId END),
(CASE WHEN @order = 1 THEN a.date END) DESC,
(CASE WHEN @order = 2 THEN a.price END),
(CASE WHEN @order = 3 THEN a.price END) DESC
OFFSET (CAST(@PageNumber-1 AS INT))*CAST(@RowsOfPage AS INT) ROWS
FETCH NEXT CAST(@RowsOfPage AS INT) ROWS ONLY">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlFilterArtist" Name="country" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddlFilterMedium" Name="medium" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddlFilterStyle" Name="style" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="artFilterWidthMinValue" Name="widthMin" PropertyName="Text" />
                            <asp:ControlParameter ControlID="artFilterWidthMaxValue" Name="widthMax" PropertyName="Text" />
                            <asp:ControlParameter ControlID="artFilterHeightMinValue" Name="heightMin" PropertyName="Text" />
                            <asp:ControlParameter ControlID="artFilterHeightMaxValue" Name="heightMax" PropertyName="Text" />
                            <asp:ControlParameter ControlID="artFilterPriceMinValue" Name="priceMin" PropertyName="Text" />
                            <asp:ControlParameter ControlID="artFilterPriceMaxValue" Name="priceMax" PropertyName="Text" />
                            <asp:ControlParameter ControlID="ddlSortArt" Name="order" PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="artPage" DefaultValue="1" Name="PageNumber" PropertyName="Text" />
                            <asp:Parameter DefaultValue="15" Name="RowsOfPage" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
                
            </div>
        </div>
        

        <script>

            const createPagination = () => {
                const totalRecord = document.querySelector("#artRecords").value;
                const recordPerPage = 15;
                const totalPage = Math.ceil(parseInt(totalRecord) / recordPerPage);
                const currentPage = document.querySelector("#artPage").value;
                const paginationContainer = document.querySelector(".pagination");
                var paginationButtons = "";

                for (var i = 1; i <= totalPage && i < 10; i++) {
                    if (parseInt(currentPage) == i)
                        paginationButtons += '<li class="page-item active"><button class="page-link artPagBtn">' + i + '</button></li>';
                    else
                        paginationButtons += '<li class="page-item"><button class="page-link artPagBtn">'+ i +'</button></li>';
                }

                if (totalPage >= 10) {
                    paginationButtons += '<li class="page-item"><p class="page-link">...</p></li>';
                }

                if(parseInt(currentPage) <= 1)
                    paginationButtons += '<li class="page-item disabled"><button class="page-link artPagBtnPrev" disabled><span>&laquo;</span></button></li>';
                else
                    paginationButtons += '<li class="page-item"><button class="page-link artPagBtnPrev"><span>&laquo;</span></button></li>';

                if (parseInt(currentPage) >= totalPage)
                    paginationButtons += '<li class="page-item disabled"><button class="page-link artPagBtnNext" disabled><span>&raquo;</span></button></li>';
                else
                    paginationButtons += '<li class="page-item"><button class="page-link artPagBtnNext"><span>&raquo;</span></button></li>';

                paginationContainer.innerHTML = paginationButtons;
            }

            const addPaginationListener = () => {
                const paginationBtns = document.querySelectorAll(".artPagBtn");
                paginationBtns.forEach(btn => {
                    btn.addEventListener("click", (e) => {
                        document.querySelector("#artPage").value = e.target.innerHTML;
                        __doPostBack('artChangePage', "");
                    })
                });

                const paginationPrev = document.querySelector(".artPagBtnPrev");
                const paginationNext = document.querySelector(".artPagBtnNext");

                paginationPrev.addEventListener("click", () => {
                    const currentPage = parseInt(document.querySelector("#artPage").value);

                    if (currentPage > 1) {
                        document.querySelector("#artPage").value = currentPage - 1;
                        __doPostBack('artChangePage', "");
                    } else {
                        document.querySelector("#artPage").value = 1;
                    }
                });

                paginationNext.addEventListener("click", () => {
                    const totalRecord = parseInt(document.querySelector("#artRecords").value);
                    const recordPerPage = 15;
                    const totalPage = Math.ceil(parseInt(totalRecord) / recordPerPage);
                    const currentPage = parseInt(document.querySelector("#artPage").value);

                    if (currentPage < totalPage) {
                        document.querySelector("#artPage").value = currentPage + 1;
                        __doPostBack('artChangePage', "");
                    } else {
                        document.querySelector("#artPage").value = currentPage;
                    }
                });
            }

            createPagination();
            addPaginationListener();

            $(function () {
                $("#priceSlider").slider({
                    range: true,
                    min: 0,
                    max: 10500,
                    step: 500,
                    values: [$("#artFilterPriceMinValue").val(), $("#artFilterPriceMaxValue").val()],
                    create: function (event, ui) {
                        const min = parseInt($("#artFilterPriceMinValue").val());
                        const max = parseInt($("#artFilterPriceMaxValue").val());

                        if (max > 10000 && min > 10000) {
                            $("#priceAmount").html("RM 10000+ - RM 10000+");
                        } else if (max > 10000) {
                            $("#priceAmount").html("RM " + min +
                                " - RM 10000+");
                        } else {
                            $("#priceAmount").html("RM " + min +
                                " - RM " + max);
                        }
                    },
                    slide: function (event, ui) {
                        if (ui.values[0] > 10000 && ui.values[1] > 10000) {
                            $("#priceAmount").html("RM 10000+ - RM 10000+");
                        } else if (ui.values[1] > 10000) {
                            $("#priceAmount").html("RM " + ui.values[0] +
                                " - RM 10000+");
                        } else {
                            $("#priceAmount").html("RM " + ui.values[0] +
                                " - RM " + ui.values[1]);
                        }
                    },
                    stop: function (event, ui) {
                        $("#artFilterPriceMinValue").val(ui.values[0]);
                        $("#artFilterPriceMaxValue").val(ui.values[1]);
                        __doPostBack('artFilterWidthValue', "");
                    }
                });

                $("#widthSlider").slider({
                    range: true,
                    min: 0,
                    max: 550,
                    step: 50,
                    values: [$("#artFilterWidthMinValue").val(), $("#artFilterWidthMaxValue").val()],
                    create: function (event, ui) {
                        const min = parseInt($("#artFilterWidthMinValue").val());
                        const max = parseInt($("#artFilterWidthMaxValue").val());

                        if (max > 500 && min > 500) {
                            $("#widthAmount").html("500+ - 500+ cm");
                        } else if (max > 500) {
                            $("#widthAmount").html(min +
                                " - 500+ cm");
                        } else {
                            $("#widthAmount").html(min +
                                " - " + max + " cm");
                        }
                    },
                    slide: function (event, ui) {
                        if (ui.values[0] > 500 && ui.values[1] > 500) {
                            $("#widthAmount").html("500+ - 500+ cm");
                        } else if (ui.values[1] > 500) {
                            $("#widthAmount").html(ui.values[0] +
                                " - 500+ cm");
                        } else {
                            $("#widthAmount").html(ui.values[0] +
                                " - " + ui.values[1] + " cm");
                        }
                    },
                    stop: function (event, ui) {
                        $("#artFilterWidthMinValue").val(ui.values[0]);
                        $("#artFilterWidthMaxValue").val(ui.values[1]);
                        __doPostBack('artFilterWidthValue', "");
                    }
                });

                $("#heightSlider").slider({
                    range: true,
                    min: 0,
                    max: 550,
                    step: 50,
                    values: [$("#artFilterHeightMinValue").val(), $("#artFilterHeightMaxValue").val()],
                    create: function (event, ui) {
                        const min = parseInt($("#artFilterHeightMinValue").val());
                        const max = parseInt($("#artFilterHeightMaxValue").val());

                        if (max > 500 && min > 500) {
                            $("#heightAmount").html("500+ - 500+ cm");
                        } else if (max > 500) {
                            $("#heightAmount").html(min +
                                " - 500+ cm");
                        } else {
                            $("#heightAmount").html(min +
                                " - " + max + " cm");
                        }
                    },
                    slide: function (event, ui) {
                        if (ui.values[0] > 500 && ui.values[1] > 500) {
                            $("#heightAmount").html("500+ - 500+ cm");
                        } else if (ui.values[1] > 500) {
                            $("#heightAmount").html(ui.values[0] +
                                " - 500+ cm");
                        } else {
                            $("#heightAmount").html(ui.values[0] +
                                " - " + ui.values[1] + " cm");
                        }
                    },
                    stop: function (event, ui) {
                        $("#artFilterHeightMinValue").val(ui.values[0]);
                        $("#artFilterHeightMaxValue").val(ui.values[1]);
                        __doPostBack('artFilterheightValue', "");
                    }
                });
                
            });

            const collapsibleBtns = document.querySelectorAll(".art-collapse-btn");

            collapsibleBtns.forEach(btn => {
                btn.addEventListener("click", (e) => {
                    var caret;

                    if (e.target.tagName == "DIV")
                        caret = e.target.childNodes[3];
                    else if (e.target.tagName == "P")
                        caret = e.target.parentNode.childNodes[3];
                    else if (e.target.tagName == "I")
                        caret = e.target;

                    if (caret.style.transform != 'rotate(0deg)')
                        caret.style.transform = 'rotate(0deg)';
                    else
                        caret.style.transform = 'rotate(180deg)';
                })
            });

            const noResult = () => {
                document.querySelector(".art-content").classList.add("d-none");
                document.querySelector(".art-NoResult").style.visibility = "visible";
            }
        </script>

</asp:Content>
