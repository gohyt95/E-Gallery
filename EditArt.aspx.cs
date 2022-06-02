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
    public partial class EditArt : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["role"] == null || !Session["role"].Equals("artist"))
                    Response.Redirect("~/Default.aspx");

                string artId = "";

                if (Request.QueryString["art"] != null)
                {
                    artId = Request.QueryString["art"];
                }
                else
                    Response.Redirect("~/Gallery.aspx");


                // Step 1: Create Connection
                SqlConnection con;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                // Step 2: Open Connection
                con = new SqlConnection(strCon);
                con.Open();

                // Step 3: Query
                string strSelect = "SELECT * FROM Art WHERE artId = @artID AND artistId = @artistID";

                // Step 4: Create SQL command to run
                SqlCommand cmdSelect = new SqlCommand(strSelect, con);

                // Step 5: Add Parameter
                cmdSelect.Parameters.AddWithValue("@artId", artId);
                cmdSelect.Parameters.AddWithValue("@artistId", "1");

                // Step 6: Run the Query
                SqlDataReader dtrInfo = cmdSelect.ExecuteReader();

                // Step 6: Display
                if (!IsPostBack)
                {
                    if (dtrInfo.HasRows)
                    {
                        dtrInfo.Read();
                        artName.Text = dtrInfo["artName"].ToString();
                        price.Text = dtrInfo["price"].ToString();
                        stock.Text = dtrInfo["stock"].ToString();
                        style.Text = dtrInfo["style"].ToString();
                        medium.Text = dtrInfo["medium"].ToString();
                        material.Text = dtrInfo["material"].ToString();
                        height.Text = dtrInfo["height"].ToString();
                        width.Text = dtrInfo["width"].ToString();
                        description.Text = dtrInfo["description"].ToString();
                        image.Src = "/source/" + dtrInfo["picture"];
                    }
                    else
                    {
                        con.Close();
                        Response.Redirect("Gallery.aspx");
                    }
                }

                // Step 7: Close the connection
                con.Close();
            }
            catch
            {
                Response.Redirect("~/Gallery.aspx");
            }
            
        }

        protected void DeleteArt(object sender, EventArgs e)
        {

            int artIdD = Int32.Parse(Request.QueryString["art"]);
            Models.Art a = db.Arts.SingleOrDefault(x => x.artId == artIdD);

            a.isDelete = 1;

            db.SaveChanges();

            /*         deleteImage();



                       string artId = Request.QueryString["art"];


                       // Step 1: Create Connection
                       SqlConnection con;
                       string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                       // Step 2: Open Connection
                       con = new SqlConnection(strCon);
                       con.Open();

                       // Step 3: Query
                       string sql = "DELETE FROM Art WHERE artId = @artId";

                       // Step 4: Create SQL command to run
                       SqlCommand cmdCUD = new SqlCommand(sql, con);

                       // Step 5: Add Parameter
                       cmdCUD.Parameters.AddWithValue("@artId", artId);

                       int n = cmdCUD.ExecuteNonQuery();

                       if (n > 0)
                           Response.Write("Art is Deleted");
                       else
                           Response.Write("Opss! Unable to delete.");

                       // Step 6: Close the connection
                       con.Close();
            */

            Response.Redirect("Gallery.aspx");

        }

        protected void Submit_Click(object sender, EventArgs e)
        {

            string imgFile = "";

            //Upload image to source folder
            if (file.PostedFile.FileName != "")
            {
                imgFile = Path.GetFileName(file.PostedFile.FileName);
                file.SaveAs(Server.MapPath("source/" + imgFile));

                deleteImage();
            }

            if (Page.IsValid)
            {

                /*
                                (@artistId, @artName, @price, @stock, @description, " +
                                    "@material, @medium, @style, @picture, @width, @height)";*/

                /*if (file.PostedFile.FileName != "")
                    {
                        picture = imgFile,
                    }*/

                
                int artIdD = Int32.Parse(Request.QueryString["art"]);
                
                string artNameD = artName.Text;                
                float priceD = float.Parse(price.Text);
                int stockD = Int32.Parse(stock.Text);
                string descriptionD = description.Text;
                string materialD = material.SelectedValue;
                string styleD = style.SelectedValue;
                string mediumD = medium.SelectedValue;
                int witdhD = Int32.Parse(width.Text);
                int heigthD = Int32.Parse(height.Text);

                Models.Art a = db.Arts.SingleOrDefault(x => x.artId == artIdD);



                a.artName = artNameD;
                a.price = priceD;
                a.stock = stockD;
                a.description = descriptionD;
                a.material = materialD;
                a.style = styleD;
                a.medium = mediumD;
                a.height = heigthD;
                a.width = witdhD;

                //Upload image to source folder
                if (file.PostedFile.FileName != "")
                {
                    deleteImage();
                    imgFile = Path.GetFileName(file.PostedFile.FileName);
                    a.picture = imgFile;
                    file.SaveAs(Server.MapPath("source/" + imgFile));                    
                }


                db.SaveChanges();

                Response.Redirect("Gallery.aspx");
            }


            /*
                        string imgFile = "";

                        //Upload image to source folder
                        if (file.PostedFile.FileName != "")
                        {
                            imgFile = Path.GetFileName(file.PostedFile.FileName);
                            file.SaveAs(Server.MapPath("source/" + imgFile));

                            deleteImage();
                        }




                        //---------------------------------------------------------------------------
                        string artId = Request.QueryString["art"];

                        // Step 1: Create Connection
                        SqlConnection con;
                        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

                        // Step 2: Open Connection
                        con = new SqlConnection(strCon);
                        con.Open();

                        // Step 3: Query
                        string sql = "";

                        if (file.PostedFile.FileName != "")
                        {
                            sql = "UPDATE Art SET " +
                            "artName = @artName, price = @price, " +
                            "stock = @stock, description = @description, material = @material, " +
                            "medium = @medium, style = @style, picture = @picture, " +
                            "width = @width, height = @height " +
                            "WHERE artId = @artId";
                        }
                        else
                        {
                            sql = "UPDATE Art SET " +
                            "artName = @artName, price = @price, " +
                            "stock = @stock, description = @description, material = @material, " +
                            "medium = @medium, style = @style,  " +
                            "width = @width, height = @height " +
                            "WHERE artId = @artId";
                        }



                        // Step 4: Create SQL command to run
                        SqlCommand cmdCUD = new SqlCommand(sql, con);

                        // Step 5: Add Parameter
                        cmdCUD.Parameters.AddWithValue("@artId", artId);
                        cmdCUD.Parameters.AddWithValue("@artName", artName.Text);
                        cmdCUD.Parameters.AddWithValue("@price", price.Text);
                        cmdCUD.Parameters.AddWithValue("@stock", stock.Text);
                        cmdCUD.Parameters.AddWithValue("@style", style.SelectedValue);
                        cmdCUD.Parameters.AddWithValue("@medium", medium.SelectedValue);
                        cmdCUD.Parameters.AddWithValue("@material", material.SelectedValue);
                        cmdCUD.Parameters.AddWithValue("@height", height.Text);
                        cmdCUD.Parameters.AddWithValue("@width", width.Text);
                        cmdCUD.Parameters.AddWithValue("@description", description.Text);

                        if (file.PostedFile.FileName != "")
                        {
                            cmdCUD.Parameters.AddWithValue("@picture", imgFile);
                        }


                        int n = cmdCUD.ExecuteNonQuery();

                        if (n > 0)
                            Response.Write("Art is Edited");
                        else
                            Response.Write("Opss! Unable to edit.");


                        // Step 6: Close the connection
                        con.Close();



            Response.Redirect("Gallery.aspx");
                   */





        }

        private void deleteImage()
        {
            string artId = Request.QueryString["art"];

            // Step 1: Create Connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Step 2: Open Connection
            con = new SqlConnection(strCon);
            con.Open();

            // Step 3: Query
            string sql = "SELECT picture FROM Art WHERE artId = @artId";

            // Step 4: Create SQL command to run
            SqlCommand cmdCUD = new SqlCommand(sql, con);

            // Step 5: Add Parameter
            cmdCUD.Parameters.AddWithValue("@artId", artId);

            string imageFile = cmdCUD.ExecuteScalar().ToString();



  
            // Step 6: Close the connection
            con.Close();

            File.Delete(Server.MapPath("source/" + imageFile));
        }


        protected void DuplicateArtName(object source, ServerValidateEventArgs args)
        {
            string artNameCheck = artName.Text;
            Models.Art a = db.Arts.SingleOrDefault(a2 => a2.artName == artNameCheck && a2.isDelete == 0);

            int artIdD = Int32.Parse(Request.QueryString["art"]);
            Models.Art b = db.Arts.SingleOrDefault(x => x.artId == artIdD && x.isDelete == 0);


            if (a == null || artNameCheck == b.artName)
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