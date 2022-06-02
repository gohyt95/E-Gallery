using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        public static DataSet runSqlSelect(string strSelect, Dictionary<string, string> QueryParams, string tableName)
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

            // Step 6: Run the query
            try
            {
                da.Fill(ds, tableName);
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


            if (dtrRecord.HasRows)
            {
                dtrRecord.Read();
                return dtrRecord[field].ToString();
            }
            else
            {
                return "";
            }
        }

        public static int runSqlInsertIdentity(string strInsert, Dictionary<string, string> QueryParams)
        {
            // Step 1: Create Connection
            SqlConnection con;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Step 2: Open Connection
            con = new SqlConnection(strCon);
            con.Open();

            // Step 3: Query

            // Step 4: Create SQL command to run
            SqlCommand cmdCUD = new SqlCommand(strInsert, con);

            // Step 5: Add Parameter
            foreach (KeyValuePair<string, string> param in QueryParams)
            {
                cmdCUD.Parameters.AddWithValue(param.Key, param.Value);
            }

            int n = (int)(decimal)cmdCUD.ExecuteScalar();

            return n;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["role"] == null || !Session["role"].Equals("customer"))
                    Response.Redirect("~/login.aspx");

                // Data
                string custId = Session["custId"].ToString();

                if (Request.QueryString["orderId"] == null)
                    Response.Redirect("~/Default.aspx");

                string orderId = Request.QueryString["orderId"].ToString();

                // Count the price and item count
                Dictionary<string, string> queryParamsCompute = new Dictionary<string, string>();

                string strCompute = "SELECT COUNT(Cart.artId) as artCount, SUM(Art.price * Cart.quantity) as subTotal " +
                                    "FROM Cart " +
                                    "Join Art ON Cart.artId = Art.artId " +
                                    "Join Orders ON Cart.orderId = Orders.orderId " +
                                    "WHERE Cart.custId = @custId " +
                                    "AND Cart.itemStatus > 1 " +
                                    "AND Cart.orderId = @orderId ";

                queryParamsCompute.Add("@custId", custId);
                queryParamsCompute.Add("@orderId", orderId);
                DataSet ds = runSqlSelect(strCompute, queryParamsCompute, "ResultTable");

                if (ds.Tables[0].Rows.Count == 0)
                    Response.Redirect("~/Default.aspx");

                if (Convert.ToInt32(ds.Tables["ResultTable"].Rows[0]["artCount"]) != 0)
                {
                    double price = Convert.ToDouble(ds.Tables["ResultTable"].Rows[0]["subTotal"]);
                    orderSummaryItem.InnerText = "Total (" + ds.Tables["ResultTable"].Rows[0]["artCount"].ToString() + " item): ";
                    orderSummaryPrice.InnerText = "RM " + String.Format("{0:n2}", price);
                    orderTotalArt1.InnerText = "RM " + String.Format("{0:n2}", price);
                    orderTotalFinal1.InnerText = "RM " + String.Format("{0:n2}", price + 10);
                    Session["toPay"] = price + 10;
                }
                else
                {
                    Response.Redirect("Cart.aspx");
                }

                // Get Customer Address
                Dictionary<string, string> queryParamsAddress = new Dictionary<string, string>();

                string strAddress = "SELECT shipTo " +
                                    "FROM Orders " +
                                    "WHERE orderId = @orderId";

                queryParamsAddress.Add("@orderId", orderId);
                DataSet ds2 = runSqlSelect(strAddress, queryParamsAddress, "ShipAddress");

                // If user have address
                txtShipTo.Text = (string)(ds2.Tables["ShipAddress"].Rows[0]["shipTo"]);
                txtShipTo.ReadOnly = true;
                txtShipTo.Enabled = false;

                // Get Order Status
                Dictionary<string, string> queryParamsStatus = new Dictionary<string, string>();

                string strStatus = "SELECT Cart.itemStatus " +
                                    "FROM Cart " +
                                    "Join Orders " +
                                    "ON Cart.orderId = Orders.orderId " +
                                    "WHERE Cart.custId = @custId " +
                                    "AND Cart.orderId = @orderId";

                queryParamsStatus.Add("@custId", custId);
                queryParamsStatus.Add("@orderId", orderId);
                DataSet ds3 = runSqlSelect(strStatus, queryParamsStatus, "StatusTable");

                string orderStatus = ds3.Tables["StatusTable"].Rows[0]["itemStatus"].ToString();
                chekoutStatus.CurrentPhase = orderStatus;

                // Payment button
                btnPayNow.HRef = "~/Payment.aspx?orderId=" + orderId;
                if (orderStatus != "2")
                {
                    btnPayNow.Visible = false;
                }
            }
            catch
            {
                Response.Redirect("~/Default.aspx");
            }
            
        }

        protected void returnBtn_Click(object sender, EventArgs e)
        {
            
        }
    }
}