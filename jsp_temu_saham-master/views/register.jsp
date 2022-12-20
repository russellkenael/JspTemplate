<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Register | Temu Saham</title>
    <link rel="stylesheet" href="../styles/register_style.css" />
    <link rel="stylesheet" href="../styles/style.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  </head>
  <body>
    <%@ include file="../navbars/navbar_views_not_login.jsp" %>

    <section>
      <div class="register">
        <h1 style="text-align: center; font-size: 40px; padding-top: 30px">
          Register
        </h1>
        <form
          action="../controllers/register_controller.jsp"
          method="post"
          name="registerForm"
          onsubmit="return validateRegister()"
        >
          <div class="form_input">
            <label for="name">Full Name</label>
            <input type="text" name="name" placeholder="Input your name.." />
          </div>

          <div class="form_input">
            <label for="email">Email Address</label>
            <input type="text" name="email" placeholder="Input your email.." />
          </div>

          <div class="form_input">
            <label for="password">Password</label>
            <input
              type="password"
              name="password"
              placeholder="Input your password.."
            />
          </div>

          <div class="form_input">
            <label for="confirmPassword">Confirmation Password</label>
            <input
              type="password"
              name="confirmPassword"
              placeholder="Input your password again.."
            />
          </div>

          <div class="form_input">
            <label for="Information">Role</label>
            <div class="personal-information">
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="radio"
                  name="role"
                  id="investor"
                  value="investor"
                />
                <label class="form-check-label" for="investor">
                  Investor
                </label>
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="radio"
                  name="role"
                  id="owner"
                  value="owner"
                />
                <label class="form-check-label" for="owner">
                  Company Owner
                </label>
              </div>
            </div>
          </div>

          <input type="submit" id="submit" value="Submit" />
        </form>
      </div>
    </section>

    <script>
      function validateRegister() {
        let name = document.forms["registerForm"]["name"].value;
        let email = document.forms["registerForm"]["email"].value;
        let password = document.forms["registerForm"]["password"].value;
        let confirmPassword =
          document.forms["registerForm"]["confirmPassword"].value;
        let role = document.getElementsByName("role");

        let regexEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        let regexPassword =
          /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{8,15}$/;

        let roleSelected = false;
        for (let i = 0; i < role.length; i++) {
          if (role[i].checked) {
            roleSelected = true;
            break;
          }
        }

        if (name == "") {
          alert("Name must not be empty");
          return false;
        } else if (email == "") {
          alert("Email must not be empty");
          return false;
        } else if (password == "") {
          alert("Password must not be empty");
          return false;
        } else if (!roleSelected) {
          alert("Select your role");
          return false;
        } else if (!email.match(regexEmail)) {
          alert("Enter a valid email");
          return false;
        } else if (!password.match(regexPassword)) {
          alert(
            "Password must be 8 until 15 characters and contain at least one lowercase letter, one uppercase letter, one numeric digit, and one special character"
          );
          return false;
        } else if (password != confirmPassword) {
          alert("Confirm password must be the same with password");
          return false;
        } else {
          let confirmRegister = confirm(
            "Are you sure you want to register with the data above? (You can only change password after registering)"
          );
          if (confirmRegister) {
            return true;
          } else {
            return false;
          }
        }
      }
    </script>

    <%@ include file="../footers/footer.jsp" %>
  </body>
</html>
