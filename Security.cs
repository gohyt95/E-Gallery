using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Security;

namespace ArtGallery1
{
    public class Security
    {
        static string urlFlow;
        static string previousUrl;

        public static string ShaEncrypt(string pass)
        {
            byte[] binPass = Encoding.Default.GetBytes(pass);

            SHA256 sha = SHA256.Create();
            byte[] binHash = sha.ComputeHash(binPass);
            string encrypted = Convert.ToBase64String(binHash);

            return encrypted;

        }

        public static void setUrlFlow(string url)
        {
            urlFlow = url;
        }

        public static string getUrlFlow()
        {
            return urlFlow;
        }

        public static void setPrevious(string url)
        {
            previousUrl = url;
        }

        public static string getPrevious()
        {
            return previousUrl;
        }

        public static void LoginUser(string username, string role, bool rememberMe)
        {
            HttpContext ctx = HttpContext.Current;

            HttpCookie authCookie = FormsAuthentication.GetAuthCookie(username, rememberMe);
            FormsAuthenticationTicket oldTicket = FormsAuthentication.Decrypt(authCookie.Value);
            FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(
                oldTicket.Version,
                oldTicket.Name,
                oldTicket.IssueDate,
                oldTicket.Expiration,
                oldTicket.IsPersistent,
                role
            );
            authCookie.Value = FormsAuthentication.Encrypt(newTicket);
            ctx.Response.Cookies.Add(authCookie);


            string redirectUrl = FormsAuthentication.GetRedirectUrl(username, rememberMe);
            ctx.Response.Redirect(redirectUrl);
        }

        public static void ProcessRoles()
        {
            HttpContext ctx = HttpContext.Current;

            if (ctx.User != null &&
                ctx.User.Identity.IsAuthenticated &&
                ctx.User.Identity is FormsIdentity)
            {
                FormsIdentity identity = (FormsIdentity)ctx.User.Identity;
                string[] roles = identity.Ticket.UserData.Split(',');

                GenericPrincipal principal = new GenericPrincipal(identity, roles);
                ctx.User = principal;
                Thread.CurrentPrincipal = principal;
            }
        }
    }
}