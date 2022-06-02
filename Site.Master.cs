using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArtistGallery.Attributes["class"] = "hidden-control";

            if (Session["username"] != null)
            {
                if (Session["role"].Equals("artist"))
                {
                    cartBtn.Attributes["class"] = "btn btn-light hidden-control";
                    favBtn.Attributes["class"] = "btn btn-light hidden-control";
                    userBtn.NavigateUrl = "~/ArtistControl.aspx?tab=account";
                    homeLogo.NavigateUrl = "Gallery.aspx";
                    artDropdown.Attributes["class"] = "nav-link dropdown-toggle navbar-fontsize hidden-control";
                    ArtistList.Attributes["class"] = "hidden-control";
                    ArtistGallery.Attributes["class"] = "nav-link navbar-fontsize";
                }
                else if (Session["role"].Equals("customer"))
                {
                    userBtn.NavigateUrl = "~/UserControl.aspx?tab=account";
                    favBtn.NavigateUrl = "~/UserControl.aspx?tab=fav";
                    ArtistGallery.Attributes["class"] = "hidden-control";
                }
            }
            else
            {
                userBtn.NavigateUrl = "~/login.aspx";
                favBtn.NavigateUrl = "~/login.aspx";
            }
                
        }

        protected void loginBtn_Click(object sender, EventArgs e)
        {
            Page.Validate("login");

            if (Page.IsValid)
            {
                
            }
        }

        protected void userBtn_Click(object sender, EventArgs e)
        {

        }

        protected void favBtn_Click(object sender, EventArgs e)
        {

        }
    }
}