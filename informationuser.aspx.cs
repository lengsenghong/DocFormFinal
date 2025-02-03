using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class informationuser : Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUserData();  // Load all users when the page loads for the first time
        }
    }

    // Load all users in GridView
    private void LoadUserData()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT UserId, UName, FullName, Email FROM tblUsers";
            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            gvUsers.DataSource = reader;
            gvUsers.DataBind();
            conn.Close();
        }
    }

    // Create button click event
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string username = txtUserName.Text.Trim();
        string password = txtPassword.Text.Trim();
        string fullName = txtFullName.Text.Trim();
        string email = txtEmail.Text.Trim();

        if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email))
        {
            Response.Write("<script>alert('Please fill out all fields!');</script>");
            return;
        }

        string query = "INSERT INTO tblUsers (UName, Email, FullName, PW, Status) VALUES (@UName, @Email, @FullName, @PW, 'Active')";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UName", username);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@FullName", fullName);
            cmd.Parameters.AddWithValue("@PW", password);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("<script>alert('Account created successfully!');</script>");
            LoadUserData(); // Reload the user list
        }
    }

    // Handle Search Button Click
    protected void btnFind_Click(object sender, EventArgs e)
    {
        string userId = txtID.Text.Trim();
        string userName = txtUserName.Text.Trim();

        string query = "SELECT UserId, UName, FullName, Email, Status FROM tblUsers WHERE 1=1";

        if (!string.IsNullOrEmpty(userId))
        {
            query += " AND UserId = @UserId";
        }

        if (!string.IsNullOrEmpty(userName))
        {
            query += " AND UName LIKE @UserName";
        }

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);

            if (!string.IsNullOrEmpty(userId))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
            }

            if (!string.IsNullOrEmpty(userName))
            {
                cmd.Parameters.AddWithValue("@UserName", "%" + userName + "%");
            }

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                gvUsers.DataSource = reader;
                gvUsers.DataBind();
            }
            else
            {
                Response.Write("<script>alert('No results found!');</script>");
            }

            conn.Close();
        }
    }

    // Handle Edit Button Click
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        string userId = txtID.Text.Trim();
        string username = txtUserName.Text.Trim();
        string password = txtPassword.Text.Trim();
        string fullName = txtFullName.Text.Trim();
        string email = txtEmail.Text.Trim();

        if (string.IsNullOrEmpty(userId) || string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(fullName) || string.IsNullOrEmpty(email))
        {
            Response.Write("<script>alert('Please fill out all fields!');</script>");
            return;
        }

        string query = "UPDATE tblUsers SET UName = @UName, Email = @Email, FullName = @FullName, PW = @PW WHERE UserId = @UserId";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@UName", username);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@FullName", fullName);
            cmd.Parameters.AddWithValue("@PW", password);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("<script>alert('Account updated successfully!');</script>");
            LoadUserData(); // Reload the user list
        }
    }

    // Handle Delete Button Click
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string userId = txtID.Text.Trim();

        if (string.IsNullOrEmpty(userId))
        {
            Response.Write("<script>alert('Please enter a UserId to delete!');</script>");
            return;
        }

        string query = "DELETE FROM tblUsers WHERE UserId = @UserId";

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserId", userId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("<script>alert('User deleted successfully!');</script>");
            LoadUserData(); // Reload the user list
        }
    }

    // Handle GridView Row Command (for Edit, Delete)
    protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditUser")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvUsers.Rows[index];
            txtID.Text = row.Cells[0].Text; // UserId
            txtUserName.Text = row.Cells[1].Text; // UName
            txtFullName.Text = row.Cells[2].Text; // FullName
            txtEmail.Text = row.Cells[3].Text; // Email
        }
        else if (e.CommandName == "DeleteUser")
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gvUsers.Rows[index];
            string userId = row.Cells[0].Text;

            string query = "DELETE FROM tblUsers WHERE UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserId", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Write("<script>alert('User deleted successfully!');</script>");
                LoadUserData(); // Reload the user list
            }
        }
    }
}
