using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class registerform : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Text = "";
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        // Capture form data
        string username = txtUsername.Text.Trim();
        string email = txtEmail.Text.Trim();
        string fullName = txtFullName.Text.Trim();
        string password = txtPassword.Text.Trim();

        // Validate input fields
        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(password))
        {
            lblMessage.Text = "សូមបំពេញទិន្នន័យទាំងអស់!";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Establish connection to the database
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            conn.Open();

            // Check if the username already exists
            string checkQuery = "SELECT COUNT(1) FROM tblUsers WHERE UName = @Username";
            SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
            checkCmd.Parameters.AddWithValue("@Username", username);

            int userExists = Convert.ToInt32(checkCmd.ExecuteScalar());
            if (userExists > 0)
            {
                lblMessage.Text = "ឈ្មោះអ្នកប្រើនេះមានរួចហើយ!";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Insert the new user into the database
            string insertQuery = "INSERT INTO tblUsers (UName, Email, FullName, PW, Status, CreatedDate) " +
                                 "VALUES (@Username, @Email, @FullName, @Password, 'Active', GETDATE())";
            SqlCommand cmd = new SqlCommand(insertQuery, conn);

            cmd.Parameters.AddWithValue("@Username", username);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@FullName", fullName);
            cmd.Parameters.AddWithValue("@Password", password);

            cmd.ExecuteNonQuery();

            lblMessage.Text = "ចុះឈ្មោះបានជោគជ័យ!";
            lblMessage.ForeColor = System.Drawing.Color.Green;

            // Clear the form fields
            txtUsername.Text = "";
            txtEmail.Text = "";
            txtFullName.Text = "";
            txtPassword.Text = "";

            // Redirect to the login page after successful registration
            Response.Redirect("loginform.aspx");
        }
    }

    protected void btnCancelRegister_Click(object sender, EventArgs e)
    {
        // Clear the form fields
        txtUsername.Text = "";
        txtEmail.Text = "";
        txtFullName.Text = "";
        txtPassword.Text = "";
    }
}
