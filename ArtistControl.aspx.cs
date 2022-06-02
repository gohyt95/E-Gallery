using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class ArtistControl : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();

        string[] countries = { "Malaysia", "Singapore", "Thailand", "Indonesia" };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
                Response.Redirect("~/Default.aspx");

            string temp = Session["email"].ToString();
            Models.Artist u = db.Artists.SingleOrDefault(x => x.artistEmail == temp);
            for (int i = 0; i < countries.Length; i++)
            {
                countryList.Items.Insert(i, new ListItem(countries[i], countries[i]));
            }

            if (u != null && IsPostBack == false)
            {
                string[] fname = u.artistName.Split(' ');
                string lname = "";
                for (int i = 1; i < fname.Length; i++)
                {
                    lname += fname[i];
                    if (i != (fname.Length - 1))
                    {
                        lname += " ";
                    }
                }
                artistImage.Src = "usersource/" + u.artistPicture;
                email.Text = u.artistEmail;
                firstName.Text = fname[0];
                lastName.Text = lname;
                Phone.Text = u.artistPhone;
                countryList.SelectedValue = u.country;
                Description.Text = u.description;
            }


        }

        protected void updateBtn_Click(Object sender, EventArgs e)
        {
            
            //Page.Validate("account1");
            if (Page.IsValid)
            {
                string artistId = Session["artistId"].ToString();
                string imgFile = "";

                if (Page.IsValid)
                {
                    string fname = firstName.Text;
                    string lname = lastName.Text;
                    string phone = Phone.Text;
                    string country = countryList.SelectedItem.Value;
                    string desc = Description.Text;
                    string artistName = fname + " " + lname;
                    int artist = Int32.Parse(artistId);

                    Models.Artist u = db.Artists.SingleOrDefault(x => x.artistId == artist);

                    if(u != null)
                    {
                        u.artistName = artistName;
                        u.artistPhone = phone;
                        u.description = desc;
                        u.country = country;
                        //Response.Write(file.PostedFile.FileName);
                        //Upload image to source folder
                        if (file.PostedFile.FileName != "")
                        {
                            imgFile = System.IO.Path.GetFileName(file.PostedFile.FileName);
                            u.artistPicture = imgFile;
                            file.SaveAs(Server.MapPath("usersource/" + imgFile));
                        }
                    }

                    int result = db.SaveChanges();

                    if (result > 0)
                    {
                        profile2.Attributes["class"] = "alert alert-danger hidden-control";
                        profile1.Attributes["class"] = "alert alert-success";
                    }
                    else
                    {
                        profile1.Attributes["class"] = "alert alert-success hidden-control";
                        profile2.Attributes["class"] = "alert alert-danger";
                    }

                }
                
            }

        }

        protected void updateBtn1_Click(Object sender, EventArgs e)
        {

            string artistId = Session["artistId"].ToString();

            if (Page.IsValid)
            {
                //check old password match 1st
                string nPass = newPass.Text;
                int artist = Int32.Parse(artistId);

                //insert new passwotrd  
                string nhash = Security.ShaEncrypt(nPass);
                Models.Artist u = db.Artists.SingleOrDefault(x => x.artistId == artist);

                if (u != null)
                {
                    u.artistPassword = nhash;
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
            
            string oPass = oldPass.Text;
            string artistId = Session["artistId"].ToString();
            string hash = Security.ShaEncrypt(oPass);
            int artist = Int32.Parse(artistId);

            Models.Artist u = db.Artists.SingleOrDefault(x => x.artistId == artist);

            if (u != null)
            {
                if(u.artistPassword == hash)
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
