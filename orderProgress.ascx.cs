using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ArtGallery1
{
    public partial class orderProgress : System.Web.UI.UserControl
    {
        public string CurrentPhase { get; set; } = "1";

        protected void Page_Load(object sender, EventArgs e)
        {
            switch (CurrentPhase)
            {
                case "1":
                    progressLine.Attributes["Class"] += " percent";
                    checkout0.Attributes["Class"] += " step-completed";
                    checkout1.Attributes["Class"] += " step-current";
                    break;
                case "2":
                    progressLine.Attributes["Class"] += " percent-2";
                    checkout0.Attributes["Class"] += " step-completed";
                    checkout1.Attributes["Class"] += " step-completed";
                    checkout2.Attributes["Class"] += " step-current";
                    break;
                case "3":
                    progressLine.Attributes["Class"] += " percent-3";
                    checkout0.Attributes["Class"] += " step-completed";
                    checkout1.Attributes["Class"] += " step-completed";
                    checkout2.Attributes["Class"] += " step-completed";
                    checkout3.Attributes["Class"] += " step-current";
                    break;
                case "4":
                    progressLine.Attributes["Class"] += " percent-3";
                    checkout0.Attributes["Class"] += " step-completed";
                    checkout1.Attributes["Class"] += " step-completed";
                    checkout2.Attributes["Class"] += " step-completed";
                    checkout3.Attributes["Class"] += " step-completed";
                    break;
            }
        }
    }
}