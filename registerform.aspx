<%@ Page Title="Register" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="registerform.aspx.cs" Inherits="registerform" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .container {
            font-family: 'NiDA Sowanaphum', sans-serif;
            background-color: antiquewhite;
            padding: 30px;
            width: 50%;
            margin: 0 auto;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .container-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: saddlebrown;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            display: inline-block;
            width: 150px;
            text-align: right;
            font-weight: bold;
            font-size: 14px;
            color: saddlebrown;
        }

        .form-input {
            width: 300px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .button-group {
            text-align: center;
            margin-top: 20px;
        }

        .btn {
            background-color: saddlebrown;
            color: white;
            padding: 10px 20px;
            margin: 0 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        .btn:hover {
            background-color: #814c27;
        }

        .message {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
            font-weight: bold;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentInfor" Runat="Server">
    <div class="container">
        <h2 class="container-title">ចុះឈ្មោះ</h2>
        <div class="form-group">
            <label class="form-label" for="txtUsername">ឈ្មោះអ្នកប្រើ:</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" />
        </div>
        <div class="form-group">
            <label class="form-label" for="txtEmail">អ៊ីមែល:</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" />
        </div>
        <div class="form-group">
            <label class="form-label" for="txtFullName">ឈ្មោះពេញ:</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" />
        </div>
        <div class="form-group">
            <label class="form-label" for="txtPassword">លេខសម្ងាត់:</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" />
        </div>
        <div class="button-group">
            <asp:Button ID="btnRegister" runat="server" Text="ចុះឈ្មោះ" CssClass="btn" OnClick="btnRegister_Click"/>
            <asp:Button ID="btnCancelRegister" runat="server" Text="សម្អាត" CssClass="btn" OnClick="btnCancelRegister_Click"/>
        </div>
        <asp:Label ID="lblMessage" runat="server" CssClass="message" />
    </div>
</asp:Content>
