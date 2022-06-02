using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class _Default : Page
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
    }
}