using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace ArtGallery1
{
    public partial class AddArt : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            try
            {
                if (Session["role"] == null || !Session["role"].Equals("artist"))
                    Response.Redirect("~/Default.aspx");
            }
            catch
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        protected void Post_Click(object sender, EventArgs e)
        {
            if(Page.IsValid){
                /*
                                (@artistId, @artName, @price, @stock, @description, " +
                                    "@material, @medium, @style, @picture, @width, @height)";*/
                string artistID = Session["artistId"].ToString();
                

                string artNameD = artName.Text;
                int artistIdD = Int32.Parse(artistID);
                float priceD = float.Parse(price.Text);
                int stockD = Int32.Parse(stock.Text);
                string descriptionD = description.Text;
                string materialD = material.SelectedValue;
                string styleD = style.SelectedValue;
                string mediumD = medium.SelectedValue;
                int witdhD = Int32.Parse(width.Text);
                int heigthD = Int32.Parse(height.Text);
                string pictureD = Path.GetFileName(file.PostedFile.FileName);
                DateTime dateD = DateTime.Now;


                Models.Art artD = new Models.Art
                {
                    artistId = artistIdD,
                    artName = artNameD,
                    price = priceD,
                    stock = stockD,
                    description = descriptionD,
                    material = materialD,
                    style = styleD,
                    medium = mediumD,
                    picture = pictureD,
                    height = heigthD,
                    width = witdhD,
                    date = dateD,
                    isDelete = 0,
                };

                db.Arts.Add(artD);
                db.SaveChanges();

                try
                {
                    file.SaveAs(Server.MapPath("source/" + pictureD));
                }
                catch(Exception ex)
                {
                    Response.Redirect("~/Default.aspx");
                }

                Response.Redirect("Gallery.aspx");
                /*string imgFile = "";

                //Upload image to source folder
                if (file.PostedFile != null)
                {
                    imgFile = Path.GetFileName(file.PostedFile.FileName);
                    file.SaveAs(Server.MapPath("source/" + imgFile));
                }

                string artistID = Session["artistId"].ToString(); // modify this      

                // Step 1: Create Connection
                SqlConnection con;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                // Step 2: Open Connection
                con = new SqlConnection(strCon);
                con.Open();

                // Step 3: Query
                string sql = "INSERT INTO Art " +
                    "(artistId, artName, price, stock, " +
                    "description, material, medium, style, " +
                    "picture, width, height) " +
                    "Values (@artistId, @artName, @price, @stock, @description," +
                    "@material, @medium, @style, @picture, @width, @height)";

                // Step 4: Create SQL command to run
                SqlCommand cmdCUD = new SqlCommand(sql, con);

                // Step 5: Add Parameter
                cmdCUD.Parameters.AddWithValue("@artistId", artistID); //modify this
                cmdCUD.Parameters.AddWithValue("@artName", artName.Text);
                cmdCUD.Parameters.AddWithValue("@price", price.Text);
                cmdCUD.Parameters.AddWithValue("@stock", stock.Text);
                cmdCUD.Parameters.AddWithValue("@style", style.SelectedValue);
                cmdCUD.Parameters.AddWithValue("@medium", medium.SelectedValue);
                cmdCUD.Parameters.AddWithValue("@material", material.SelectedValue);
                cmdCUD.Parameters.AddWithValue("@height", height.Text);
                cmdCUD.Parameters.AddWithValue("@width", width.Text);
                cmdCUD.Parameters.AddWithValue("@description", description.Text);
                cmdCUD.Parameters.AddWithValue("@picture", imgFile);

                int n = cmdCUD.ExecuteNonQuery();

                if (n > 0)
                    Response.Write("Record is added");
                else
                    Response.Write("Opss! Unable to post.");

                // Step 6: Close the connection
                con.Close();

                Response.Redirect("Gallery.aspx");*/
            }                     
        }

        protected void DuplicateArtName(object source, ServerValidateEventArgs args)
        {
            string artNameCheck = artName.Text;
            
            Models.Art a = db.Arts.SingleOrDefault(a2 => a2.artName == artNameCheck && a2.isDelete == 0);
            
            if(a == null)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }

     
            
        }

    }
}