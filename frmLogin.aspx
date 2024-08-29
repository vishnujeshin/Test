<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmLogin.aspx.cs" Inherits="AssetMobileApplication.frmLogin" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <title>Sign In | Asset </title>
    <!-- Favicon-->
    <link rel="icon" href="images/favicon.jpg" type="image/x-icon" />

    <link href="font/css/font.css" rel="stylesheet" />
    <link href="font/css/icon.css" rel="stylesheet" />

    <!-- Bootstrap Core Css -->
    <link href="plugins/bootstrap/css/bootstrap.css" rel="stylesheet" />

    <!-- Waves Effect Css -->
    <link href="plugins/node-waves/waves.css" rel="stylesheet" />

    <!-- Animation Css -->
    <link href="plugins/animate-css/animate.css" rel="stylesheet" />

    <!-- Custom Css -->
    <link href="css/style.css" rel="stylesheet" />

    <script type="text/javascript">
        function fncLoginEnterFocus(event,data) {
            var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
            if (event.keyCode == 13) {
                if (data == 'UserName') {
                    if ($('#<%=txtUserName.ClientID %>').val() != '') {
                        $('#<%=txtPassword.ClientID %>').select().focus();
                    }
                    else {
                        ShowToastError('Please Enter Your User Name...');
                        $('#<%=txtUserName.ClientID %>').select().focus();
                    }
                }
                if (data == 'Password') {
                    if ($('#<%=txtPassword.ClientID %>').val() != '') {
                        document.getElementById("<%=btnSignIn.ClientID %>").click();
                    }
                    else {
                        ShowToastError('Please Enter Your Password...');
                        $('#<%=txtPassword.ClientID %>').select().focus();
                    }
                }
                
            event.preventDefault();
        }
    }
    </script>
</head>

<body class="login-page" style="">
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="logo">
            </div>
            <div class="card">
                <div class="body">
                    <form id="sign_in" method="POST">
                        <asp:Label ID="lblProjectTitle" runat="server" Text="TRACE MY ASSETS" class="login-logo"></asp:Label>
                        <%--<div style="margin-left: 80px">
                            <img src="../images/CompanyLogo.jpg" />
                        </div>--%>
                        <br />

                        <%--<div class="msg">Sign in to start your session</div>--%>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">person</i>
                            </span>
                            <div class="form-line">
                                <asp:TextBox ID="txtUserName" runat="server" placeholder="User Name" onkeydown=" return fncLoginEnterFocus(event,'UserName');" class="form-control" required autofocus></asp:TextBox>
                            </div>
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon">
                                <i class="material-icons">lock</i>
                            </span>
                            <div class="form-line">
                                <asp:TextBox ID="txtPassword" runat="server" placeholder="Password" onkeydown=" return fncLoginEnterFocus(event,'Password');" TextMode="Password" class="form-control" required></asp:TextBox>
                            </div>
                        </div>
                        <div >
                            <asp:LinkButton ID="btnSignIn" runat="server" OnClick="btnSignIn_Click" CssClass="btn btn-block bg-red waves-effect">SIGN IN</asp:LinkButton>
                            <%--<div class="col-xs-4">
                                <asp:LinkButton ID="btnSignIn" runat="server" OnClick="btnSignIn_Click" CssClass="btn btn-block bg-red waves-effect">SIGN IN</asp:LinkButton>
                            </div>--%>
                        </div>
                        <div class="login-legal">
                    <div class="login-copyright">
                        &copy; 2020 <a>Unipro Tech Solutions Pvt Ltd </a>
                    </div>
                            </div>
                        <%-- <div class="control-group-single">
                            <div class="col-md-12">
                                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-block bg-pink waves-effect" OnClientClick="VerifyFingerPrint();return false;">Verify</asp:LinkButton>
                            </div>
                        </div>--%>
                    </form>
                </div>
            </div>
        </div>
    </form>

    <!-- Jquery Core Js -->
    <script src="plugins/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core Js -->
    <script src="plugins/bootstrap/js/bootstrap.js"></script>

    <!-- Waves Effect Plugin Js -->
    <script src="plugins/node-waves/waves.js"></script>

    <!-- Validation Plugin Js -->
    <script src="plugins/jquery-validation/jquery.validate.js"></script>

    <!-- Custom Js -->
    <script src="js/admin.js"></script>
    <script src="js/pages/examples/sign-in.js"></script>

</body>
</html>
