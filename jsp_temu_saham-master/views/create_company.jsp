<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Create Company | Temu Saham</title>
    <link rel="stylesheet" href="../styles/create_edit_company_style.css" />
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
    <%
      String email = request.getParameter("email");
    %>

    <section>
      <div class="create_edit_company">
        <h1 style="text-align: center; font-size: 40px; padding-top: 30px">
          Create Company
        </h1>
        <form
          action="../controllers/create_company_controller.jsp?userEmail=<%= email %>"
          method="post"
          name="createCompanyForm"
          onsubmit="return validateCreateCompany()"
        >
          <div class="form_input">
            <label for="name">Company Name</label>
            <input type="text" name="name" placeholder="Input your company name..." />
          </div>

          <div class="form_input">
            <label for="description">Company Description</label>
            <textarea name="description" id="" cols="30" rows="10" placeholder="Input your company description..."></textarea>
          </div>

          <div class="form_input">
            <label for="location">Company Location</label>
            <input type="text" name="location" placeholder="Input your company location..." />
          </div>

          <div class="form_input">
            <label for="investmentTarget">Investment Target (in IDR)</label>
            <input type="number" name="investmentTarget" placeholder="Input your investment target... (minimum 10 million, maximum 100 billion, multiple of 1 million)" min="10000000" step="1000000" max="100000000000"/>
          </div>

          <div class="form_input">
            <label for="investmentStock">Investment Stock (in percent)</label>
            <input type="number" name="investmentStock" placeholder="Input your investment stock to be shared... (minimum 1, maximum 100, multiple of 1)" min="1" step="1" max="100"/>
          </div>

          <div class="form_input">
            <label for="logo">Company Logo</label>
            <input type="text" name="logo" placeholder="Input your company logo url..." />
          </div>

          <div class="form_input">
            <label for="email">Company Email</label>
            <input type="text" name="email" placeholder="Input your company email..." />
          </div>

          <div class="form_input">
            <label for="phone">Company Phone Number</label>
            <input type="text" name="phone" placeholder="Input your company phone number..." />
          </div>

          <div class="form_input">
            <label for="url">Company Website URL (if any)</label>
            <input type="text" name="url" placeholder="Input your company website URL..." />
          </div>

          <div class="form_input">
            <label for="foundedYear">Company Founded Year</label>
            <input type="number" name="foundedYear" placeholder="Input your company founded year..." min="1900" step="1" max="<%= (new java.util.Date()).getYear() + 1900 %>"/>
          </div>

          <div class="form_input">
            <label for="Information">Company Category</label>
            <div class="personal-information">
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="radio"
                  name="category"
                  id="technology"
                  value="Technology"
                />
                <label class="form-check-label" for="technology">
                  Technology
                </label>
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="radio"
                  name="category"
                  id="banking"
                  value="Banking"
                />
                <label class="form-check-label" for="banking">
                  Banking
                </label>
              </div>
              <div class="form-check">
                <input
                  class="form-check-input"
                  type="radio"
                  name="category"
                  id="foodAndBeverage"
                  value="Food And Beverage"
                />
                <label class="form-check-label" for="foodAndBeverage">
                  Food and Beverage
                </label>
              </div>
            </div>
          </div>

          <input type="submit" id="submit" value="Create" />
        </form>
      </div>
    </section>

    <script>
      function validateCreateCompany() {
        let name = document.forms["createCompanyForm"]["name"].value;
        let description = document.forms["createCompanyForm"]["description"].value;
        let location = document.forms["createCompanyForm"]["location"].value;
        let investmentTarget = document.forms["createCompanyForm"]["investmentTarget"].value;
        let investmentStock = document.forms["createCompanyForm"]["investmentStock"].value;
        let logo = document.forms["createCompanyForm"]["logo"].value;
        let email = document.forms["createCompanyForm"]["email"].value;
        let phone = document.forms["createCompanyForm"]["phone"].value;
        let url = document.forms["createCompanyForm"]["url"].value;
        let foundedYear = document.forms["createCompanyForm"]["foundedYear"].value;
        let category = document.getElementsByName("category");

        let regexEmail = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

        let categorySelected = false;

        for (let i = 0; i < category.length; i++) {
          if (category[i].checked) {
            categorySelected = true;
            break;
          }
        }

        if (name == "") {
          alert("Name must not be empty");
          return false;
        } else if (description == "") {
          alert("Description must not be empty");
          return false;
        } else if (location == "") {
          alert("Location must not be empty");
          return false;
        } else if(investmentTarget == "") {
          alert("Investment target must not be empty");
          return false;
        } else if(investmentStock == "") {
          alert("Investment stock must not be empty");
          return false;
        } else if(logo == "") {
          alert("Logo url must not be empty");
          return false;
        } else if(email == "") {
          alert("Email must not be empty");
          return false;
        } else if(phone == "") {
          alert("Phone number must not be empty");
          return false;
        } else if(foundedYear == "") {
          alert("Founded year must not be empty");
          return false;
        } else if(!categorySelected) {
          alert("Your have to select your company category");
          return false;
        } else if(name.length < 2) {
          alert("Company name must consists of at least 2 characters");
          return false;
        } else if(location.length < 10) {
          alert("Company location must consists of at least 10 characters");
          return false;
        } else if(!email.match(regexEmail)) {
          alert("Enter a valid email");
          return false;
        } else {
          let confirmCreateCompany = confirm("Are you sure you want to create a company with above data?");
          if(confirmCreateCompany) {
            alert("Company created successfully");
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
