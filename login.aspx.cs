using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class login : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string currentUrl = HttpContext.Current.Request.Url.ToString();
            string previousUrl = Request.UrlReferrer == null ? "" : Request.UrlReferrer.ToString();


            if (Security.getUrlFlow() != currentUrl)
            {
                Security.setUrlFlow(currentUrl);
                Security.setPrevious(previousUrl);
            }

        }

        protected void cancelBtn(object sender, EventArgs e)
        {
            Response.Redirect(Security.getPrevious());
        }

        protected void forgotPwd_Click(object sender, EventArgs e)
        {
            Response.Redirect("ForgotPassword.aspx");
        }

        protected void cloginBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = clUserName.Text;
                string password = clPassword.Text;
                string pass = Security.ShaEncrypt(password);
                Models.Customer u = db.Customers.SingleOrDefault(x => x.custEmail == email && x.custPassword == pass);
                
                if(u != null)
                {
                    Session["role"] = "customer";
                    Session["email"] = u.custEmail;
                    Session["username"] = u.firstName + " " + u.lastName;
                    Session["custId"] = u.custId;
                    Session["firstName"] = u.firstName;
                    Session["lastName"] = u.lastName;
                    Session["custPhone"] = u.custPhone;
                    string redirectUrl = Security.getPrevious();
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    cLog.Attributes["class"] = "nav-link active";
                    aLog.Attributes["class"] = "nav-link";
                    cLogtab.Attributes["class"] = "tab-pane fade show active";
                    aLogtab.Attributes["class"] = "tab-pane fade";
                    cloginFail.IsValid = false;
                }
            }
        }

        protected void aloginBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = alUserName.Text;
                string password = alPassword.Text;
                string pass = Security.ShaEncrypt(password);
                Models.Artist u = db.Artists.SingleOrDefault(x => x.artistEmail == email && x.artistPassword == pass);

                if (u != null)
                {
                    Session["role"] = "artist";
                    Session["email"] = u.artistEmail;
                    Session["username"] = u.artistName;
                    Session["artistId"] = u.artistId;
                    Session["artistName"] = u.artistName;
                    Response.Redirect("Gallery.aspx");
                }
                else
                {
                    cLog.Attributes["class"] = "nav-link";
                    aLog.Attributes["class"] = "nav-link active";
                    cLogtab.Attributes["class"] = "tab-pane fade";
                    aLogtab.Attributes["class"] = "tab-pane fade show active";
                    aloginFail.IsValid = false;
                }
            }
        }

        protected void loginFail_ServerValidate(object source, ServerValidateEventArgs args)
        {

        }
    }
}