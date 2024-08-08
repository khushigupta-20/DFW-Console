using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class BAL
{
    string connectionString = ConfigurationManager.ConnectionStrings["NorthwindContex"].ConnectionString;

    public int ExecuteNonQuery(string strsql)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandTimeout = 1000;
            command.CommandText = strsql;
            return Convert.ToInt32(command.ExecuteNonQuery());
        }
    }

    public int ExecuteNonQuery(string strSPName, CommandType cmdType, SqlParameter[] arraParams)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandTimeout = 1000;
            command.CommandType = cmdType;
            command.CommandText = strSPName;
            command.Parameters.AddRange(arraParams);
            int flag = Convert.ToInt32(command.ExecuteNonQuery());
            command.Parameters.Clear();
            return flag;
        }
    }

    public string ExecuteScalar(string strSql)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandText = strSql;
            return Convert.ToString(command.ExecuteScalar());
        }
    }

    public int ExecuteScalar(string strSql, SqlParameter[] arrparams)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = strSql;
            command.CommandTimeout = 1000;
            command.Parameters.AddRange(arrparams);
            int flag = Convert.ToInt32(command.ExecuteScalar());
            command.Parameters.Clear();
            return flag;
        }
    }

    public DataTable ExecuteQuery(string strsql)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandTimeout = 1000;
            command.CommandText = strsql;
            SqlDataReader dr = command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(dr);
            return dt;
        }
    }

    public DataTable ExecuteQuery(string strSPName, CommandType cmdType, SqlParameter[] arraParams)
    {
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            SqlCommand command = connection.CreateCommand();
            command.CommandTimeout = 1000;
            command.CommandType = cmdType;
            command.CommandText = strSPName;
            command.Parameters.AddRange(arraParams);
            SqlDataReader dr = command.ExecuteReader();
            command.Parameters.Clear();
            DataTable dt = new DataTable();
            dt.Load(dr);
            return dt;
        }
    }
}
