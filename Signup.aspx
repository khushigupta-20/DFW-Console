<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('images/signup-bg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            color: #f0f0f0;
        }
        .signup-container {
            background-color: rgba(0, 0, 0, 0.4);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            width: 300px;
            text-align: center;
            color: #f0f0f0;
        }
        .signup-container h1 {
            color: #7D312E;
            transition: color 0.3s ease-in-out;
            margin-bottom: 20px;
        }
        .signup-container h1.active {
            color: #4A6F73;
        }
        .signup-container input[type="text"],
        .signup-container input[type="password"],
        .signup-container input[type="tel"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #333;
            border-radius: 5px;
            background-color: #333;
            color: #81C3C9;
        }
        .signup-container button,
        .signup-container input[type="submit"] {
            background-color: #7D312E;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
            width: 100%;
            margin-top: 20px;
        }
        .signup-container button:hover,
        .signup-container input[type="submit"]:hover {
            background-color: #4A6F73;
        }
        .signup-container a {
            color: #4A6F73;
            text-decoration: none;
            display: block;
            margin-top: 20px;
        }
        .signup-container a:hover {
            text-decoration: underline;
        }
        .signup-container .message {
            font-size: 0.9em;
            margin-top: 10px;
        }
    </style>
    <!-- Include SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <!-- Include Toastr (if you decide to use it) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script>
        function toggleTitleColor() {
            var username = document.getElementById('<%= txtUserId.ClientID %>').value;
            var title = document.getElementById('signupTitle');
            if (username.length > 0) {
                title.classList.add('active');
            } else {
                title.classList.remove('active');
            }
        }

        // Client-side validation
        function validateForm() {
            var userId = document.getElementById('<%= txtUserId.ClientID %>').value.trim();
            var name = document.getElementById('<%= txtName.ClientID %>').value.trim();
            var mobile = document.getElementById('<%= txtMobile.ClientID %>').value.trim();
            var password = document.getElementById('<%= txtPassword.ClientID %>').value.trim();
            var confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>').value.trim();

            if (!userId || !name || !mobile || !password || !confirmPassword) {
                Swal.fire('Error', 'All fields are required.', 'error');
                return false; // Prevent form submission
            }

            if (password !== confirmPassword) {
                Swal.fire('Error', 'Passwords do not match.', 'error');
                return false; // Prevent form submission
            }

            // If everything is okay, allow form submission
            return true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" onsubmit="return validateForm();">
        <div class="signup-container">
            <h1 id="signupTitle">Sign Up</h1>
            <asp:TextBox ID="txtUserId" runat="server" placeholder="User ID" oninput="toggleTitleColor()"></asp:TextBox>
            <asp:TextBox ID="txtName" runat="server" placeholder="Name"></asp:TextBox>
            <asp:TextBox ID="txtMobile" runat="server" placeholder="Mobile" MaxLength="10"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" ForeColor="Red"></asp:CompareValidator>
            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="signup-button" OnClick="BtnSignup_Click" />
            <a href="Login.aspx">Already have an account? Login here</a>
            <asp:Label ID="lblMessage" runat="server" CssClass="message" />
        </div>
    </form>
</body>
</html>
