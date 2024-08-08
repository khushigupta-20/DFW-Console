<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet" />
    <link href="styles.css" rel="stylesheet" /> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="row">
                <nav class="col-md-2 d-none d-md-block bg-light sidebar">
                    <div class="sidebar-sticky">
                        <ul class="nav flex-column">
                            <li class="nav-item">
                                <a class="nav-link active" href="#">
                                    <i class="fas fa-tachometer-alt"></i>
                                    Dashboard
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">
                                    <i class="fas fa-users"></i>
                                    Customers
                                </a>
                            </li>
                        </ul>
                    </div>
                </nav>

                <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">Welcome to your Dashboard</h1>
                    </div>

                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <!-- Textbox for Name -->
                                <div class="form-group">
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Enter your name"></asp:TextBox>
                                </div>
                                
                                <!-- Textbox for Country -->
                                <div class="form-group">
                                    <asp:TextBox ID="txtCountry" runat="server" CssClass="form-control" Placeholder="Enter your country"></asp:TextBox>
                                </div>
                                
                                <!-- FileUpload control for Photo -->
                                <div class="form-group">
                                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                                </div>
                                
                                <!-- Submit Button -->
                                <div class="form-group">
                                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_Click" />
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" 
                                    OnRowCommand="gvCustomers_RowCommand" 
                                    OnRowEditing="gvCustomers_RowEditing" 
                                    OnRowUpdating="gvCustomers_RowUpdating" 
                                    OnRowCancelingEdit="gvCustomers_RowCancelingEdit">
                                    <Columns>
                                        <asp:BoundField DataField="CustomerId" HeaderText="Customer ID" ReadOnly="True" />
                                        <asp:BoundField DataField="Name" HeaderText="Name" />
                                        <asp:BoundField DataField="Country" HeaderText="Country" />
                                        <asp:TemplateField HeaderText="Actions">
                                            <ItemTemplate>
                                                <asp:Button ID="btnDelete" runat="server" CommandName="DeleteCustomer" CommandArgument='<%# Eval("CustomerId") %>' Text="Delete" CssClass="btn btn-danger delete-btn" />
                                                <asp:Button ID="btnDownload" runat="server" CommandName="DownloadPhoto" CommandArgument='<%# Eval("CustomerId") %>' Text="Download Photo" CssClass="btn btn-info" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"></asp:TextBox>
                                                <asp:TextBox ID="txtEditCountry" runat="server" Text='<%# Bind("Country") %>' CssClass="form-control"></asp:TextBox>
                                                <asp:Button ID="btnUpdate" runat="server" CommandName="UpdateCustomer" CommandArgument='<%# Eval("CustomerId") %>' Text="Update" CssClass="btn btn-success" />
                                                <asp:Button ID="btnCancel" runat="server" CommandName="CancelEdit" Text="Cancel" CssClass="btn btn-secondary" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </form>

    <script>
        $(document).ready(function () {
            toastr.success('Welcome to the User Dashboard!');
            $(document).on('click', '.delete-btn', function () {
                var customerId = $(this).data('id');
                swal({
                    title: "Are you sure?",
                    text: "Once deleted, you will not be able to recover this customer!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                    .then((willDelete) => {
                        if (willDelete) {
                            $.ajax({
                                url: 'Default2.aspx/DeleteCustomer',
                                type: 'POST',
                                data: { id: customerId },
                                success: function (response) {
                                    toastr.success('Customer deleted successfully!');
                                },
                                error: function (error) {
                                    toastr.error('Error deleting customer.');
                                }
                            });
                        }
                    });
            });
        });
    </script>
</body>
</html>
