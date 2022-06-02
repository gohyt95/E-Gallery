<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Gallery.aspx.cs" Inherits="ArtGallery1.Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">






    <div class="container">

        <div class="row">
            <div class="col">
                <div class="row">
                    <div class="col">
                        <h1>Your Gallery</h1>
                    </div>
                    <div class="col">
                        <asp:Button runat="server" Text="Post Art" class="btn btn-primary" Style="position: absolute; right: 15px; width: 80px; background: rgba(200,175,106,1); border-color: rgba(200,175,106,1);" OnClick="Add_Click" />

                    </div>
                </div>
                <br />
                <br />
                <div class="art-content row justify-content-start">

                    <asp:Repeater ID="repArt" runat="server" DataSourceID="ArtDataSource" OnItemCommand="repArt_ItemCommand">
                        <ItemTemplate>
                            <div class="col-3">
                            <div class="card">
                                <a href="EditArt.aspx?art=<%#Eval("artId") %>">
                                    <img class="card-img-top w-100"  src="/source/<%#Eval("picture") %>" alt="Card image cap">
                                </a>

                                <div class="card-body">
                                    <a href="EditArt.aspx?art=<%#Eval("artId") %>" class="art-name"><%#Eval("artName") %></a>
                                    <br />
                                    <a href="EditArt.aspx?art=<%#Eval("artId") %>" class="btn btn-primary mb-0" style="display: inline-block; width: 80px; color: white; background: rgba(200,175,106,1); border-color: rgba(200,175,106,1);">Edit</a>

                                    <button type="button" data-id='<%#Eval("artId") %>' class="btn btn-danger btnGalleryDelete" style="width: 80px;" data-toggle="modal" data-target="#deleteAlertGallery">
                                        Unload
                                    </button>
                                </div>
                            </div>
                                </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <asp:SqlDataSource ID="ArtDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                    SelectCommand="SELECT  a.artId, a.artistId, a.artName, a.price, 
                    a.medium, a.picture, u.artistName, u.country
                    FROM Art a
                    JOIN Artist u
                    ON a.artistId = u.artistId    WHERE a.artistId = @artistId AND a.isDelete = 0">
                    <SelectParameters>
                        <asp:SessionParameter Name="artistId" SessionField="artistId" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
            </div>
        </div>
    </div>

    <!-- Button trigger modal -->


    <!-- Modal -->
    <div class="modal fade" id="deleteAlertGallery" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Unload Art Confirmation</h5>
                       
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                </div>
                <div class="modal-body">
                    After unload cannot undo one arr
                   
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" ID="deleteButtonGallery" Text="Unload" class="btn btn-danger" OnClick="DeleteArt" />
                </div>
            </div>
        </div>
    </div>

    <script>
        const btnsGalleryDelete = document.querySelectorAll(".btnGalleryDelete");

        btnsGalleryDelete.forEach(btn => {
            btn.addEventListener("click", (e) => {
                const confirmDel = document.getElementById('delDataIdGallery');
                confirmDel.value = e.target.getAttribute("data-id");
            })
        })
    </script>  

    <asp:TextBox ID="delDataIdGallery" Style="visibility: hidden;" runat="server" ClientIDMode="Static"></asp:TextBox>

</asp:Content>
