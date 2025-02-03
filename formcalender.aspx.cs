using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class formcalender : Page
{
    private string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDepartments();
            LoadDocumentTypes();
        }
    }

    // Load departments into dropdown
    private void LoadDepartments()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT DepID, DepName FROM tblDepartment";
            SqlCommand cmd = new SqlCommand(query, conn);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            drpOpeap.DataSource = reader;
            drpOpeap.DataTextField = "DepName";
            drpOpeap.DataValueField = "DepID";
            drpOpeap.DataBind();

            conn.Close();
        }

        drpOpeap.Items.Insert(0, new ListItem("ទាំងអស់", "0")); // Add "All" option
    }

    // Load document types into dropdown
    private void LoadDocumentTypes()
    {
        drpTypeDocument.Items.Clear();
        drpTypeDocument.Items.Add(new ListItem("ទាំងអស់", "All"));
        drpTypeDocument.Items.Add(new ListItem("សារ", "Letter"));
        drpTypeDocument.Items.Add(new ListItem("ឯកសារ", "Document"));
    }

    // Handle the search button click
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string searchType = drpTypetoSearch.SelectedValue;
        string department = drpOpeap.SelectedValue;
        string docType = drpTypeDocument.SelectedValue;
        string docName = txtNameDocument.Text.Trim();
        DateTime? startDate = cldStart.SelectedDate != DateTime.MinValue ? (DateTime?)cldStart.SelectedDate : null;
        DateTime? endDate = cldEnd.SelectedDate != DateTime.MinValue ? (DateTime?)cldEnd.SelectedDate : null;

        // Validate date range
        if (startDate.HasValue && endDate.HasValue && startDate > endDate)
        {
            Response.Write("<script>alert('ចាប់ពី ថ្ងៃទី ត្រូវតែតិចជាង ដល់ ថ្ងៃទី!');</script>");
            return;
        }

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM tblDocument WHERE 1=1";

            if (searchType == "FileNum")
                query += " AND FileNumber LIKE @SearchText";
            else if (searchType == "FileTitle")
                query += " AND FileName LIKE @SearchText";

            if (!string.IsNullOrEmpty(department) && department != "0")
                query += " AND DepID = @DepID";

            if (!string.IsNullOrEmpty(docType) && docType != "All")
                query += " AND DocTypeID = @DocType";

            if (startDate.HasValue)
                query += " AND DateIn >= @StartDate";

            if (endDate.HasValue)
                query += " AND DateIn <= @EndDate";

            SqlCommand cmd = new SqlCommand(query, conn);

            if (searchType == "FileNum" || searchType == "FileTitle")
                cmd.Parameters.AddWithValue("@SearchText", "%" + docName + "%");

            if (!string.IsNullOrEmpty(department) && department != "0")
                cmd.Parameters.AddWithValue("@DepID", department);

            if (!string.IsNullOrEmpty(docType) && docType != "All")
                cmd.Parameters.AddWithValue("@DocType", docType);

            if (startDate.HasValue)
                cmd.Parameters.AddWithValue("@StartDate", startDate.Value);

            if (endDate.HasValue)
                cmd.Parameters.AddWithValue("@EndDate", endDate.Value);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                gvDocuments.DataSource = reader;
                gvDocuments.DataBind();
            }
            else
            {
                Response.Write("<script>alert('មិនមានលទ្ធផល!');</script>");
            }

            conn.Close();
        }
    }

    // Handle the view button click
    protected void btnSee_Click(object sender, EventArgs e)
    {
        Response.Write("<script>alert('បើកមើលឯកសារ!');</script>");
    }

    // Handle the clear button click
    protected void btnClear_Click(object sender, EventArgs e)
    {
        drpTypetoSearch.SelectedIndex = 0;
        drpOpeap.SelectedIndex = 0;
        drpTypeDocument.SelectedIndex = 0;
        txtNameDocument.Text = string.Empty;
        cldStart.SelectedDates.Clear();
        cldEnd.SelectedDates.Clear();

        Response.Write("<script>alert('សម្អាតទិន្នន័យ!');</script>");
    }
}
