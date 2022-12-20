<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password | Temu Saham</title>
    <link rel="stylesheet" href="../styles/change_password_style.css">
    <link rel="stylesheet" href="../styles/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%
    String id = (String) session.getAttribute("userId");
    String type = (String) session.getAttribute("userType");

        if (id != null && type != null && !id.isEmpty() && type.equals("investor")) {
    %>
      <%@ include file="../navbars/navbar_views_investor.jsp" %>
    <%
        } else if (id != null && type != null && !id.isEmpty() && type.equals("owner")) {
    %>
      <%@ include file="../navbars/navbar_views_owner.jsp" %>
    <%
        } else {
    %>
      <%@ include file="../navbars/navbar_views_not_login.jsp" %>
    <%
        }
    %>

    <section>
        <div class="changePassword">
            <h1 style="text-align: center; font-size: 40px; padding-top: 30px;">Change Password</h1>
            <form action="../controllers/change_password_controller.jsp" method="post" name="changePasswordForm" onsubmit="return validateChangePassword()">
                <div class="form_input">
                    <label for="pass">Old Password</label>
                    <input type="password" name="oldPassword" id="oldPassword" placeholder="Input your old password..">
                </div>

                <div class="form_input">
                    <label for="pass">New Password</label>
                    <input type="password" name="newPassword" id="newPassword" placeholder="Input your new password..">
                </div>

                <div class="form_input">
                    <label for="pass">Confirmation your New Password</label>
                    <input type="password" name="confirmNewPassword" id="confirmNewPassword" placeholder="Input your new password once again..">
                </div>

                <br>

                <input type="submit" id="submit" value="Change Password">
            </form>
        </div>
    </section>
    <script>
        function validateChangePassword() {
            let oldPassword = document.forms["changePasswordForm"]["oldPassword"].value;
            let newPassword = document.forms["changePasswordForm"]["newPassword"].value;
            let confirmNewPassword = document.forms["changePasswordForm"]["confirmNewPassword"].value;
            let regexPassword = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;
            if(oldPassword == "") {
                alert("Old password must not be empty");
                return false;
            } else if(newPassword == "") {
                alert("New password must not be empty");
                return false;
            } else if(oldPassword == newPassword) {
                alert("New password must not be the same with old password");
                return false;
            } else if(!newPassword.match(regexPassword)) {
                alert("Password must be 8 until 15 characters and contain at least one lowercase letter, one uppercase letter, one numeric digit, and one special character");
                return false;
            } else if(newPassword != confirmNewPassword) {
                alert("Confirm new password must be the same with new password");
                return false;
            } else {
                let confirmChangePassword = confirm("Are you sure you want to change your password?");
                if(confirmChangePassword) {
                    alert("Password changed successfully");
                    return true;
                } else {
                    return false;
                }
            }
        }
    </script>
</body>
</html>