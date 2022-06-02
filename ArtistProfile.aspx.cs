using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class ArtistProfile : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();
      
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string currentUrl = HttpContext.Current.Request.Url.ToString();
                string previousUrl = Request.UrlReferrer == null ? "" : Request.UrlReferrer.ToString();
                if (Security.getUrlFlow() == currentUrl)
                {
                    if (Security.getUrlFlow() != Security.getPrevious())
                        Security.setUrlFlow(Security.getPrevious());
                }
                else
                {
                    Security.setUrlFlow(currentUrl);
                    Security.setPrevious(previousUrl);
                }

                //Response.Redirect(FormsAuthentication.GetRedirectUrl("", false));
                if (Request.QueryString["id"] != null)
                {
                    int artistId = Int32.Parse(Request.QueryString["id"]);
                    Models.Artist u = db.Artists.SingleOrDefault(s => s.artistId == artistId);
                    artistName.InnerText += u.artistName;
                    artistCountry.InnerText += u.country;
                    artistDesc.InnerText += u.description;
                    artistEmail.InnerText += u.artistEmail;
                    artDetailArtistPic.Src += u.artistPicture;
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            catch
            {
                Response.Redirect("~/Default.aspx");
            }
            
        }

        protected void returnBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect(Security.getUrlFlow());
        }
    }
}