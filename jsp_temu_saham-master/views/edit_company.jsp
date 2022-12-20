<%@ page import = "java.text.NumberFormat" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Edit Company | Temu Saham</title>
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
    <%@ include file="../repositories/company_repository_impl.jsp" %>
    <%@ include file="../repositories/user_repository_impl.jsp" %>

    <%@ include file="../instances/temu_saham_db_instance.jsp" %>

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

    <%
      NumberFormat formatPrice = NumberFormat.getInstance();

      UserRepository userRepository = new UserRepositoryImpl();
      CompanyRepository companyRepository = new CompanyRepositoryImpl();

      User user = userRepository.getUserById(Integer.parseInt(id));
      Company company = companyRepository.getCompanyByUserEmail(user.email);
  
      String[] categoryOutputList = {"Technology", "Banking", "Food and Beverage"};
    %>
    <section>
      <div class="create_edit_company">
        <h1 style="text-align: center; font-size: 40px; padding-top: 30px">
          Edit Company
        </h1>
        <form
          action="../controllers/edit_company_controller.jsp?userEmail=<%= user.email %>"
          method="POST"
          name="createCompanyForm"
          onsubmit="return validateCreateCompany()"
        >
          <input type="hidden" name="companyId" value="<%= company.id %>">
          <div class="form_input">
            <label for="name">Company Name</label>
            <input type="text" name="name" value="<%= company.name %>" readonly/>
          </div>

          <div class="form_input">
            <label for="description">Company Description</label>
            <textarea name="description" id="description" cols="30" rows="10"><%= company.description %></textarea>
          </div>

          <div class="form_input">
            <label for="location">Company Location</label>
            <input type="text" name="location" value="<%= company.location %>" readonly/>
          </div>

          <div class="form_input">
            <label for="investmentTarget">Investment Target (in IDR)</label>
            <input type="text" name="investmentTarget" value="<%= formatPrice.format(company.investmentTarget) %>" readonly/>
          </div>

          <div class="form_input">
            <label for="investmentStock">Investment Stock (in percent)</label>
            <input type="text" name="investmentStock" value="<%= company.investmentStock %>" readonly/>
          </div>

          <div class="form_input">
            <label for="logo">Company Logo</label>
            <input type="text" name="logo" value="<%= company.image %>" readonly />
          </div>

          <div class="form_input">
            <label for="email">Company Email</label>
            <input type="text" name="email" value="<%= company.email %>" />
          </div>

          <div class="form_input">
            <label for="phone">Company Phone Number</label>
            <input type="text" name="phone" value="<%= company.phone %>" />
          </div>

          <div class="form_input">
            <label for="url">Company Website URL (if any)</label>
            <input type="text" name="url" placeholder="Input your company website URL..." value="<%= company.url %>" />
          </div>

          <div class="form_input">
            <label for="foundedYear">Company Founded Year</label>
            <input type="text" name="foundedYear" value="<%= company.foundedYear %>" readonly/>
          </div>

          <div class="form_input">
            <label for="Information">Company Category</label>
            <div class="personal-information">
              <%
                for(int i = 0 ; i < 3 ; i++) {
                  if(company.categoryName.equals(categoryOutputList[i])) {
                    %>
                    <div class="form-check">
                      <input
                        class="form-check-input"
                        type="radio"
                        name="category"
                        value="<%= categoryOutputList[i] %>"
                        disabled
                        checked
                      />
                      <label class="form-check-label" for="<%= categoryOutputList[i] %>">
                        <%= categoryOutputList[i] %>
                      </label>
                    </div>
                    <%
                  } else {
                    %>
                    <div class="form-check">
                      <input
                        class="form-check-input"
                        type="radio"
                        name="category"
                        value="<%= categoryOutputList[i] %>"
                        disabled
                      />
                      <label class="form-check-label" for="<%= categoryOutputList[i] %>">
                        <%= categoryOutputList[i] %>
                      </label>
                    </div>
                    <%
                  }
                }
              %>
            </div>
          </div>
          <input type="submit" id="submit" value="Update" />
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
          let confirmEditCompany = confirm("Are you sure you want to update the company with above data?");
          if(confirmEditCompany) {
            alert("Company updated successfully");
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
