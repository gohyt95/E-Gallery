<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ArtGallery1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<br />
<br />
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
  </ol>
  <div class="carousel-inner ">
    <div class="carousel-item active" data-interval="30000">
      <a href="Art.aspx?style=street" class="carousel-btn">
      <div class="card mb-3 card-setting">
          <div class="row no-gutters">
            <div class="col-md-7">
              <img src="source/1.jpeg" class="carousel-image" alt="...">
            </div>
            <div class="col-md-5">
              <div class="card-body d-flex h-100 text-center">
                  <div class="align-self-center w-100">
                      <p class="" >Browse by Style</p>
                      <p class="lead" style="font-size:2em;">Street Artworks</p>
                      <p class="" >Shop Now</p>
                  </div>
              </div>
            </div>
          </div>
      </div>
      </a>
    </div>
    <div class="carousel-item" data-interval="30000">
        <a href="Art.aspx?style=minimalist" class="carousel-btn">
        <div class="card mb-3 card-setting">
          <div class="row no-gutters">
            <div class="col-md-7">
              <img src="source/2.jpg" class="carousel-image" alt="...">
            </div>
            <div class="col-md-5">
              <div class="card-body d-flex h-100 text-center">
                  <div class="align-self-center w-100">
                      <p class="" >Browse by Style</p>
                      <p class="lead" style="font-size:2em;">Minimalist Artworks</p>
                      <p class="" >Shop Now</p>
                  </div>
              </div>
            </div>
          </div>
        </div>
        </a>
    </div>
  </div>
</div>
<br />
<hr />
<div class="text-center"> <!--Browse by Artwork Style-->
    <h3>Browse by Artwork Style</h3>
</div>
<br />
<div>
    <div class="row"> <!-- upper part -->

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspx?style=abstract" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/abstract-landing.jpg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">Abstract</p>
              </div>
            </div>
        </a>
      </div>

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspx?style=minimalist" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/price3.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">Minimalist</p>
              </div>
            </div>
        </a>
      </div>

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspx?style=nature" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/price4.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">Nature</p>
              </div>
            </div>
        </a>
      </div>

    </div>

    <div class="row "> <!-- lower part-->

      <div class="cols-1 col-md-8 mb-4">
        <a href="Art.aspx?style=pop" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/Pop.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                   <p class="card-text landing-title">Pop</p>
              </div>
            </div>
        </a>
      </div>

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspx?style=street" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/streetart-landing.jpg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">Street Art.</p>
              </div>
            </div>
        </a>
      </div>

    </div>
</div>
<hr />
<div class="text-center"> <!--Browse by Artwork Price -->
    <h3>Browse by Artwork Price</h3>
</div>
<br />
<div>
   <div class="row "> <!-- Upper part-->

      <div class="cols-1 col-md-8 mb-4">
        <a href="Art.aspx?priceMax=500" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/abtract.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">Under RM500</p>
              </div>
            </div>
        </a>
      </div>

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspx?priceMin=500&priceMax=1000" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/india.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">RM500 - RM1000</p>
              </div>
            </div>
        </a>
      </div>

    </div>
    <div class="row"> <!-- Lower part -->

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspx?priceMin=1000&priceMax=2000" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/italy.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">RM1000 - RM2000</p>
              </div>
            </div>
        </a>
      </div>

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspxpriceMin=2000&priceMax=5000" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/poland.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">RM 2000 - RM5000</p>
              </div>
            </div>
        </a>
      </div>

      <div class="cols-1 col-md-4 mb-4">
        <a href="Art.aspx?priceMin=5000" class="landing-browse-link">
            <div class="card landing-setting">
              <img src="source/price2.jpeg" class="card-img-top landing-image " alt="...">
              <div class="card-body text-center landing-title">
                    <p class="card-text landing-title">Above RM5000</p>
              </div>
            </div>
        </a>
      </div>

    </div>

</div>
<hr />
<div class="text-center"> <!--Trending -->
    <h3>Trending</h3>
</div>
<br />
<div class="card-deck">
  <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
      <ItemTemplate>
         <div class="card landing-setting">
            <a href="ArtDetail.aspx?art=<%#Eval("artId") %>" class="landing-browse-link">
                <img src="source/<%#Eval("picture") %>" class="card-img-top" alt="<%#Eval("picture") %>">
                <div class="card-body text-center ">
                    <p class="landing-title"><%#Eval("artistName") %></p>
                    <p class="landing-title"><small class="text-muted"><%#Eval("medium") %></small></p>
                </div>
            </a>
        </div>
      </ItemTemplate>
  </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString2 %>" 
        SelectCommand="SELECT TOP (5) Art.artId, Art.artistId, Art.artName, Art.price, Art.stock, Art.description, Art.material, Art.medium, Art.style, Art.picture, Art.width, Art.height, Art.date, Artist.artistName, Artist.artistEmail, Artist.artistPhone FROM Art INNER JOIN Artist ON Art.artistId = Artist.artistId">
    </asp:SqlDataSource>
</div>
<hr />
<div class="card mb-3 landing-bottom-setting">
  <a href="login.aspx" class="carousel-btn">
  <div class="row no-gutters">
    <div class="col-md-4">
      <div class="card-body h-100">
        <div class="card-body d-flex h-100">
            <div class="align-self-center w-100">
                <p class="" >ARE YOU SOMEONE <br /> LOOKING TO SELL OR BUY AN ART?</p>
                <p class="lead" style="font-size:2em;">Log In to A4 Gallery</p>
            </div>
        </div>
      </div>
    </div>
    <div class="col-md-8 ">
      <img src="source/16th.jpeg" class="landing-image " alt="...">
    </div>
  </div>
  </a>
</div>
</asp:Content>
