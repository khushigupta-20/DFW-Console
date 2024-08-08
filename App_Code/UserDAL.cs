using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class UserDAL
{
    // Connection string 
    private readonly string connectionString = ConfigurationManager.ConnectionStrings["UserDBConnectionString"].ConnectionString;

    // to add user - for sign up page
    public bool AddUser(string username, string name, string mobile, string password)
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO Users (Username, Name, Mobile, Password) VALUES (@Username, @Name, @Mobile, @Password)", con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Mobile", mobile);
                cmd.Parameters.AddWithValue("@Password", password);

                con.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                con.Close();

                return rowsAffected > 0;
            }
        }
    }

    // to get user (for login)
    public DataTable GetUser(string username, string password)
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE Username = @Username AND Password = @Password", con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    return dt;
                }
            }
        }
    }
}
