using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

public partial class loginform : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblTitle.ForeColor = System.Drawing.Color.Black;
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string username = txtUsername.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
        {
            lblTitle.Text = "សូមបញ្ចូលឈ្មោះអ្នកប្រើ និង លេខសម្ងាត់!";
            lblTitle.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            // Query to check if the username and password match
            string query = "SELECT COUNT(1) FROM tblUsers WHERE UName=@Username AND PW=@Password"; // Changed 'Password' to 'PW'

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", username);
            cmd.Parameters.AddWithValue("@Password", password);

            conn.Open();
            int count = Convert.ToInt32(cmd.ExecuteScalar());
            conn.Close();

            if (count == 1)
            {
                // Set session and redirect on successful login
                Session["Username"] = username;
                Response.Redirect("viewform.aspx");
            }
            else
            {
                lblTitle.Text = "ឈ្មោះអ្នកប្រើ ឬ លេខសម្ងាត់ មិនត្រឹមត្រូវទេ!";
                lblTitle.ForeColor = System.Drawing.Color.Red;
            }
        }
    }

    protected void btnCancelLogin_Click(object sender, EventArgs e)
    {
        txtUsername.Text = string.Empty;
        txtPassword.Text = string.Empty;
        lblTitle.Text = "សូមបញ្ចូលឈ្មោះអ្នកប្រើ និង លេខសម្ងាត់!";
        lblTitle.ForeColor = System.Drawing.Color.Black;
    }
}

