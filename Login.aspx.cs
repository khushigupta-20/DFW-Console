using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private UserDAL userDAL = new UserDAL();

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text;
        string password = txtPassword.Text;

        DataTable user = userDAL.GetUser(username, password);

        if (user.Rows.Count > 0)
        {
            Session["id"] = user.Rows[0]["UserId"].ToString();
            Response.Redirect("Default2.aspx");
        }
        else
        {
            lblMessage.Text = "Invalid username or password. Please try again.";
        }
    }
}