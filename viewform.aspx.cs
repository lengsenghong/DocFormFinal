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

public partial class viewform : System.Web.UI.Page
{
    private string connectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Retrieve connection string from web.config
        connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        if (!IsPostBack)
        {
            LoadDocumentTypes();
            LoadSearchResults();
        }
    }

    // Load document types into dropdown
    private void LoadDocumentTypes()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT DocTypeId, DocType FROM tblDocType";
            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            drpDocTypeId.DataSource = reader;
            drpDocTypeId.DataTextField = "DocType";
            drpDocTypeId.DataValueField = "DocTypeId";
            drpDocTypeId.DataBind();
            conn.Close();
        }

        // Add default option
        drpDocTypeId.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Document Type", "0"));
    }

    // Load search results into GridView
    private void LoadSearchResults()
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "SELECT * FROM tblDocument";
            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gridSearch.DataSource = dt;
            gridSearch.DataBind();
        }
    }

    // Handle checkbox event
    protected void chkAgr_CheckedChanged(object sender, EventArgs e)
    {
        lblBlank.Text = chkAgr.Checked ? "ការបញ្ជាក់ត្រឹមត្រូវ!" : "សូមបញ្ជាក់ថាព័ត៌មានត្រឹមត្រូវ!";
    }

    // Add new document
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        if (!chkAgr.Checked)
        {
            lblBlank.Text = "សូមបញ្ជាក់ថាព័ត៌មានត្រឹមត្រូវ!";
            return;
        }

        string fileName = string.Empty;

        // Handle file upload
        if (FUpload.HasFile)
        {
            fileName = Path.GetFileName(FUpload.FileName);
            string filePath = Server.MapPath("~/UploadedFiles/") + fileName;
            FUpload.SaveAs(filePath);
        }

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO tblDocument (FileNumber, FileName, FileNote, DocTypeId, FileUrl, DateIn) " +
                           "VALUES (@FileNumber, @FileName, @FileNote, @DocTypeId, @FileUrl, GETDATE())";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@FileNumber", txtFileNum.Text.Trim());
            cmd.Parameters.AddWithValue("@FileName", txtFileTitle.Text.Trim());
            cmd.Parameters.AddWithValue("@FileNote", txtFileNote.Text.Trim());
            cmd.Parameters.AddWithValue("@DocTypeId", drpDocTypeId.SelectedValue);
            cmd.Parameters.AddWithValue("@FileUrl", fileName);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        lblBlank.Text = "ឯកសារត្រូវបានបញ្ចូលដោយជោគជ័យ!";
        ClearForm();
        LoadSearchResults();
    }

    // Search documents
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string query = string.Empty;

        if (drpSearchType.SelectedValue == "1") // Search by File Number
        {
            query = "SELECT * FROM tblDocument WHERE FileNumber LIKE @SearchText";
        }
        else if (drpSearchType.SelectedValue == "2") // Search by File Name
        {
            query = "SELECT * FROM tblDocument WHERE FileName LIKE @SearchText";
        }

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@SearchText", "%" + txtSearch.Text.Trim() + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gridSearch.DataSource = dt;
            gridSearch.DataBind();
        }
    }

    // Clear form fields
    private void ClearForm()
    {
        txtFileNum.Text = string.Empty;
        txtFileTitle.Text = string.Empty;
        txtFileNote.Text = string.Empty;
        drpDocTypeId.SelectedIndex = 0;
        lblBlank.Text = string.Empty;
    }

    // Handle update document
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (!chkAgr.Checked)
        {
            lblBlank.Text = "សូមបញ្ចាក់ថាព័ត៌មានត្រឹមត្រូវ!";
            return;
        }

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "UPDATE tblDocument SET FileName = @FileName, FileNote = @FileNote, DocTypeId = @DocTypeId " +
                           "WHERE FileNumber = @FileNumber";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@FileNumber", txtFileNum.Text.Trim());
            cmd.Parameters.AddWithValue("@FileName", txtFileTitle.Text.Trim());
            cmd.Parameters.AddWithValue("@FileNote", txtFileNote.Text.Trim());
            cmd.Parameters.AddWithValue("@DocTypeId", drpDocTypeId.SelectedValue);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        lblBlank.Text = "ឯកសារត្រូវបានកែប្រែដោយជោគជ័យ!";
        ClearForm();
        LoadSearchResults();
    }

    // Cancel action
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearForm();
    }
}
