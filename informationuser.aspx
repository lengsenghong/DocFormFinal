<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="informationuser.aspx.cs" Inherits="informationuser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* Add the CSS code here */
        /* Font and Layout Settings */
body {
    font-family: 'NiDA Sowanaphum', sans-serif;
    background-color: antiquewhite;
}

/* Container */
.container {
    background-color: #f5f5f5;
    padding: 20px;
    border-radius: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

/* Title */
.container-title {
    font-size: 24px;
    font-weight: bold;
    color: #4e4e4e;
    text-align: center;
    margin-bottom: 20px;
}

/* Button Container */
.button-container {
    text-align: center;
    margin-top: 20px;
}

/* Buttons */
.btn {
    padding: 10px 20px;
    margin: 5px;
    font-size: 16px;
    font-weight: bold;
    color: white;
    background-color: #5cb85c;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease, box-shadow 0.3s ease;
}

/* Hover Effect for Buttons */
.btn:hover {
    background-color: #4cae4c;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

/* Edit Button */
.btn-edit {
    background-color: #f0ad4e;
}

.btn-edit:hover {
    background-color: #ec971f;
}

/* Delete Button */
.btn-delete {
    background-color: #d9534f;
}

.btn-delete:hover {
    background-color: #c9302c;
}

/* Form Field Styles */
.form-group {
    margin-bottom: 15px;
}

.form-group label {
    font-weight: bold;
    color: #333;
    display: inline-block;
    width: 150px;
}

/* Input Fields */
input[type="text"], input[type="password"], input[type="email"], select, textarea {
    padding: 8px;
    font-size: 14px;
    width: 50%;
    margin-bottom: 10px;
}

/* GridView Styles */
.gridview {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

.gridview th, .gridview td {
    padding: 10px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.gridview th {
    background-color: #5cb85c;
    color: white;
}

.gridview tr:hover {
    background-color: #f1f1f1;
}

/* Responsive Design */
@media screen and (max-width: 768px) {
    .form-group {
        flex-direction: column;
    }

    .form-group label,
    .form-group input,
    .form-group select,
    .form-group textarea {
        flex: 1 1 100%;
        width: 100%;
    }

    .button-container .btn {
        font-size: 12px;
        padding: 8px 15px;
    }
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentInfor" Runat="Server">
    <div class="container">
        <h2 class="container-title">ព័ត៌មានគណនីប្រើប្រាស់</h2>
        
        <div class="form-group">
            <label>អត្តលេខ:</label>
            <asp:TextBox ID="txtID" runat="server" style="width: 50%;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>ឈ្មោះអ្នកប្រើ:</label>
            <asp:TextBox ID="txtUserName" runat="server" style="width: 50%;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>ឈ្មោះពេញ:</label>
            <asp:TextBox ID="txtFullName" runat="server" style="width: 50%;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>អ៊ីមែល:</label>
            <asp:TextBox ID="txtEmail" runat="server" style="width: 50%;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>គណនីចូល:</label>
            <asp:TextBox ID="txtlogin" runat="server" style="width: 50%;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>លេខសម្ងាត់:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" style="width: 50%;"></asp:TextBox>
        </div>

        <div class="form-group">
            <label>អង្គភាព:</label>
            <asp:DropDownList ID="drpPart" runat="server" style="width: 52%;">
                <asp:ListItem Value="ទាំងអស់" Text="ទាំងអស់"></asp:ListItem>
                <asp:ListItem Value="ផ្សេងៗ" Text="ផ្សេងៗ"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-group">
            <label>ដំណើរការ:</label>
            <asp:DropDownList ID="drpRun" runat="server" style="width: 52%;">
                <asp:ListItem Value="ដំណើរការ" Text="ដំណើរការ"></asp:ListItem>
                <asp:ListItem Value="ផ្សេងៗ" Text="ផ្សេងៗ"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="button-container">
            <asp:Button ID="btnAdd" runat="server" Text="បង្កើត" CssClass="btn" OnClick="btnAdd_Click" />
            <asp:Button ID="btnFind" runat="server" Text="ស្វែងរក" CssClass="btn btn-edit" OnClick="btnFind_Click"/>
            <asp:Button ID="btnEdit" runat="server" Text="កែប្រែ" CssClass="btn btn-edit" OnClick="btnEdit_Click" />
            <asp:Button ID="btnDelete" runat="server" Text="សម្អាត" CssClass="btn btn-delete" OnClick="btnDelete_Click" />
        </div>

        <!-- GridView to display the user information -->
        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" OnRowCommand="gvUsers_RowCommand" CssClass="gridview" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="#333333" GridLines="None">
            <Columns>
                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                        <asp:Button runat="server" CommandName="EditUser" Text="Edit" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-edit" />
                        <asp:Button runat="server" CommandName="DeleteUser" Text="Delete" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-delete" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="UserId" HeaderText="UserId" SortExpression="UserId" />
                <asp:BoundField DataField="UName" HeaderText="Username" SortExpression="UName" />
                <asp:BoundField DataField="FullName" HeaderText="FullName" SortExpression="FullName" />
                <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
