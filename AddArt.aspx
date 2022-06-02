<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddArt.aspx.cs" Inherits="ArtGallery1.AddArt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


        <div class="container">
            <div class="row">
              
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb" style="background-color:white;">
                            <li class="breadcrumb-item"><a href="Gallery" style="color: rgb(200,175,106)">Gallery</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Art</li>
                        </ol>
                    </nav>
            
            </div>
            <div class="row justify-content-md-center">
                <div class="col-6">
                    <h1>Art <span class="badge badge-pill badge-primary" style="background: rgb(200,175,106);">New</span></h1>
                </div>
            </div>
            <div class="row justify-content-md-center">
                <div class="col-6">
                    <div class="form-group">           
                        <label for="artName">Name</label>
                        <asp:TextBox  runat="server" class="form-control" ValidationGroup="art"  id="artName" style="max-width:none;" placeholder="Art Name" MaxLength="50">   </asp:TextBox> 
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="artNameRequired" runat="server" ControlToValidate="artName"
                                ErrorMessage="*Art name is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <asp:CustomValidator class="validation-msg" ValidationGroup="art" ID="duplicateArtName" runat="server" Display="Dynamic" 
                                onservervalidate="DuplicateArtName" ErrorMessage="*Art name existed" ForeColor="Red">
                        </asp:CustomValidator>
                    </div>
                    <div class="form-group">
                        <label for="price">Price (RM)</label>
                        <asp:TextBox runat="server" type="number" class="form-control" ValidationGroup="art" id="price" Style="max-width: none;" min="0" placeholder="Price"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="priceRequired" runat="server" ControlToValidate="price"
                                ErrorMessage="*Price is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <label for="stock">Stocks</label>
                        <asp:TextBox  runat="server" type="number" class="form-control" ValidationGroup="art" id="stock" min="0" style="max-width:none;" placeholder="Quantity"></asp:TextBox> 
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="stockRequired" runat="server" ControlToValidate="stock"
                                ErrorMessage="*Quantity is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label for="style">Style</label>
                        <asp:DropDownList ID="style" runat="server" class="form-control" style="max-width:none;" >                            
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
                        <asp:DropDownList ID="medium" runat="server" class="form-control" style="max-width:none;">                           
                            <asp:ListItem>Painting</asp:ListItem>
                            <asp:ListItem>Photography</asp:ListItem>
                            <asp:ListItem>Sculpture</asp:ListItem>
                            <asp:ListItem>Drawing</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="material">Material</label>
                        <asp:DropDownList ID="material" runat="server" class="form-control" style="max-width:none;">
                            <asp:ListItem>Acrylic Print</asp:ListItem>
                            <asp:ListItem>Aluminium Print</asp:ListItem>
                            <asp:ListItem>Paper Print (Matt)</asp:ListItem>
                            <asp:ListItem>Paper Print (Semi-Gloss)</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label for="size">Size</label>
                        <asp:TextBox  runat="server" type="number" class="form-control" ValidationGroup="art" id="height" min="0" style="max-width:none;" placeholder="Height (cm)"></asp:TextBox> 
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="heightRequired" runat="server" ControlToValidate="height"
                                ErrorMessage="*Height is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                        <br />
                        <asp:TextBox  runat="server" type="number" class="form-control" ValidationGroup="art" id="width" min="0" style="max-width:none;" placeholder="Width (cm)"></asp:TextBox> 
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="WitdhRequired" runat="server" ControlToValidate="width"
                                ErrorMessage="*Width is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <asp:TextBox  runat="server" TextMode="MultiLine" class="form-control" ValidationGroup="art" id="description" rows="3" style="max-width:none;" placeholder="Art Description"></asp:TextBox>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="descriptionRequired" runat="server" ControlToValidate="description"
                                ErrorMessage="*Description is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    
                    <div class="form-group">
                        <label for="artImage">Image</label>
                        <br />
                        <img id="image" runat="server" style="width:100%;" ClientIDMode="Static"/>
                        
                        <asp:FileUpload runat="server" class="form-control-file" accept="image/*" name="image" ValidationGroup="art" id="file" onchange="loadFile(event)"/>
                        <script>
                            var loadFile = function (event) {
                                var image = document.getElementById('image');
                                image.src = URL.createObjectURL(event.target.files[0]);
                            };
                            
                        </script>
                        <asp:RequiredFieldValidator class="validation-msg" ValidationGroup="art" ID="imageRequired" runat="server" ControlToValidate="file"
                                ErrorMessage="*Image is required" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>
                    <br />
                    <br />
                    <asp:Button runat="server" Text="Post" type="submit" class="btn btn-primary" ValidationGroup="art" Style="max-width:none; background: rgba(200,175,106,1); border-color: rgba(200,175,106,1); width: 100%" OnClick="Post_Click" />
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <br />

                </div>
            </div>
        </div>


</asp:Content>
