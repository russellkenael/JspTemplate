<%@ page import = "java.text.NumberFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Profile | TemuSaham</title>
    <style>
        html, body {
            width: 100%;
            padding: 0px;
            margin: 0px;
        }

        .padding-righter {
            padding-right: 12px;
        }

        body {
            min-height: 100vh;
        }

        #user-password:focus {
            border: 0;
        }
    </style>
</head>
<body>
    <%@ include file="../instances/temu_saham_db_instance.jsp" %>
    <%@ include file="../repositories/company_repository_impl.jsp" %>
    <%@ include file="../repositories/user_repository_impl.jsp" %>

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

    int userId = Integer.parseInt(id);
    User user = userRepository.getUserById(userId);
    Company company = companyRepository.getCompanyByUserEmail(user.email);
    
    int passwordLength = user.password.length();
    
    String investedAmountString = "Rp0.00";
    String investmentTargetString = "Rp0.00";
    StringBuilder passwordBuilder = new StringBuilder(passwordLength);
    for(int i = 0; i < passwordLength; ++i) {
        passwordBuilder.append("*");
    }

    String password = passwordBuilder.toString();

    if(company != null) {
        investedAmountString = "Rp. " + formatPrice.format(company.investedAmount);
        investmentTargetString = "Rp. " + formatPrice.format(company.investmentTarget);
    }
    %>

    <div class="container w-100 h-100 d-flex flex-column justify-content-center align-items-center">
        <h1 class="my-4">Profile</h1>

        <form action="edit_company.jsp" method="post" class="border rounded p-3 mb-5">

            <div class="container" style="min-height: fit-content; margin-bottom: 12px;">
                <h3><center>User</center></h3>
                <table>
                    <tr class="form-group">
                        <td style="width: 40%;"><b>Name</b></td>
                        <td class="form-control-plaintext"><%= user.name %></td>
                    </tr>
                    <tr class="form-group">
                        <td style="width: 40%;"><b>Email</b></td>
                        <td class="form-control-plaintext"><%= user.email %></td>
                    </tr>
                    <tr class="form-group">
                        <td style="width: 40%; padding-right: 20px;"><b>Password</b></td>
                        <td><input class="form-control-plaintext" type="password" name="user-password" id="user-passowrd" value="<%= password %>"></td>
                    </tr>
                    
                </table>

                <a href="change_password.jsp" style="text-decoration: none;">Change Password</a>
            </div>

            <% if(company != null) { %>
            <div class="container mt-5" id="company-profile">
                <div class="d-flex justify-content-between align-items-center">
                    <h3><center>Company</center></h3>

                    <% if(company.investedAmount == 0) { %>
                    <a href="../controllers/profile_controller.jsp" id="btn-delete-company" class="btn btn-danger">Delete</a>
                    <% } %>
                </div>

                <br>

                <div class="row">
                    <div class="col-sm d-flex align-items-center">
                        <img src="<%= company.image %>" alt="" style="height: 200px; width: 200px;">
                    
                        <div class="container" style="margin-left: 12px;">
                            <h3 class="mb-0"><%= company.name %> (<%= company.foundedYear %>)</h3>
                            <p><%= company.categoryName %></p>
                            <br>
                            <p class="m-0"><b>Location</b></p>
                            <p><%= company.location %></p>
                        </div>
                    </div>
                </div>

                <div class="row mt-3">
                    <div class="col-sm">
                        <p class="m-0"><b>Accumulated Investments</b></p>
                        <div class="d-flex justify-content-start align-items-center">
                            <p style="font-size: 20px;" id="invested-amount"><%= investedAmountString %></p><p style="font-size: 20px;">/</p><p class="align-self-center" style="font-size: 12px;" id="investment-target"><%= investmentTargetString %></p>
                        </div>
                    </div>
                    <div class="col-sm">
                        <p class="m-0"><b>Fulfilled Stocks</b></p>
                        <p style="font-size: 20px;"><%= company.investmentStock %>%</p>
                        <%-- <p style="font-size: 20px;" id="Purchased Stock">28%</p><p style="font-size: 20px;">/</p><p class="align-self-end" style="font-size: 12px;" id="investment-target"></p> --%>
                    </div>
                </div>

                <div class="row"><b>Description</b></div>
                <div class="row form-group mt-2" style="margin: 0px;">
                    <%-- <textarea class="form-control-plaintext" style="resize: none;" name="description" id="company_description" cols ="30" rows="10" readonly>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</textarea> --%>
                    <p class="form-control-plaintext" style="resize: none;" id="company_description" readonly><%= company.description %></p>
                </div>

                <div class="row mt-4 mb-2"><b>Contacts</b></div>
                <div class="row">
                    <div class="form-group mb-2">
                        <label style="font-size: 14px;" for="email"><b>Email</b></label><br>
                        <input class="form-control-plaintext" type="text" name="email" value="<%= company.email %>" readonly>
                    </div>
                    <div class="form-group mb-2">
                        <label style="font-size: 14px;" for="phone"><b>Phone</b></label><br>
                        <input class="form-control-plaintext" type="text" name="phone" value="<%= company.phone %>" readonly>
                    </div>
                    <div class="form-group">
                        <label style="font-size: 14px;" for="url"><b>Url</b></label><br>
                        <input class="form-control-plaintext" type="text" name="url" value="<%= company.url %>" readonly>
                    </div>
                </div>
            </div>
            <% } %>
            <div class="d-flex <%= company != null ? "justify-content-between" : "justify-content-start" %> mt-4 align-items-center" style="margin: 0px 12px;">
                <a href="../controllers/logout_controller.jsp" class="text-danger" style="text-decoration: none;">Log Out</a>

                <% if(company != null) { %>
                <button type="submit" class="btn btn-primary">Update Company</button>
                <% } %>
            </div>
        </form>
    </div>
</body>
</html>