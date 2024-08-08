<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
      
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div id="dvGrid" style="padding: 10px; width: 450px">
           
                    <asp:GridView ID="GridView1"  runat="server" AutoGenerateColumns="false" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowUpdating="GridView1_RowUpdating"
                        DataKeyNames="CustomerId" PageSize = "3" AllowPaging ="true" OnPageIndexChanging = "OnPaging" EmptyDataText="No records has been added."
                        Width="450">
                        <Columns>
                            <asp:TemplateField HeaderText="Name" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Country" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCountry" runat="server" Text='<%# Eval("Country") %>' Width="140"></asp:TextBox>
                                </EditItemTemplate>
                           </asp:TemplateField>
                            <asp:TemplateField ItemStyle-HorizontalAlign="Center">  
                    <ItemTemplate>  
                        <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="DownloadFile"  
                            CommandArgument='<%# Eval("CustomerId") %>'></asp:LinkButton>  
                    </ItemTemplate> 
                                </asp:TemplateField>
                            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true"
                                ItemStyle-Width="150" />
                                
                        </Columns>
                    </asp:GridView>
                    <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                        <tr>
                            <td style="width: 150px">
                                Name:<br />
                                <asp:TextBox ID="txtName" runat="server" Width="140" />
                                <asp:RequiredFieldValidator ID="user" runat="server" ValidationGroup="add" ControlToValidate="txtName"   
ErrorMessage="Please enter a user name" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td style="width: 150px">
                                Country:<br />
                                <asp:TextBox ID="txtCountry" runat="server" Width="140" />
                                <asp:RequiredFieldValidator ID="country" runat="server" ValidationGroup="add" ControlToValidate="txtName"   
ErrorMessage="Please enter a country name" ForeColor="Red"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:FileUpload ID="FileUpload1" runat="server" />

                            </td>
                            <td style="width: 150px">
                                <asp:Button ID="btnAdd" runat="server"  ValidationGroup="add" Text="Add" OnClick="Insert" />
                            </td>
                        </tr>
                    </table>
                
            </div>
         
    </form>
</body>
</html>
