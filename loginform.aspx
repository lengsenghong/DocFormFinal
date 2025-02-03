<%@ Page Title="Login Form" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="loginform.aspx.cs" Inherits="loginform" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>Login Form</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="contentInfor" Runat="Server">
    <table style="width:100%; background-color:antiquewhite;">
        <tr>
            <td colspan="2" style="text-align:center; padding:10px;">
                <asp:Label ID="lblTitle" runat="server" Text="ទម្រង់ចូលប្រព័ន្ធ" Font-Names="NiDA Funan" Font-Size="18pt" Font-Bold="True"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="padding:10px; text-align:right; width:30%;">
                <asp:Label ID="lblUsername" runat="server" Text="ឈ្មោះអ្នកប្រើ:" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"></asp:Label>
            </td>
            <td style="padding:10px;">
                <asp:TextBox ID="txtUsername" runat="server" Font-Names="NiDA Sowanaphum" Font-Size="14" style="width:60%;"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="padding:10px; text-align:right;">
                <asp:Label ID="lblPassword" runat="server" Text="លេខសម្ងាត់:" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"></asp:Label>
            </td>
            <td style="padding:10px;">
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Font-Names="NiDA Sowanaphum" Font-Size="14" style="width:60%;"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center; padding:10px;">
                <asp:Button ID="btnLogin" runat="server" Text="ចូលប្រព័ន្ធ" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True" style="background-color:#5cb85c; color:white; padding:10px 20px;" OnClick="btnLogin_Click" />
                <asp:Button ID="btnCancelLogin" runat="server" Text="សម្អាត" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True" style="background-color:#d9534f; color:white; padding:10px 20px;" OnClick="btnCancelLogin_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
