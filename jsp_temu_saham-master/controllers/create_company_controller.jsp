<%@ include file="../repositories/company_repository_impl.jsp" %>
<%@ include file="../repositories/user_repository_impl.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%
    String userEmail = request.getParameter("userEmail");

    String name = request.getParameter("name");
    String description = request.getParameter("description");
    String location = request.getParameter("location");
    Integer investmentStock = Integer.parseInt(request.getParameter("investmentStock"));
    Long investmentTarget = Long.parseLong(request.getParameter("investmentTarget"));
    String logo = request.getParameter("logo");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String url = request.getParameter("url");
    Integer foundedYear = Integer.parseInt(request.getParameter("foundedYear"));
    String category = request.getParameter("category");

    UserRepository userRepository = new UserRepositoryImpl();
    CompanyRepository companyRepository = new CompanyRepositoryImpl();

    Company company = new Company();

    // Temporary Only
    if (category.equals("Technology")) {
        company.categoryId = 1;
    } else if (category.equals("Banking")) {
        company.categoryId = 2;
    } else if (category.equals("Food And Beverage")) {
        company.categoryId = 3;
    }
    company.name = name;
    company.description = description;
    company.location = location;
    company.investmentStock = investmentStock;
    company.investmentTarget = investmentTarget;
    company.image = logo;
    company.email = email;
    company.phone = phone;
    company.url = url;
    company.foundedYear = foundedYear;
    company.isCompleted = true;

    company.owner = userRepository.getUserByEmail(userEmail);

    companyRepository.updateCompanyFullByUserId(company);

    response.sendRedirect("../views/login.jsp?alert=User and Company successfully registered!");
%>