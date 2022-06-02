using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class signup : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            //signupCancel.PostBackUrl = Request.UrlReferrer.ToString(); 
        }

        protected void cancelBtn(object sender, EventArgs e)
        {
            Page.Response.Redirect(Request.UrlReferrer.ToString());
        }

        protected void csignupBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string fName = cfName.Text;
                string lName = clName.Text;
                string email = sUserName.Text;
                string password = sPassword.Text;
                string pass = Security.ShaEncrypt(password);
                Models.Customer nCust = new Models.Customer
                {
                    custEmail = email,
                    custPassword = pass,
                    firstName = fName,
                    lastName = lName
                };
                db.Customers.Add(nCust);

                Models.Address nAddress = new Models.Address
                {
                    custId = nCust.custId
                };
                db.Addresses.Add(nAddress);

                db.SaveChanges();

                cSignupSuccess.Text = "Sign up successfully!";
            }
            else
            {
                cSign.Attributes["class"] = "nav-link active";
                aSign.Attributes["class"] = "nav-link";
                cSigntab.Attributes["class"] = "tab-pane fade show active";
                aSigntab.Attributes["class"] = "tab-pane fade";
                //cloginFail.IsValid = false;
            }
        }

        protected void asignuupBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string artistName = afName.Text + " " + alName.Text;
                string email = aUserName.Text;
                string password = aPassword.Text;
                string pass = Security.ShaEncrypt(password);
                Models.Artist nArtist = new Models.Artist
                {
                    artistName = artistName,
                    artistEmail = email,
                    artistPassword = pass,
                    artistPicture = "userNoProfilePicture.png"
                };

                db.Artists.Add(nArtist);
                db.SaveChanges();

                aSignupSuccess.Text = "Sign up successfully!";
                cSign.Attributes["class"] = "nav-link";
                aSign.Attributes["class"] = "nav-link active";
                cSigntab.Attributes["class"] = "tab-pane fade";
                aSigntab.Attributes["class"] = "tab-pane fade show active";
            }
            else
            {
                cSign.Attributes["class"] = "nav-link";
                aSign.Attributes["class"] = "nav-link active";
                cSigntab.Attributes["class"] = "tab-pane fade";
                aSigntab.Attributes["class"] = "tab-pane fade show active";
                //aloginFail.IsValid = false;
            }
        }

        protected void CduplicateEmail(object source, ServerValidateEventArgs args)
        {
            string email = sUserName.Text;
            Models.Customer u = db.Customers.SingleOrDefault(s => s.custEmail == email);
            if (u == null)
            { 
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void AduplicateEmail(object source, ServerValidateEventArgs args)
        {
            string email = aUserName.Text;
            Models.Artist u = db.Artists.SingleOrDefault(s => s.artistEmail == email);
            if (u == null)
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