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
    public partial class Gallery : System.Web.UI.Page
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

        protected void repArt_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }

        protected void Edit_Click(object sender, EventArgs e)
        {
            string url;
            url = "EditArt.aspx?artId=" + Request.QueryString["art"];

            Response.Redirect(url);

            //Server.Transfer("EditArt.aspx");
        }
        protected void Add_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddArt.aspx");
        }

        protected void DeleteArt(object sender, EventArgs e)
        {
            int artIdD = Int32.Parse(delDataIdGallery.Text);
            Models.Art a = db.Arts.SingleOrDefault(x => x.artId == artIdD);

            a.isDelete = 1;

            db.SaveChanges();
/*
            

            deleteImage(artId);

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


        private void deleteImage(string artId)
        {            
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
    }
}