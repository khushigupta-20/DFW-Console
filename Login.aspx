<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('images/login_bg2.jpg'); 
            background-size: cover; 
            background-position: center; 
            background-repeat: no-repeat; 
        }
        .login-container {
            background-color: rgba(0, 0, 0, 0.3); 
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        .login-container h1 {
            color: #256F93;
            transition: color 0.3s ease-in-out;
            margin-bottom: 20px;
        }
        .login-container h1.active {
            color: #ffb6c1; 
        }
        .login-container input[type="text"], 
        .login-container input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .login-container button,
        .login-container input[type="submit"] {
            background-color: #063852; 
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
            width: 100%;
        }
        .login-container button:hover,
        .login-container input[type="submit"]:hover {
            background-color: #ff9aa2; 
        }
        .login-container a {
            color: #ffb6c1;
            text-decoration: none;
            display: block;
            margin-top: 20px;
        }
        .login-container a:hover {
            text-decoration: underline;
        }
        .login-container .message {
            color: skyblue;
            font-size: 0.7em; 
            margin-top: 10px;
        }
    </style>
    <script>
        function toggleTitleColor() {
            var username = document.getElementById('txtUsername').value;
            var title = document.getElementById('loginTitle');
            if (username.length > 0) {
                title.classList.add('active');6
            } else {
                title.classList.remove('active');
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h1 id="loginTitle">Login</h1>
            <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" oninput="toggleTitleColor()"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="login-button" OnClick="btnLogin_Click" />
            <a href="Signup.aspx">Don't have an account? Sign up here</a>
            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>
</body>
</html>
