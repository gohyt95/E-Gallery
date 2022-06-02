using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;

namespace ArtGallery1
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        Models.ArtGalleryEntities db = new Models.ArtGalleryEntities();
        private static Random random = new Random();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cReset_Password(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string tempPin = RandomString(8);
                string nhash = Security.ShaEncrypt(tempPin);
                string email = cResetEmail.Text;
                Models.Customer u = db.Customers.SingleOrDefault(s => s.custEmail == email);
                u.custPassword = nhash;
                db.SaveChanges();

                MailMessage myMessage = new MailMessage();
                myMessage.Subject = "A4 Gallery Reset Password Verification";
                myMessage.Body = "There is your new temporary password: "+tempPin+"\nSent at" + DateTime.Now;
                myMessage.From = new MailAddress("a4artgalleryrsf2@gmail.com", "A4 ArtGallery");
                myMessage.To.Add(new MailAddress(u.custEmail, u.firstName));
                SmtpClient mySmtpClient = new SmtpClient();
                mySmtpClient.Timeout = 30000;
                try
                {
                    mySmtpClient.Send(myMessage);
                    cResetResponse.Text = "Reset successfully";
                }
                catch (Exception exc)
                {
                    cResetResponse.Text = "Reset failed";
                }
                
            }
        }

        protected void aReset_Password(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string tempPin = RandomString(8);
                string nhash = Security.ShaEncrypt(tempPin);
                string email = aResetEmail.Text;
                Models.Artist u = db.Artists.SingleOrDefault(s => s.artistEmail == email);
                u.artistPassword = nhash;
                db.SaveChanges();

                MailMessage myMessage = new MailMessage();
                myMessage.Subject = "A4 Gallery Reset Password Verification";
                myMessage.Body = "There is a verification msg and URL here\n" + "Sent at" + DateTime.Now;
                myMessage.From = new MailAddress("a4artgalleryrsf2@gmail.com", "A4 ArtGallery");
                myMessage.To.Add(new MailAddress(u.artistEmail, u.artistName));
                SmtpClient mySmtpClient = new SmtpClient();
                mySmtpClient.Timeout = 30000;
                try
                {
                    mySmtpClient.Send(myMessage);
                    aResetResponse.Text = "Reset successfully";
                }
                catch (Exception exc)
                {
                    aResetResponse.Text = "Reset failed";
                }
            }
        }

        protected void cFindUser(object source, ServerValidateEventArgs args)
        {
            string email = cResetEmail.Text;
            Models.Customer u = db.Customers.SingleOrDefault(s => s.custEmail == email);
            if (u != null)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void aFindUser(object source, ServerValidateEventArgs args)
        {
            string email = aResetEmail.Text;
            Models.Artist u = db.Artists.SingleOrDefault(s => s.artistEmail == email);
            if (u != null)
            {
                args.IsValid = true;
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
                args.IsValid = false;
            }
        }

        
        public static string RandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
    }
}