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
    public partial class Cart : System.Web.UI.Page
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
            da.Fill(ds, "ResultTable");

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
            if (Session["role"] == null || !Session["role"].Equals("customer"))
                Response.Redirect("~/login.aspx");

            // Data
            string custId = Session["custId"].ToString();

            // Count the price and item count
            Dictionary<string, string> queryParamsCompute = new Dictionary<string, string>();

            string strCompute = "SELECT COUNT(Cart.artId) as artCount, SUM(Art.price * Cart.quantity) as subTotal "  +
                                "FROM Cart " +
                                "Join Art ON Cart.artId = Art.artId " +
                                "WHERE cart.custId = @custId " +
                                "AND cart.itemStatus = 1";

            queryParamsCompute.Add("@custId", custId);
            DataSet ds = runSqlSelect(strCompute, queryParamsCompute);

            if (Convert.ToInt32(ds.Tables["ResultTable"].Rows[0]["artCount"]) != 0)
            {
                double price = Convert.ToDouble(ds.Tables["ResultTable"].Rows[0]["subTotal"]);
                cartSummaryItem.InnerText = "Total (" + ds.Tables["ResultTable"].Rows[0]["artCount"].ToString() + " item): ";
                cartSummaryPrice.InnerText = "RM " + String.Format("{0:n2}", price);
            } else
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "ShowNoCart",
                "emptyCart();",
                true);
            }

            // After submit delete cart item (for postback)
            if (Session["cartSuccess"] != null && Convert.ToBoolean(Session["cartSuccess"].ToString()))
            {
                string feedback = "";
                feedback = "Successfully <b>remove " + Session["cartName"] + "</b> from your cart!";
                Page.ClientScript.RegisterStartupScript(GetType(), "MyKey",
                "toast('" + feedback + "', 'success');",
                true);
                Session["cartSuccess"] = null;
                Session["cartName"] = null;
            }

        }

        protected void cartDeleteItem(object sender, EventArgs e)
        {
            // Data
            Button btn = sender as Button;
            string custId = Session["custId"].ToString();
            string artId = btn.Attributes["data-id"];
            string artName = "";

            // Check if item exist in cart and retrieve name
            Dictionary<string, string> queryParamsSelect = new Dictionary<string, string>();

            string strFindExist = "SELECT a.artName " +
                "FROM Cart c " +
                "INNER JOIN Art a " +
                "ON c.artId = a.artId " +
                "WHERE c.artId = @artId " +
                "AND c.custId = @custId " +
                "AND c.itemStatus = 1";

            queryParamsSelect.Add("@artId", artId);
            queryParamsSelect.Add("@custId", custId);

            artName = checkRecordExist(strFindExist, queryParamsSelect, "artName");

            if(artName != "")
            {
                // Delete Art from cart
                Dictionary<string, string> queryParamsDelete = new Dictionary<string, string>();

                string strDelete = "DELETE FROM Cart " +
                    "WHERE custId = @custid " +
                    "AND artId = @artId";

                queryParamsDelete.Add("@custId", custId);
                queryParamsDelete.Add("@artId", artId);

                int result = runSqlCUD(strDelete, queryParamsDelete);

                // Success Sql?
                if (result > 0)
                {
                    Session["cartSuccess"] = true;
                    Session["cartName"] = artName;
                    Session["cartQuantity"] = Convert.ToInt32(Session["cartQuantity"]) - 1;

                    Response.Redirect(Request.RawUrl);
                    
                }
            }
            
        }
    }
}