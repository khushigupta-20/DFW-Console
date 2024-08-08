using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["NorthwindContex"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            this.BindGrid();
        }
    }

    private void BindGrid()
    {
        string query = "SELECT * FROM Customers";
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter(query, con))
            {
                using (DataTable dt = new DataTable())
                {
                    sda.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }
    }

    protected void Insert(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            string name = txtName.Text;
            string country = txtCountry.Text;
            txtName.Text = "";
            txtCountry.Text = "";
            string query = "INSERT INTO Customers (Name, Country,Photos) VALUES(@Name, @Country,@Photos)";
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                    string contentType = FileUpload1.PostedFile.ContentType;
                    using (Stream fs = FileUpload1.PostedFile.InputStream)
                    {
                        using (BinaryReader br = new BinaryReader(fs))
                        {
                            byte[] bytes = br.ReadBytes((Int32)fs.Length);
                            cmd.Parameters.AddWithValue("@Name", name);
                            cmd.Parameters.AddWithValue("@Country", country);
                            cmd.Parameters.AddWithValue("@Photos", bytes);
                            cmd.Connection = con;
                            con.Open();
                            int i = cmd.ExecuteNonQuery();
                            con.Close();
                            Message.SuccessMessess(this, "Data successfully submitted..");
                        }
                    }
                }
            }
            this.BindGrid();
        }
        else
        {
            Message.WarningAlert(this, "Please upload a file!!");
        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int customerId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
        string query = "DELETE FROM Customers WHERE CustomerId=@CustomerId";
         using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@CustomerId", customerId);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        this.BindGrid();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        this.BindGrid();
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = GridView1.Rows[e.RowIndex];
        int customerId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
        string name = (row.FindControl("txtName") as TextBox).Text;
        string country = (row.FindControl("txtCountry") as TextBox).Text;

        if (string.IsNullOrWhiteSpace(name) || string.IsNullOrWhiteSpace(country))
        {
            return;
        }

        string query = "UPDATE Customers SET Name=@Name, Country=@Country WHERE CustomerId=@CustomerId";
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand(query))
            {
                cmd.Parameters.AddWithValue("@CustomerId", customerId);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Country", country);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        GridView1.EditIndex = -1;
        this.BindGrid();
    }
    protected void OnPaging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        this.BindGrid();
    }
    protected void DownloadFile(object sender, EventArgs e)
    {
        int id = int.Parse((sender as LinkButton).CommandArgument);
        byte[] bytes;
        string fileName, contentType;
        string constr = ConfigurationManager.ConnectionStrings["NorthwindContex"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select Country from Customers where CustomerId=@Id";
                cmd.Parameters.AddWithValue("@Id", id);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    sdr.Read();
                    bytes = (byte[])sdr["photos"];
                    contentType = "image/jpeg";
                    fileName = sdr["Name"].ToString();
                }
                con.Close();
            }
        }
        Response.Clear();
        Response.Buffer = true;
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = contentType;
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName+".jpg");
        Response.BinaryWrite(bytes);
        Response.Flush();
        Response.End();
    }

}