using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{

    string constr = ConfigurationManager.ConnectionStrings["NorthwindContex"].ConnectionString;
    BAL bal = new BAL();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string name = txtName.Text;
        string country = txtCountry.Text;
        byte[] photo = null;

        if (fuPhoto.HasFile)
        {
            using (BinaryReader br = new BinaryReader(fuPhoto.PostedFile.InputStream))
            {
                photo = br.ReadBytes(fuPhoto.PostedFile.ContentLength);
            }
        }

        SqlParameter[] parameters = {
            new SqlParameter("@Name", name),
            new SqlParameter("@Country", country),
            new SqlParameter("@Photos", photo)
        };

        bal.ExecuteNonQuery("InsertCustomer", CommandType.StoredProcedure, parameters);
        LoadData();
    }

    protected void gvCustomers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int customerId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "DeleteCustomer")
        {
            SqlParameter[] parameters = {
                new SqlParameter("@CustomerId", customerId)
            };

            bal.ExecuteNonQuery("DeleteCustomer", CommandType.StoredProcedure, parameters);
            LoadData();
        }
        else if (e.CommandName == "DownloadPhoto")
        {
            SqlParameter[] parameters = {
                new SqlParameter("@CustomerId", customerId)
            };

            DataTable dt = bal.ExecuteQuery("GetCustomerPhoto", CommandType.StoredProcedure, parameters);
            if (dt.Rows.Count > 0)
            {
                byte[] photo = (byte[])dt.Rows[0]["Photos"];
                string fileName = dt.Rows[0]["Name"].ToString() + ".jpg";

                Response.Clear();
                Response.Buffer = true;
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = "image/jpeg";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(photo);
                Response.Flush();
                Response.End();
            }
        }
    }

    protected void gvCustomers_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvCustomers.EditIndex = e.NewEditIndex;
        LoadData();
    }

    protected void gvCustomers_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int customerId = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value.ToString());
        string name = (gvCustomers.Rows[e.RowIndex].FindControl("txtEditName") as TextBox).Text;
        string country = (gvCustomers.Rows[e.RowIndex].FindControl("txtEditCountry") as TextBox).Text;

        SqlParameter[] parameters = {
            new SqlParameter("@CustomerId", customerId),
            new SqlParameter("@Name", name),
            new SqlParameter("@Country", country)
        };

        bal.ExecuteNonQuery("UpdateCustomer", CommandType.StoredProcedure, parameters);
        gvCustomers.EditIndex = -1;
        LoadData();
    }

    protected void gvCustomers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvCustomers.EditIndex = -1;
        LoadData();
    }

    private void LoadData()
    {
        SqlParameter[] parameters = new SqlParameter[] { }; 
        DataTable dt = bal.ExecuteQuery("GetCustomers", CommandType.StoredProcedure, parameters);
        gvCustomers.DataSource = dt;
        gvCustomers.DataBind();
    }

    [WebMethod]
    public static void DeleteCustomer(int id)
    {
        BAL bal = new BAL();
        SqlParameter[] parameters = {
        new SqlParameter("@CustomerId", id)
    };
        bal.ExecuteNonQuery("DeleteCustomer", CommandType.StoredProcedure, parameters);
    }


}
