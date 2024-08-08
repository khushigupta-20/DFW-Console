using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void BtnSignup_Click(object sender, EventArgs e)
    {
        string userId = txtUserId.Text.Trim();
        string name = txtName.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string password = txtPassword.Text;
        string confirmPassword = txtConfirmPassword.Text;

        // Validate the form inputs
        if (!ValidateInputs(userId, name, mobile, password, confirmPassword))
        {
            return; // Validation failed, so return without proceeding
        }

        // Check if the user already exists in the database
        UserDAL userDAL = new UserDAL();
        DataTable existingUser = userDAL.GetUser(userId, password);

        if (existingUser.Rows.Count > 0)
        {
            Message.ShowSweetAlert(this, "User ID already exists. Please choose another.");
            return;
        }

        // Add the new user to the database
        bool isUserAdded = userDAL.AddUser(userId, name, mobile, password);

        if (isUserAdded)
        {
            // Display success message and redirect to login page
            Message.ShowSweetAlert(this, "Account created successfully! You can now log in.");
            ScriptManager.RegisterStartupScript(this, GetType(), "redirectScript", "setTimeout(function() { window.location.replace('Login.aspx'); }, 1000);", true);

            // Clear form fields after successful signup
            ClearFormFields();
        }
        else
        {
            Message.ShowSweetAlert(this, "Failed to create account. Please try again.");
        }
    }

    // Method to validate form inputs
    private bool ValidateInputs(string userId, string name, string mobile, string password, string confirmPassword)
    {
        if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(name) || string.IsNullOrEmpty(mobile) ||
            string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
        {
            Message.ShowSweetAlert(this, "All fields are required.");
            return false;
        }

        if (password != confirmPassword)
        {
            Message.ShowSweetAlert(this, "Passwords do not match.");
            return false;
        }

        // Additional validation logic can be added here if needed

        return true;
    }

    // Method to clear form fields after signup
    private void ClearFormFields()
    {
        txtUserId.Text = string.Empty;
        txtName.Text = string.Empty;
        txtMobile.Text = string.Empty;
        txtPassword.Text = string.Empty;
        txtConfirmPassword.Text = string.Empty;
    }
}
