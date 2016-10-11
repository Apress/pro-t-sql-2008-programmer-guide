<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 741px; font-family: Arial; font-size: large;">
    
        AdventureWorks Product Viewer<br />
        <br />
    <asp:DropDownList ID="ProductDropDown" runat="server" 
        AutoPostBack="True" Height="30px" 
        onselectedindexchanged="ProductDropDownList_SelectedIndexChanged" 
            Width="241px">
    </asp:DropDownList>
        <br />
        <br />
    <asp:Image ID="ProductImage" runat="server" Height="149px" 
    Width="240px" BorderStyle="Solid" BorderWidth="1px" />
        <br />
        <asp:Table ID="Table1" runat="server" BorderStyle="Solid" BorderWidth="1px" 
            Width="358px">
            <asp:TableRow runat="server" BorderStyle="Solid">
                <asp:TableCell runat="server">Class</asp:TableCell>
                <asp:TableCell runat="server"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" BorderStyle="Solid">
                <asp:TableCell runat="server">Color</asp:TableCell>
                <asp:TableCell runat="server"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" BorderStyle="Solid">
                <asp:TableCell runat="server">Size</asp:TableCell>
                <asp:TableCell runat="server"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" BorderStyle="Solid">
                <asp:TableCell runat="server">Weight</asp:TableCell>
                <asp:TableCell runat="server"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" BorderStyle="Solid">
                <asp:TableCell runat="server">List Price</asp:TableCell>
                <asp:TableCell runat="server"></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow runat="server" BorderStyle="Solid">
                <asp:TableCell runat="server">Product Number</asp:TableCell>
                <asp:TableCell runat="server"></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    
    </div>
    </form>
</body>
</html>
