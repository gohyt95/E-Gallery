using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class Art : System.Web.UI.Page
    {
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

            int count = 0;
            if (dtrRecord.HasRows)
            {
                while (dtrRecord.Read())
                {
                    count++;
                }
                return count.ToString();
            }
            else
            {
                return "";
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentUrl = HttpContext.Current.Request.Url.ToString();
            string previousUrl = Request.UrlReferrer == null ? "" : Request.UrlReferrer.ToString();
            if (Security.getUrlFlow() != currentUrl)
            {
                Security.setUrlFlow(currentUrl);
                Security.setPrevious(previousUrl);
            }

            if (!IsPostBack)
            {
                // Query String filter
                if (Request.QueryString["style"] != null)
                {
                    string artStyle = Request.QueryString["style"].ToUpper();

                    switch (artStyle)
                    {
                        case "ABSTRACT":
                            ddlFilterStyle.SelectedIndex = 1;
                            break;
                        case "FIGURATIVE":
                            ddlFilterStyle.SelectedIndex = 2;
                            break;
                        case "GEOMETRIC":
                            ddlFilterStyle.SelectedIndex = 3;
                            break;
                        case "MINIMALIST":
                            ddlFilterStyle.SelectedIndex = 4;
                            break;
                        case "NATURE":
                            ddlFilterStyle.SelectedIndex = 5;
                            break;
                        case "POP":
                            ddlFilterStyle.SelectedIndex = 6;
                            break;
                        case "STREET":
                            ddlFilterStyle.SelectedIndex = 7;
                            break;
                        default:
                            ddlFilterStyle.SelectedIndex = 0;
                            break;
                    }
                }

                if (Request.QueryString["medium"] != null)
                {
                    string artMedium = Request.QueryString["medium"].ToLower();

                    switch (artMedium)
                    {
                        case "painting":
                            ddlFilterMedium.SelectedIndex = 1;
                            break;
                        case "photography":
                            ddlFilterMedium.SelectedIndex = 2;
                            break;
                        case "sculpture":
                            ddlFilterMedium.SelectedIndex = 3;
                            break;
                        case "drawing":
                            ddlFilterMedium.SelectedIndex = 4;
                            break;
                        default:
                            ddlFilterMedium.SelectedIndex = 0;
                            break;
                    }
                }

                if (Request.QueryString["priceMin"] != null)
                {
                    double artPriceMin = 0.0;
                    bool isDouble = Double.TryParse(Request.QueryString["priceMin"], out artPriceMin);

                    if(isDouble)
                    {
                        artFilterPriceMinValue.Text = artPriceMin.ToString();
                    }
                }

                if (Request.QueryString["priceMax"] != null)
                {
                    double artPriceMax = 10500.0;
                    bool isDouble = Double.TryParse(Request.QueryString["priceMax"], out artPriceMax);

                    if (isDouble)
                    {
                        artFilterPriceMaxValue.Text = artPriceMax.ToString();
                    }
                }

            }

            // Check if record exist
            string strCount = "SELECT a.artId FROM Art a JOIN Artist u ON a.artistId = u.artistId " +
                "WHERE u.country LIKE CASE WHEN(@country = 'All') THEN '%' " +
                "ELSE @country END AND a.medium LIKE CASE WHEN(@medium = 'All') THEN '%' " +
                "ELSE @medium END AND a.style LIKE CASE WHEN(@style = 'All') THEN '%' " +
                "ELSE @style END AND a.width BETWEEN CAST(@widthMin AS INT) " +
                "AND CASE WHEN(CAST(@widthMax AS INT) = 505) THEN 100000 " +
                "ELSE CAST(@widthMax AS INT) END " +
                "AND a.height BETWEEN CAST(@heightMin AS INT) " +
                "AND CASE WHEN(CAST(@heightMax AS INT) = 505) " +
                "THEN 100000  ELSE CAST(@heightMax AS INT) END " +
                "AND a.price BETWEEN CAST(@priceMin AS INT) " +
                "AND CASE WHEN(CAST(@priceMax AS INT) = 10500) " +
                "THEN 1000000  ELSE CAST(@priceMax AS INT) END " +
                "AND a.stock > 0 " +
                "ORDER BY (CASE WHEN @order = 0 THEN a.artId END), (CASE WHEN @order = 1 THEN a.artId END), (CASE WHEN @order = 2 THEN a.price END), (CASE WHEN @order = 3 THEN a.price END) DESC";

            // Check if item already in cart
            Dictionary<string, string> queryParamsCount = new Dictionary<string, string>();

            queryParamsCount.Add("@country", ddlFilterArtist.SelectedValue);
            queryParamsCount.Add("@medium", ddlFilterMedium.SelectedValue);
            queryParamsCount.Add("@style", ddlFilterStyle.SelectedValue);
            queryParamsCount.Add("@widthMin", artFilterWidthMinValue.Text);
            queryParamsCount.Add("@widthMax", artFilterWidthMaxValue.Text);
            queryParamsCount.Add("@heightMin", artFilterHeightMinValue.Text);
            queryParamsCount.Add("@heightMax", artFilterHeightMaxValue.Text);
            queryParamsCount.Add("@priceMin", artFilterPriceMinValue.Text);
            queryParamsCount.Add("@priceMax", artFilterPriceMaxValue.Text);
            queryParamsCount.Add("@order", ddlSortArt.SelectedValue);

            string quantity = checkRecordExist(strCount, queryParamsCount, "artId");

            if (quantity == "") // record no exists
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "ShowNoResult",
                "noResult();",
                true);
                artRecords.Text = "0";
            } else
            {
                artRecords.Text = quantity;
            }
        }

        protected void artFilter(object sender, EventArgs e)
        {
            artPage.Text = "1";
        }
    }
}