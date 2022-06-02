using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Net.Mail;
using System.Text.RegularExpressions;

namespace ArtGallery1
{
    public partial class Payment : System.Web.UI.Page
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] == null || !Session["role"].Equals("customer"))
                Response.Redirect("~/login.aspx");

            // Data
            string orderId = "";

            if (Request.QueryString["orderId"] != null)
            {
                orderId = Request.QueryString["orderId"];
            }
            else
                Response.Redirect("~/Art.aspx");

            // Find the order that need to pay
            Dictionary<string, string> queryParamsCompute = new Dictionary<string, string>();

            string strCompute = "SELECT o.totalPrice " +
                                "FROM Orders o " +
                                "Join Cart c ON c.orderId = o.orderId " +
                                "WHERE c.custId = @custId " +
                                "AND c.itemStatus = 2" +
                                "AND o.orderId = @orderId";

            queryParamsCompute.Add("@orderId", orderId);
            queryParamsCompute.Add("@custId", Session["custId"].ToString());
            DataSet ds = runSqlSelect(strCompute, queryParamsCompute, "ResultTable");

            // If no such record haven't paid
            if(ds.Tables[0].Rows.Count == 0)
                Response.Redirect("~/Default.aspx");
            else
            {
                txtPayAmount.Text = "RM " + ds.Tables["ResultTable"].Rows[0]["totalPrice"];
                txtPhoneNumber.Text = Session["custPhone"].ToString();
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            string orderId = Request.QueryString["orderId"];
            string custId = Session["custId"].ToString();
            string custName = Session["firstName"].ToString() + " " + Session["lastName"].ToString();
            string custEmail = Session["email"].ToString();
            string toPayRaw = txtPayAmount.Text;
            double toPay = Convert.ToDouble(Regex.Match(toPayRaw, @"\d+").Value);
            string toPayStr = (toPay - 10).ToString();
            string paymentMethod = "";

            if(txtPaymentType.Text == "0")
            {
                paymentMethod = "Online Banking (" + rbBank.SelectedValue + ")";
            } else
            {
                paymentMethod = "Credit / Debit Card";
            }

            if (txtPaymentType.Text == "1")
            {
                Page.Validate("creditCard");
            } else
            {
                Page.Validate("onlineBanking");
            }
            

            if (Page.IsValid)
            {
                // Update order items to 3 (payment success state)
                Dictionary<string, string> queryParamsUpdateCart = new Dictionary<string, string>();

                string strUpdateCart = "UPDATE Cart " +
                    "SET itemStatus = 3 " +
                    "WHERE custId = @custId " +
                    "AND orderId = @orderId " +
                    "AND itemStatus = 2";

                queryParamsUpdateCart.Add("@orderId", orderId);
                queryParamsUpdateCart.Add("@custId", custId);

                int result = runSqlCUD(strUpdateCart, queryParamsUpdateCart);

                // Send email
                if (result > 0)
                {
                    MailMessage myMessage = new MailMessage();
                    myMessage.IsBodyHtml = true;
                    myMessage.Subject = "Your A4Gallery Receipt " + orderId;
                    myMessage.Body = emailBody(orderId, custId, custName, toPayStr, paymentMethod);
                    myMessage.From = new MailAddress("a4artgalleryrsf2@gmail.com", "A4 ArtGallery");
                    myMessage.To.Add(new MailAddress(custEmail, custName));
                    SmtpClient mySmtpClient = new SmtpClient();
                    mySmtpClient.Timeout = 30000;
                    try
                    {
                        mySmtpClient.Send(myMessage);
                        Response.Redirect("~/PaymentSuccess.aspx?orderId=" + orderId);
                    }
                    catch (Exception exc)
                    {
                        Response.Write("Error: " + exc);
                    }
                }
            }
        }

        public static string emailBody(string orderId, string custId, string custName, string toPay, string paymentMethod)
        {
            double payTotal = Convert.ToDouble(toPay) + 10;
            string toPayWithDelivery = payTotal.ToString();

            string outputEmailBody = @"
<div style='background-color: #f8f9fa; padding: 8px; color:black'>
        <img src='https://i.imgur.com/HABPH8x.png' style='width: 50%; margin-bottom: 16px; margin:16px auto; display:block;'/>
        <h1 style='text-align:center'>Thank You For Your Purchase!</h1>
        <div style='padding: 24px; background-color: white; width: 50%; margin-top: 16px; display: block; margin: 0 auto; color:black'>
            <div style='text-align: center; color:black'>
                <b>Hello " + custName + @"!</b>
                <p>Thank you for purchasing from A4Gallery!</p>
                <h1>Order Id:</h1>
                <h1>" + orderId + @"</h1>" + @"
            </div>
            <h3>YOUR ORDER INFORMATION</h3><hr />
            <div>
                <ul style='list-style-type: none'>" +
                    orderDetail(orderId, custId) +
                @"</ul>
            </div>
            <hr />
            <h3>ORDERED ITEM(S)</h3>
            <table style='width:100%; border:0; margin-bottom: 32px'>
                <thead>
                    <tr style='border:0; background-color: #dddddd;'>
                        <th style='padding: 4px'>Art Name</th>
                        <th style='padding: 4px'>Quantity</th>
                        <th style='padding: 4px'>Price</th>
                    </tr>
                </thead>
                <tbody>" +
                    orderItems(orderId, custId)
                +@"</tbody>
                <tfoot>
                    <tr>
                        <td colspan='2' style='text-align: right; padding-right: 8px;'><b>TOTAL:</b></td>
                        <td>RM " + toPay + @"</td>
                    </tr>
                </tfoot>
            </table>
            <h3>PAYEMENT DETAILS</h3><hr />
            <table style='width: 100%'>
                <tr>
                    <td>Payment Total:</td>
                    <td>RM " + toPayWithDelivery + @"</td>
                </tr>
                <tr>
                    <td>Payment Method:</td>
                    <td>" + paymentMethod + @"</td>
                </tr>
            </table>
        </div>
    </div>
"; ;
            return outputEmailBody;
        }

        public static string orderDetail(string orderId, string custId)
        {
            // Retrieve Order Detail
            Dictionary<string, string> queryParams = new Dictionary<string, string>();
            string outputTable = "";

            string strSelect = "SELECT * " +
                                "FROM Orders o " +
                                "Join Cart c ON c.orderId = o.orderId " +
                                "WHERE c.custId = @custId " +
                                "AND c.itemStatus = 3" +
                                "AND o.orderId = @orderId";

            queryParams.Add("@orderId", orderId);
            queryParams.Add("@custId", custId);

            DataSet ds = runSqlSelect(strSelect, queryParams, "ResultTable");

            // Step 6: Display
            outputTable += "<li style='margin-bottom: 8px;'><b>Total Price:</b><br /> RM " + ds.Tables["ResultTable"].Rows[0]["totalPrice"] +
                "</li><li style='margin-bottom: 8px;'><b>Order Date:</b><br /> " + ds.Tables["ResultTable"].Rows[0]["orderDate"] +
                "</li><li style='margin-bottom: 8px;'><b>Ship to:</b><br /> " + ds.Tables["ResultTable"].Rows[0]["shipTo"] + "</li>";

            return outputTable;
        }

        public static string orderItems(string orderId, string custId)
        {
            // Retrieve Order Detail
            Dictionary<string, string> queryParams = new Dictionary<string, string>();
            string outputTable = "";

            string strSelect = "SELECT Cart.quantity, Art.artName, Art.price " +
                                "FROM Cart " +
                                "JOIN Art " +
                                "ON Cart.artId = Art.artId " +
                                "WHERE Cart.custId = @custId " +
                                "AND Cart.orderId = @orderId " +
                                "AND Cart.itemStatus = 3";

            queryParams.Add("@orderId", orderId);
            queryParams.Add("@custId", custId);

            DataSet ds = runSqlSelect(strSelect, queryParams, "ResultTable");

            foreach (DataRow dr in ds.Tables["ResultTable"].Rows)
            {
                outputTable += "<tr style='border:0'>" +
                    "<td>" + dr["artName"] + "</td>" +
                    "<td>" + dr["quantity"] + "</td>" +
                    "<td>RM " + dr["price"] + "</td></tr>";
            }

            return outputTable;
        }
    }
}