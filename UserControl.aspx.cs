using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class UserControl : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();
        Models.ArtGalleryEntities1 wdb = new Models.ArtGalleryEntities1();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["username"] == null)
                    Response.Redirect("~/Default.aspx");
                else
                {
                    string tab = Request.QueryString["tab"];
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tab", "displayTab('" + tab + "');", true);
                    if (tab.Equals("fav"))
                    {
                        favCategory.Attributes["class"] = "ctm-list ctm-list-action px-2 active";
                    }
                    else if (tab.Equals("account"))
                    {
                        accountCategory.Attributes["class"] = "ctm-list ctm-list-action px-2 active";
                    }
                    else if (tab.Equals("orders"))
                    {
                        ordersCategory.Attributes["class"] = "ctm-list ctm-list-action px-2 active";
                    }
                    else if (tab.Equals("delivery"))
                    {
                        deliveryCategory.Attributes["class"] = "ctm-list ctm-list-action px-2 active";
                    }
                }

                if (Session["role"].Equals("customer"))
                {
                    string temp = Session["email"].ToString();
                    Models.Customer u = db.Customers.SingleOrDefault(x => x.custEmail == temp);
                    Models.Address a = db.Addresses.SingleOrDefault(x => x.custId == u.custId);
                    Models.Wishlist w = wdb.Wishlists.FirstOrDefault(x => x.custId == u.custId);
                    Models.Cart o = db.Carts.FirstOrDefault(x => x.custId == u.custId && x.itemStatus > 1);

                    if (u != null && IsPostBack == false)
                    {
                        email.Text = u.custEmail;
                        firstName.Text = u.firstName;
                        lastName.Text = u.lastName;
                    }

                    if (a != null && IsPostBack == false)
                    {
                        fname1.Text = u.firstName;
                        lname1.Text = u.lastName;
                        street.Text = a.street;
                        city.Text = a.city;
                        postcode.Text = a.postalCode;
                        state.Text = a.state;
                        phone.Text = u.custPhone;

                    }

                    if (w == null)
                    {
                        noFavDiv.Visible = true;
                    }

                    if (o == null)
                    {
                        noOrderDiv.Visible = true;
                    }

                }
            }
            catch
            {
                Response.Redirect("~/Default.aspx");
            }

            

        }

        protected void updateBtn_Click(Object sender, EventArgs e)
        {
            //Page.Validate("account1");
            if (Page.IsValid)
            {
                if (Session["role"].Equals("customer"))
                {
                    string custId = Session["custId"].ToString();
                    string fname = firstName.Text;
                    string lname = lastName.Text;

                    Dictionary<string, string> queryParamsUpdate = new Dictionary<string, string>();

                    string strCreate = "UPDATE Customer " +
                        "SET firstName = @fname, lastName = @lname " +
                        "WHERE custId = @custId";

                    queryParamsUpdate.Add("@custId", custId);
                    queryParamsUpdate.Add("@fname", fname);
                    queryParamsUpdate.Add("@lname", lname);

                    int result = DbHelper.runSqlCUD(strCreate, queryParamsUpdate);

                    if (result > 0)
                    {
                        profile1.Attributes["class"] = "alert alert-success";
                    }
                    else
                    {
                        profile2.Attributes["class"] = "alert alert-danger";
                    }

                }
                
            }
            
        }

        protected void updateBtn1_Click(Object sender, EventArgs e)
        {
            //Page.Validate("account2");

            if (Session["role"].Equals("customer"))
            {
                string custId = Session["custId"].ToString();

                if (Page.IsValid)
                {
                    //check old password match 1st
                    string nPass = newPass.Text;
                    int customer = Int32.Parse(custId);

                    //insert new passwotrd  
                    string nhash = Security.ShaEncrypt(nPass);
                    Models.Customer u = db.Customers.SingleOrDefault(x => x.custId == customer);

                    if(u != null)
                    {
                        u.custPassword = nhash;
                    }

                    int result = db.SaveChanges();

                    if (result > 0)
                    {
                        profile4.Attributes["class"] = "alert alert-danger hidden-control";
                        profile3.Attributes["class"] = "alert alert-success";
                    }
                    else
                    {
                        profile3.Attributes["class"] = "alert alert-success hidden-control";
                        profile4.InnerText = "Password update failed. Old password and new password cannot be same.";
                        profile4.Attributes["class"] = "alert alert-danger";
                    }

                }

            }
           
        }

        protected void deliveryBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                if (Session["role"].Equals("customer"))
                {
                    string custId = Session["custId"].ToString();
                    string dStreet = street.Text;
                    string dCity = city.Text;
                    string dPostcode = postcode.Text;
                    string dState = state.Text;
                    string cPhone = phone.Text;

                    Dictionary<string, string> queryParamsUpdateAddress = new Dictionary<string, string>();
                    Dictionary<string, string> queryParamsUpdatePhone = new Dictionary<string, string>();

                    string strCreate = "UPDATE Address " +
                        "SET street = @street, city = @city, state = @state, postalCode = @postalCode " +
                        "WHERE custId = @custId";

                    string strCreate1 = "UPDATE CUSTOMER " +
                        "SET custPhone = @custPhone " +
                        "WHERE custId = @custId";

                    queryParamsUpdateAddress.Add("@custId", custId);
                    queryParamsUpdateAddress.Add("@street", dStreet);
                    queryParamsUpdateAddress.Add("@city", dCity);
                    queryParamsUpdateAddress.Add("@postalCode", dPostcode);
                    queryParamsUpdateAddress.Add("@state", dState);
                    queryParamsUpdatePhone.Add("@custId", custId);
                    queryParamsUpdatePhone.Add("@custPhone", cPhone);

                    int result = DbHelper.runSqlCUD(strCreate, queryParamsUpdateAddress);
                    int result1 = DbHelper.runSqlCUD(strCreate1, queryParamsUpdatePhone);

                    if (result > 0 && result1 > 0)
                    {
                        delivery1.Attributes["class"] = "alert alert-success";
                    }
                    else
                    {
                        delivery2.Attributes["class"] = "alert alert-danger";
                    }

                }
            }
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
            Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("~/Default.aspx");
        }

        protected void validatePassword(Object source, ServerValidateEventArgs args)
        {
            if (Session["role"].Equals("customer"))
            {
                string oPass = oldPass.Text;
                int custId = Int32.Parse(Session["custId"].ToString());
                string hash = Security.ShaEncrypt(oPass);

                Models.Customer u = db.Customers.SingleOrDefault(x => x.custId == custId);

                if (u != null)
                {
                    if (u.custPassword == hash)
                    {
                        profile4.Attributes["class"] = "alert alert-danger hidden-control";
                        args.IsValid = true;
                    } 
                    else
                    {
                        profile4.Attributes["class"] = "alert alert-danger";
                        profile4.InnerText = "Password update failed. Old password not match";
                        args.IsValid = false;
                    }

                }
            }
            
        }
    }
}