<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditArt.aspx.cs" Inherits="ArtGallery1.EditArt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container">
            <div class="row">

                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb" style="background-color: white">
                        <li class="breadcrumb-item"><a href="Gallery" style="color: rgb(200,175,106)"">Gallery</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Art</li>
                    </ol>
                </nav>

            </div>
            <div class="row justify-content-md-center">
                <div class="col-4">
                    <h1>Art <span class="badge badge-pill badge-primary" style="background: rgb(200,175,106);">Edit</span></h1>
                </div>
                <div class="col-2">
                    <button type="button"  class="btn btn-danger btnGalleryDelete" style="max-width:none; position:absolute; right:13px;" data-toggle="modal" data-target="#deleteAlertEditArt">
                         Unload
                     </button>
                </div>
            </div>
            <div class="row justify-content-md-center">
                <div class="col-6">
                    <div class="form-group">
                        <label for="artName">Name</label>
                        <asp:TextBox runat="server" class="form-control" ValidationGroup="art" ID="artName" Style="max-width: none;"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="artNameRequired" runat="server" ControlToValidate="artName"
                                ErrorMessage="*Art name is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <asp:CustomValidator class="validation-msg" ValidationGroup="art" ID="duplicateArtName" runat="server" Display="Dynamic" 
                                onservervalidate="DuplicateArtName" ErrorMessage="*Art name existed" ForeColor="Red">
                        </asp:CustomValidator>
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <asp:TextBox runat="server" type="number" class="form-control" ValidationGroup="art" ID="price" Style="max-width: none;" min="0"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="priceRequired" runat="server" ControlToValidate="price"
                                ErrorMessage="*Price is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label for="stock">Stocks</label>
                        <asp:TextBox runat="server" type="number" class="form-control" ValidationGroup="art" ID="stock" Style="max-width: none;" min="0"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="stockRequired" runat="server" ControlToValidate="stock"
                                ErrorMessage="*Quantity is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label for="style">Style</label>
                        <asp:DropDownList ID="style" runat="server" class="form-control" style="max-width:none;">
                            <asp:ListItem>-- Select --</asp:ListItem>
                            <asp:ListItem>Abstract</asp:ListItem>
                            <asp:ListItem>Figurative</asp:ListItem>
                            <asp:ListItem>Geometric</asp:ListItem>
                            <asp:ListItem>Minimalist</asp:ListItem>
                            <asp:ListItem>Nature</asp:ListItem>
                            <asp:ListItem>Pop</asp:ListItem>
                            <asp:ListItem>Street Art</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="medium">Medium</label>
                        <asp:DropDownList ID="medium" runat="server" style="max-width:none;" class="form-control">
                            <asp:ListItem>-- Select --</asp:ListItem>
                            <asp:ListItem>Painting</asp:ListItem>
                            <asp:ListItem>Photography</asp:ListItem>
                            <asp:ListItem>Sculpture</asp:ListItem>
                            <asp:ListItem>Drawing</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="material">Material</label>
                        <asp:DropDownList ID="material" runat="server" style="max-width:none;" class="form-control">
                            <asp:ListItem>-- Select --</asp:ListItem>
                            <asp:ListItem>Acrylic Print</asp:ListItem>
                            <asp:ListItem>Aluminium Print</asp:ListItem>
                            <asp:ListItem>Paper Print (Matt)</asp:ListItem>
                            <asp:ListItem>Paper Print (Semi-Gloss)</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="size">Size</label>
                        <asp:TextBox runat="server" type="number" class="form-control" style="max-width:none;" ValidationGroup="art" ID="height" min="0" placeholder="Height (cm)"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="heightRequired" runat="server" ControlToValidate="height"
                                ErrorMessage="*Height is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox runat="server" type="number" class="form-control" style="max-width:none;" ValidationGroup="art" ID="width" min="0" placeholder="Width (cm)"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="WitdhRequired" runat="server" ControlToValidate="width"
                                ErrorMessage="*Width is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <asp:TextBox runat="server" TextMode="MultiLine" class="form-control" ValidationGroup="art" ID="description" Rows="3" Style="max-width: none;"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="descriptionRequired" runat="server" ControlToValidate="description"
                                ErrorMessage="*Description is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label for="artImage">Image</label>
                        <br />
                        <img id="image" runat="server" style="width:100%;" ClientIDMode="Static"/>

                        <asp:FileUpload runat="server" class="form-control-file" accept="image/*" name="image" ID="file" onchange="loadFile(event)" />
                        <script>
                            var loadFile = function (event) {
                                var image = document.getElementById('image');
                                image.src = URL.createObjectURL(event.target.files[0]);
                            };
                        </script>
                    </div>
                    <br />
                    <br />
                    <asp:Button runat="server" ValidationGroup="art" Text="Submit" type="submit" class="btn btn-primary" Style="max-width:none; background: rgba(200,175,106,1); border-color: rgba(200,175,106,1); width: 100%" OnClick="Submit_Click" />
                </div>
                <br />
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="deleteAlertEditArt" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                        <asp:Button runat="server" ID="deleteButtonGallery" Text="Unload"  class="btn btn-danger" onClick="DeleteArt"/>                        
                    </div>
                </div>
            </div>
        </div>

</asp:Content>
