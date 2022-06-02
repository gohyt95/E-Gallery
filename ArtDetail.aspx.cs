using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace ArtGallery1
{

    public partial class ArtDetail : System.Web.UI.Page
    {
        public static DataSet runSqlSelect(string strSelect, Dictionary<string, string> QueryParams)
        {
            // Step 1: Create Connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Step 2: Open Connection
            con = new SqlConnection(strCon);
            con.Open();

            // Step 3: Query

            // Step 4: Create SQL command to run
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);

            
            DataSet ds = new DataSet("ArtDataSet");
            SqlDataAdapter da = new SqlDataAdapter(cmdSelect.CommandText, con);

            // Step 5: Add Parameter
            foreach (KeyValuePair<string, string> param in QueryParams)
            {
                da.SelectCommand.Parameters.AddWithValue(param.Key, param.Value);
            }

            // Step 6: Run the Query
            try
            {
                da.Fill(ds, "ResultTable");
            }
            catch (Exception error)
            {
                return ds;
            }

            // Step 7: Close the connection
            con.Close();
            return ds;
        }

        public static int runSqlCUD(string strCUD, Dictionary<string, string> QueryParams)
        {
            // Step 1: Create Connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Step 2: Open Connection
            con = new SqlConnection(strCon);
            con.Open();

            // Step 3: Query

            // Step 4: Create SQL command to run
            SqlCommand cmdCUD = new SqlCommand(strCUD, con);

            // Step 5: Add Parameter
            foreach (KeyValuePair<string, string> param in QueryParams)
            {
                cmdCUD.Parameters.AddWithValue(param.Key, param.Value);
            }

            int n = cmdCUD.ExecuteNonQuery();

            return n;
        }

        public static string checkRecordExist(string strSelect, Dictionary<string, string> QueryParams, string field)
        {
            // Step 1: Create Connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Step 2: Open Connection
            con = new SqlConnection(strCon);
            con.Open();

            // Step 3: Query

            // Step 4: Create SQL command to run
            SqlCommand cmdSelect = new SqlCommand(strSelect, con);

            // Step 5: Add Parameter
            foreach (KeyValuePair<string, string> param in QueryParams)
            {
                cmdSelect.Parameters.AddWithValue(param.Key, param.Value);
            }

            // Step 6: Run the command
            SqlDataReader dtrRecord = cmdSelect.ExecuteReader();


            if(dtrRecord.HasRows)
            {
                dtrRecord.Read();
                return dtrRecord[field].ToString();
            } else
            {
                return "";
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string currentUrl = HttpContext.Current.Request.Url.ToString();
            string previousUrl = Request.UrlReferrer == null ? "" : Request.UrlReferrer.ToString();
            if (Security.getUrlFlow() != currentUrl)
            {
                Security.setUrlFlow(currentUrl);
                Security.setPrevious(previousUrl);
            }

            if (Session["role"] == null || !Session["role"].Equals("customer"))
                Response.Redirect("~/login.aspx");

            // Data
            string artId = "";
            string custId = Session["custId"].ToString();
            String quantity = "";
            String wishlist = "";
            if(Request.QueryString["art"] != null)
            {
                artId = Request.QueryString["art"];
            }
            else
                Response.Redirect("~/Art.aspx");



            // Check if item already in cart
            Dictionary<string, string> queryParamsSelect = new Dictionary<string, string>();

            string strFindExist = "SELECT quantity " +
                "FROM Cart " +
                "WHERE artId = @artId " +
                "AND custId = @custId " +
                "AND itemStatus = 1";

            queryParamsSelect.Add("@artId", artId);
            queryParamsSelect.Add("@custId", custId);


            quantity = checkRecordExist(strFindExist, queryParamsSelect, "quantity");
            
            

            if (quantity != "") // record exists
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "UpdateCartBtnScript",
                "updateCartBtn();",
                true);
            }

            if (!IsPostBack)
            {
                if (quantity != "")
                {
                    artDetailQuantity.Text = quantity;
                }
            }

            // Check if item already in favourite
            if (!IsPostBack)
            {
                Dictionary<string, string> queryParamsSelectWish = new Dictionary<string, string>();
                
                string strFindWishlist = "SELECT artId " +
                    "FROM Wishlist " +
                    "WHERE artId = @artId " +
                    "AND custId = @custId";

                queryParamsSelectWish.Add("@artId", artId);
                queryParamsSelectWish.Add("@custId", custId);

                wishlist = checkRecordExist(strFindWishlist, queryParamsSelectWish, "artId");


                if (wishlist != "")
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "UpdateFavouriteBtnScript",
                    "updateWishBtn(true);",
                    true);
                }
            }

            // Retrieve Art Detail
            Dictionary<string, string> queryParams = new Dictionary<string, string>();

            string strSelect = "SELECT a.*, u.artistName, u.artistEmail, u.country, u.artistPicture " +
                "FROM Art a " +
                "INNER JOIN Artist u " +
                "ON u.artistId = a.artistId " +
                "WHERE a.artId = @artId";

            queryParams.Add("@artId", artId);
            DataSet ds = runSqlSelect(strSelect, queryParams); 

            if(ds.Tables[0].Rows.Count == 0)
                Response.Redirect("~/Art.aspx");

            double price = Convert.ToDouble(ds.Tables["ResultTable"].Rows[0]["price"]);
            // Step 6: Display

            artDetailPicture.Src = "/source/" + ds.Tables["ResultTable"].Rows[0]["picture"];
            artDetailPicturePreview.Src = "/source/" + ds.Tables["ResultTable"].Rows[0]["picture"];
            artDetailArtName.InnerText = ds.Tables["ResultTable"].Rows[0]["artName"].ToString();
            artDetailPrice.InnerText = String.Format("{0:n2}", price);
            artDetailQuantity.Attributes["data-stock"] = ds.Tables["ResultTable"].Rows[0]["stock"].ToString();
            artDetailDescription.InnerText = ds.Tables["ResultTable"].Rows[0]["description"].ToString();
            artDetailMaterial.InnerText = ds.Tables["ResultTable"].Rows[0]["material"].ToString();
            artDetailMedium.InnerText = ds.Tables["ResultTable"].Rows[0]["medium"].ToString();
            artDetailStyle.InnerText = ds.Tables["ResultTable"].Rows[0]["style"].ToString();
            artDetailDimension.InnerText = "Dimension: " + ds.Tables["ResultTable"].Rows[0]["width"] + " x " + ds.Tables["ResultTable"].Rows[0]["height"];
            artDetailArtistName.InnerText = ds.Tables["ResultTable"].Rows[0]["artistName"].ToString();
            artDetailArtistEmail.InnerText += ds.Tables["ResultTable"].Rows[0]["artistEmail"].ToString();
            artDetailArtistCountry.InnerText += ds.Tables["ResultTable"].Rows[0]["country"].ToString();
            artDetailArtistPic.Src = "/usersource/" + ds.Tables["ResultTable"].Rows[0]["artistPicture"];
            artDetailArtistView.Attributes["href"] = "ArtistProfile.aspx?id=" + ds.Tables["ResultTable"].Rows[0]["artistId"].ToString();
        }

        protected void artAddToFavourite(object sender, EventArgs e)
        {
            if (Session["role"] == null || !Session["role"].Equals("customer"))
                Response.Redirect("~/login.aspx");

            string custId = Session["custId"].ToString();
            string artId = "";
            string artName = artDetailArtName.InnerText;
            string feedback = "";

            if (Request.QueryString["art"] != null)
            {
                artId = Request.QueryString["art"];
            }
            else
                Response.Redirect("~/Art.aspx");

            // Check if item already in wishlist
            Dictionary<string, string> queryParamsSelect = new Dictionary<string, string>();

            string strSelect = "SELECT artId " +
                "FROM Wishlist " +
                "WHERE artId = @artId " +
                "AND custId = @custId";

            queryParamsSelect.Add("@artId", artId);
            queryParamsSelect.Add("@custId", custId);

            string recordId = checkRecordExist(strSelect, queryParamsSelect, "artId");

            if (recordId == "")
            {
                // Insert art into wishlist
                Dictionary<string, string> queryParamsInsert = new Dictionary<string, string>();

                string strCreate = "INSERT INTO Wishlist (custId, artId) " +
                    "VALUES (@custId, @artId)";

                queryParamsInsert.Add("@custId", custId);
                queryParamsInsert.Add("@artId", artId);

                int result = runSqlCUD(strCreate, queryParamsInsert);

                feedback = "Successfully added <b>" + artName + "</b> into your wishlist!";
                Page.ClientScript.RegisterStartupScript(GetType(), "MyKey",
                "toast('" + feedback + "', 'success');",
                true);

                Page.ClientScript.RegisterStartupScript(GetType(), "UpdateFavouriteBtnScript",
                "updateWishBtn();",
                true);
            } else
            {
                // Delete Art from wishlist
                Dictionary<string, string> queryParamsDelete = new Dictionary<string, string>();

                string strCreate = "DELETE FROM Wishlist " +
                    "WHERE custId = @custid " +
                    "AND artId = @artId";

                queryParamsDelete.Add("@custId", custId);
                queryParamsDelete.Add("@artId", artId);

                int result = runSqlCUD(strCreate, queryParamsDelete);

                feedback = "Successfully <b>remove " + artName + "</b> from your wishlist!";
                Page.ClientScript.RegisterStartupScript(GetType(), "MyKey",
                "toast('" + feedback + "', 'success');",
                true);
            }
        }

        protected void artAddToCart(object sender, EventArgs e)
        {
            if (Session["role"] == null || !Session["role"].Equals("customer"))
                Response.Redirect("~/login.aspx");

            // Data
            string custId = Session["custId"].ToString();
            string artId = "";
            string artName = artDetailArtName.InnerText;
            string quantity = artDetailQuantity.Text;
            string feedback = "";
            string recordId = "";

            if (Request.QueryString["art"] != null)
            {
                artId = Request.QueryString["art"];
            }
            else
                Response.Redirect("~/Art.aspx");


            // Check if item already in cart
            Dictionary<string, string> queryParamsSelect = new Dictionary<string, string>();

            string strSelect = "SELECT cartId " +
                "FROM Cart " +
                "WHERE artId = @artId " +
                "AND custId = @custId " +
                "AND itemStatus = 1";

            queryParamsSelect.Add("@artId", artId);
            queryParamsSelect.Add("@custId", custId);

            recordId = checkRecordExist(strSelect, queryParamsSelect, "cartId");

            if(recordId == "")
            {
                // Insert art into cart
                Dictionary<string, string> queryParamsInsert = new Dictionary<string, string>();

                string strCreate = "INSERT INTO Cart (custId, artId, quantity, itemStatus) " +
                    "VALUES (@custId, @artId, @quantity, @itemStatus)";

                queryParamsInsert.Add("@custId", custId);
                queryParamsInsert.Add("@artId", artId);
                queryParamsInsert.Add("@quantity", quantity);
                queryParamsInsert.Add("@itemStatus", "1");

                int result = runSqlCUD(strCreate, queryParamsInsert);

                if(result > 0)
                {
                    feedback = "Successfully <b>added " + artName + "</b> into your cart!";
                    Page.ClientScript.RegisterStartupScript(GetType(), "MyKey",
                    "toast('" + feedback + "', 'success');",
                    true);
                    artDetailQuantity.Text = quantity;

                    Page.ClientScript.RegisterStartupScript(GetType(), "UpdateCartBtnScript",
                    "updateCartBtn();",
                    true);
                }
            } else
            {
                // Update art quantity in cart
                Dictionary<string, string> queryParamsUpdate = new Dictionary<string, string>();

                string strUpdate = "UPDATE Cart " +
                    "SET quantity = @quantity " +
                    "WHERE cartId = @cartId";

                queryParamsUpdate.Add("@quantity", quantity);
                queryParamsUpdate.Add("@cartId", recordId);

                int result = runSqlCUD(strUpdate, queryParamsUpdate);

                if(result > 0)
                {
                    feedback = "Successfully update <b>" + artName + "</b> to <b>" + quantity + "</b> in your cart!";
                    Page.ClientScript.RegisterStartupScript(GetType(), "MyKey",
                    "toast('" + feedback + "', 'success');",
                    true);
                    artDetailQuantity.Text = quantity;
                }
            }

            // This is unrelated to this function, I can't find a way to solve this, so i put it here first
            // Check if item already in favourite
            String wishlist = "";
            Dictionary<string, string> queryParamsSelectWish = new Dictionary<string, string>();

            string strFindWishlist = "SELECT artId " +
                "FROM Wishlist " +
                "WHERE artId = @artId " +
                "AND custId = @custId";

            queryParamsSelectWish.Add("@artId", artId);
            queryParamsSelectWish.Add("@custId", custId);

            wishlist = checkRecordExist(strFindWishlist, queryParamsSelectWish, "artId");


            if (wishlist != "")
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "UpdateFavouriteBtnScript",
                "updateWishBtn(true);",
                true);
            }

        }
    }
}