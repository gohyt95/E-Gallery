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
    public partial class Checkout : System.Web.UI.Page
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

            // Step 6: Run the Query
            da.Fill(ds, tableName);

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
            cmdCUD.Parameters.AddWithValue("@orderDate", DateTime.Now);

            int n = (int)(decimal)cmdCUD.ExecuteScalar();

            return n;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || !Session["role"].Equals("customer"))
                Response.Redirect("~/login.aspx");

            // Data
            string custId = Session["custId"].ToString();

            // Count the price and item count
            Dictionary<string, string> queryParamsCompute = new Dictionary<string, string>();

            string strCompute = "SELECT COUNT(Cart.artId) as artCount, SUM(Art.price * Cart.quantity) as subTotal " +
                                "FROM Cart " +
                                "Join Art ON Cart.artId = Art.artId " +
                                "WHERE cart.custId = @custId " +
                                "AND cart.itemStatus = 1";

            queryParamsCompute.Add("@custId", custId);
            DataSet ds = runSqlSelect(strCompute, queryParamsCompute, "ResultTable");

            if (Convert.ToInt32(ds.Tables["ResultTable"].Rows[0]["artCount"]) != 0)
            {
                double price = Convert.ToDouble(ds.Tables["ResultTable"].Rows[0]["subTotal"]);
                checkoutSummaryItem.InnerText = "Total (" + ds.Tables["ResultTable"].Rows[0]["artCount"].ToString() + " item): ";
                checkoutSummaryPrice.InnerText = "RM " + String.Format("{0:n2}", price);
                orderTotalArt.InnerText = "RM " + String.Format("{0:n2}", price);
                orderTotalFinal.InnerText = "RM " + String.Format("{0:n2}", price + 10);
                Session["toPay"] = price + 10;
            }
            else
            {
                Response.Redirect("Cart.aspx");
            }

            // Get Customer Address
            Dictionary<string, string> queryParamsAddress = new Dictionary<string, string>();

            string strAddress = "SELECT * " +
                                "FROM Address " +
                                "WHERE custId = @custId";

            queryParamsAddress.Add("@custId", custId);
            DataSet ds2 = runSqlSelect(strAddress, queryParamsAddress, "AddressTable");

            // If user have address

            if (ds2.Tables["AddressTable"].Rows[0]["street"] != DBNull.Value)
            {
                // User want to use his address
                if(rbCheckoutAddress.SelectedValue == "0")
                {
                    txtFirstNameCheckout.Text = Session["firstName"].ToString();
                    txtLastNameCheckout.Text = Session["lastName"].ToString();
                    txtStreetCheckout.Text = (string)(ds2.Tables["AddressTable"].Rows[0]["street"]);
                    txtCityCheckout.Text = (string)(ds2.Tables["AddressTable"].Rows[0]["city"]);
                    txtStateCheckout.Text = (string)(ds2.Tables["AddressTable"].Rows[0]["state"]);
                    txtPostalCheckout.Text = (string)(ds2.Tables["AddressTable"].Rows[0]["postalCode"]);
                    txtPhoneCheckout.Text = Session["custPhone"].ToString();

                    txtFirstNameCheckout.ReadOnly = true;
                    txtLastNameCheckout.ReadOnly = true;
                    txtStreetCheckout.ReadOnly = true;
                    txtCityCheckout.ReadOnly = true;
                    txtStateCheckout.ReadOnly = true;
                    txtPostalCheckout.ReadOnly = true;
                    txtPhoneCheckout.ReadOnly = true;

                    txtFirstNameCheckout.Enabled = false;
                    txtLastNameCheckout.Enabled = false;
                    txtStreetCheckout.Enabled = false;
                    txtCityCheckout.Enabled = false;
                    txtStateCheckout.Enabled = false;
                    txtPostalCheckout.Enabled = false;
                    txtPhoneCheckout.Enabled = false;
                } else
                {
                    if (IsPostBack)
                    {
                        string controlId = Page.Request.Params["__EVENTTARGET"];
                        Control postbackControl = Page.FindControl(controlId);
                        
                        if(postbackControl.ID != "btnPlaceOrder")
                        {
                            txtFirstNameCheckout.Text = "";
                            txtLastNameCheckout.Text = "";
                            txtStreetCheckout.Text = "";
                            txtCityCheckout.Text = "";
                            txtStateCheckout.Text = "";
                            txtPostalCheckout.Text = "";
                            txtPhoneCheckout.Text = "";
                        }
                    } else
                    {
                        txtFirstNameCheckout.Text = "";
                        txtLastNameCheckout.Text = "";
                        txtStreetCheckout.Text = "";
                        txtCityCheckout.Text = "";
                        txtStateCheckout.Text = "";
                        txtPostalCheckout.Text = "";
                        txtPhoneCheckout.Text = "";
                    }

                    txtFirstNameCheckout.ReadOnly = false;
                    txtLastNameCheckout.ReadOnly = false;
                    txtStreetCheckout.ReadOnly = false;
                    txtCityCheckout.ReadOnly = false;
                    txtStateCheckout.ReadOnly = false;
                    txtPostalCheckout.ReadOnly = false;
                    txtPhoneCheckout.ReadOnly = false;

                    txtFirstNameCheckout.Enabled = true;
                    txtLastNameCheckout.Enabled = true;
                    txtStreetCheckout.Enabled = true;
                    txtCityCheckout.Enabled = true;
                    txtStateCheckout.Enabled = true;
                    txtPostalCheckout.Enabled = true;
                    txtPhoneCheckout.Enabled = true;
                }
            } else
            {
                rbCheckoutAddress.Items.FindByValue("0").Enabled = false;
                rbCheckoutAddress.Items.FindByValue("1").Selected = true;
            }
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            // Data
            string custId = Session["custId"].ToString();
            string toShip = txtFirstNameCheckout.Text + " " + txtLastNameCheckout.Text + ", " + txtPhoneCheckout.Text + ", " +
                txtStreetCheckout.Text + " " + txtPostalCheckout.Text + " " + txtCityCheckout.Text + " " + txtStateCheckout.Text;

            // Update Cart Item
            Dictionary<string, string> queryParamsUpdatePhone = new Dictionary<string, string>();

            string strUpdatePhone = "UPDATE Customer " +
                "SET custPhone = @custPhone " +
                "WHERE custId = @custId ";

            queryParamsUpdatePhone.Add("@custPhone", txtPhoneCheckout.Text);
            queryParamsUpdatePhone.Add("@custId", custId);

            runSqlCUD(strUpdatePhone, queryParamsUpdatePhone);
            Session["custPhone"] = txtPhoneCheckout.Text;

            // Get Cart Item To Deduct Stock
            Dictionary<string, string> queryParamsCartSelect = new Dictionary<string, string>();

            string strCartSelect = "SELECT artId, quantity " +
                                "FROM Cart " +
                                "WHERE custId = @custId " +
                                "AND itemStatus = 1";

            queryParamsCartSelect.Add("@custId", custId);
            DataSet ds = runSqlSelect(strCartSelect, queryParamsCartSelect, "CartTable");

            // Update item that get bought
            Dictionary<string, string> queryParamsUpdateStock = new Dictionary<string, string>();

            string strUpdateStock = "UPDATE Art " +
                "SET stock = stock - @quantity " +
                "WHERE artId = @artId";

            queryParamsUpdateStock.Add("@artId", "");
            queryParamsUpdateStock.Add("@quantity", "");

            foreach (DataRow dr in ds.Tables["CartTable"].Rows)
            {
                queryParamsUpdateStock["@artId"] = dr["artId"].ToString();
                queryParamsUpdateStock["@quantity"] = dr["quantity"].ToString();
                runSqlCUD(strUpdateStock, queryParamsUpdateStock);
            }

            // Insert new order
            Dictionary<string, string> queryParamsNewOrder = new Dictionary<string, string>();

            string strCreateOrder = "INSERT INTO Orders (totalPrice, orderDate, shipTo) " +
                "VALUES (@toPay, @orderDate, @toShip); " +
                "SELECT Scope_Identity()";

            queryParamsNewOrder.Add("@toPay", Session["toPay"].ToString());
            queryParamsNewOrder.Add("@toShip", toShip);

            int orderId = runSqlInsertIdentity(strCreateOrder, queryParamsNewOrder);

            // Update Cart Item
            Dictionary<string, string> queryParamsUpdateCart = new Dictionary<string, string>();

            string strUpdateCart = "UPDATE Cart " +
                "SET itemStatus = 2," +
                "orderId = @orderId " +
                "WHERE custId = @custId " +
                "AND itemStatus = 1";

            queryParamsUpdateCart.Add("@orderId", orderId.ToString());
            queryParamsUpdateCart.Add("@custId", custId);

            int result = runSqlCUD(strUpdateCart, queryParamsUpdateCart);

            if (result > 0)
            {
                Response.Redirect("Payment.aspx?orderId=" + orderId.ToString());
            }
        }
    }
}