<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="viewform.aspx.cs" Inherits="viewform" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentInfor" Runat="Server">
    <table style="width:100%">
        <tr>
            <td style="padding:5px; text-align:center">
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="Label2" Text="សូមជ្រើសរើស បញ្ចូលឯកសារ ឬ កែប្រែឯកសារ" Font-Names="NiDA Funan" Font-Size="18"> </asp:Label>
            </td>
        </tr>
        <tr>
            <td style="padding:5px; text-align:center">
                <asp:RadioButton runat="server" ID="rdAdd"  Text="បញ្ចូលឯកសារ" GroupName="rdJob" Font-Names="NiDA Sowanaphum" Font-Bold="True" Font-Size="16"  />
                &nbsp;&nbsp;&nbsp;&nbsp;
                <asp:RadioButton runat="server" ID="rdEdit"  Text="កែប្រែឯកសារ" GroupName="rdJob" Font-Names="NiDA Sowanaphum" Font-Bold="True" Font-Size="16" />
            </td>
        </tr>
    </table>
    <table style="width:100%; background-color:antiquewhite">
        <tr>
            <td colspan="2" >
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="Label3" Text="ព័ត៌មានឯកសារ" Font-Names="NiDA Sowanaphum" Font-Bold="True" Font-Size="16" > </asp:Label>
            </td>
        </tr>

        <tr>
            <td style="padding:5px; width:200px" >
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="lbl1" Text="ឯកសារភ្ជាប់" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
            </td>
            <td style="padding:5px; width:1000px">
                <asp:FileUpload runat="server" ID="FUpload" Font-Bold="True" Font-Size="14"></asp:FileUpload>
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="lblFUpload" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
            </td>
         </tr>

        <tr>
            <td style="padding:5px" >
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="Label15" Text="លេខឯកសារ" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
            </td>
            <td style="padding:5px" >
                <asp:TextBox runat="server" ID="txtFileNum" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" size="45"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label runat="server" ID="Label4" Text="ប្រភេទ" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
                &nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="drpDocTypeId" 
                    Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14pt" 
                    column="20" Width="250px" >
                    <asp:ListItem>ចូល</asp:ListItem>
                    <asp:ListItem>កែ</asp:ListItem>
                    <asp:ListItem>ផ្សែងៗ</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource runat="server" ID="SqlDataSource1"></asp:SqlDataSource>
              
            </td>

        </tr>
        <tr>
            <td style="padding:5px" >
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="Label29" Text="ចំណងជើងឯកសារ" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
            </td>
            <td style="padding:5px">
                <asp:TextBox runat="server" ID="txtFileTitle" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" size="102"></asp:TextBox>
            </td>
            </tr>
        <tr>
            <td style="padding:5px" >
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="Label42" Text="កំណត់ចំណាំ" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
            </td>
            <td style="padding:5px">
                <asp:TextBox runat="server" ID="txtFileNote" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" size="102"></asp:TextBox>
            </td>
         </tr>
        <tr>
           <td colspan="2" style="padding:5px;" >
               &nbsp;&nbsp;
               <asp:CheckBox ID="chkAgr" Text="សូមបញ្ជាក់ថាព័ត៌មានខាងលើត្រឹមត្រូវហើយ!" runat="server" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" OnCheckedChanged="chkAgr_CheckedChanged"  />
               &nbsp;&nbsp;&nbsp;&nbsp;
           <asp:Label runat="server" ID="lblBlank" BackColor="#990000" ForeColor="White" Font-Names="NiDA Sowanaphum" Font-Size="14pt" Font-Bold="True" Font-Italic="True"></asp:Label>
           </td>
       </tr>

        <tr>
           <td colspan="2" style="padding:5px; text-align:center;" >
               <asp:Button ID="btnAddNew" runat="server" Text="បញ្ចូល" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" width="150" OnClick="btnAddNew_Click"  />
               &nbsp;&nbsp;&nbsp;&nbsp;
               <asp:Button ID="btnUpdate" runat="server" Text="កែប្រែ" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" width="150" />
               &nbsp;&nbsp;&nbsp;&nbsp;
               <asp:Button ID="btnOpenFile" runat="server" Text="បើកមើល" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" width="150"  />
               &nbsp;&nbsp;&nbsp;&nbsp;
               <asp:Button ID="btnCancel" runat="server" Text="សម្អាត" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" width="150" />
           </td>
       </tr>
<%--Break--%>
        <tr>
           <td colspan="2" style="padding:5px; text-align:center; background-color:Background" >
            </td>
       </tr>
<%--Search--%>
        <tr>
            <td colspan="2" style="padding:5px; background-color:lightskyblue" >
                <hr />
                &nbsp;&nbsp;
                <asp:Label runat="server" ID="Label1" Text="ការស្វែងរក" Font-Names="NiDA Sowanaphum" Font-Size="16" Font-Bold="True"> </asp:Label>
            <br />
            &nbsp;&nbsp;
                <asp:Label Width="120px" runat="server" ID="Label5" Text="ប្រភេទស្វែងរក" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
                <asp:DropDownList runat="server" ID="drpSearchType" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" column="20" Width="180px">
                   <asp:ListItem Value="1">លេខឯកសារ</asp:ListItem>
                   <asp:ListItem Value="2">ឈ្មោះឯកសារ</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label Width="120px" runat="server" ID="lblSearch" Text="ឈ្មោះឯកសារ" Font-Names="NiDA Sowanaphum" Font-Size="14" Font-Bold="True"> </asp:Label>
                <asp:TextBox runat="server" ID="txtSearch" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" size="46" ></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <asp:Button ID="btnSearch" runat="server" Text="ស្វែងរក" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14" width="150" />
                <br /><hr />
            </td>
         </tr>
<%--End Search--%>
    </table>
<br />
<%--Search Result--%>
    <table style="width:100%;">
        <tr>
            <td colspan="2" style="padding:5px" >
<asp:GridView runat="server" ID="gridSearch" Font-Bold="True" Font-Names="NiDA Sowanaphum" Font-Size="14pt" CellPadding="4" ForeColor="#333333" BorderStyle="Solid" BorderWidth="1px" CellSpacing="4">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
        <asp:CommandField ShowSelectButton="True" />
    </Columns>
    <EditRowStyle BackColor="#999999" />
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#FF9966" Font-Bold="True" ForeColor="#0099CC" />
    <SortedAscendingCellStyle BackColor="#E9E7E2" />
    <SortedAscendingHeaderStyle BackColor="#506C8C" />
    <SortedDescendingCellStyle BackColor="#FFFDF8" />
    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
      </asp:GridView>
            </td>
        </tr>
    </table>
    <%--End Search Result--%>
<br />
</asp:Content>


