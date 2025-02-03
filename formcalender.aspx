<%@ Page Title="Calendar Form" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="formcalender.aspx.cs" Inherits="formcalender" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Calendar Form</title>
    <style>
        /* Styles for Calendar */
        .container {
            font-family: 'NiDA Sowanaphum', sans-serif;
            background-color: antiquewhite;
            padding: 20px;
            border-radius: 10px;
        }
        .header {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .row {
            margin-bottom: 10px;
        }
        .label {
            display: inline-block;
            width: 150px;
            font-weight: bold;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .button {
            padding: 10px 20px;
            margin: 0 5px;
            background-color: saddlebrown;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .button:hover {
            background-color: #814c27;
        }

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentInfor" Runat="Server">
    <div class="container">
        <div class="header">ព័ត៌មានឯកសារស្វែងរក</div>
        <div class="row">
            <span class="label">ប្រភេទស្វែងរក:</span>
            <asp:DropDownList ID="drpTypetoSearch" runat="server" Width="300px">
                <asp:ListItem Text="លេខឯកសារ" Value="FileNum" />
                <asp:ListItem Text="ឈ្មោះឯកសារ" Value="FileTitle" />
            </asp:DropDownList>
        </div>
        <div class="row">
            <span class="label">អង្គភាព:</span>
            <asp:DropDownList ID="drpOpeap" runat="server" Width="300px"></asp:DropDownList>
        </div>
        <div class="row">
            <span class="label">ប្រភេទឯកសារ:</span>
            <asp:DropDownList ID="drpTypeDocument" runat="server" Width="300px">
                <asp:ListItem Text="ទាំងអស់" Value="All" />
                <asp:ListItem Text="សារ" Value="Letter" />
                <asp:ListItem Text="ឯកសារ" Value="Document" />
            </asp:DropDownList>
        </div>
        <div class="row">
            <span class="label">ឈ្មោះឯកសារ:</span>
            <asp:TextBox ID="txtNameDocument" runat="server" Width="300px"></asp:TextBox>
        </div>
        <div class="row">
            <span class="label">ចាប់ពីថ្ងៃទី:</span>
            <asp:Calendar ID="cldStart" runat="server"></asp:Calendar>
            <span class="label">ដល់ថ្ងៃទី:</span>
            <asp:Calendar ID="cldEnd" runat="server"></asp:Calendar>
        </div>
        <div class="button-group">
            <asp:Button ID="btnSearch" runat="server" Text="ស្វែងរក" CssClass="button" OnClick="btnSearch_Click" />
            <asp:Button ID="btnSee" runat="server" Text="បើកមើល" CssClass="button" OnClick="btnSee_Click" />
            <asp:Button ID="btnClear" runat="server" Text="សម្អាត" CssClass="button" OnClick="btnClear_Click" />
        </div>

<asp:GridView ID="gvDocuments" runat="server" AutoGenerateColumns="True" CssClass="gridview" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" ForeColor="#333333" GridLines="None">
    <Columns>
        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:Button runat="server" CommandName="ViewDocument" Text="View" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-edit" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="FileNumber" HeaderText="FileNumber" SortExpression="FileNumber" />
        <asp:BoundField DataField="FileName" HeaderText="FileName" SortExpression="FileName" />
    </Columns>
</asp:GridView>


    </div>
</asp:Content>
