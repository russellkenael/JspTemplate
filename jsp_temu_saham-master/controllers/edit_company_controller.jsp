<%@ include file="../repositories/company_repository_impl.jsp" %>
<%@ include file="../repositories/user_repository_impl.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%
    String userEmail = request.getParameter("userEmail");
    String companyId = request.getParameter("companyId");
    
    String description = request.getParameter("description");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String url = request.getParameter("url");

    UserRepository userRepository = new UserRepositoryImpl();
    CompanyRepository companyRepository = new CompanyRepositoryImpl();

    Company company = new Company();

    company.id = Integer.parseInt(companyId);
    company.description = description;
    company.email = email;
    company.phone = phone;
    company.url = url;

    companyRepository.updateCompany(company);
    
    response.sendRedirect("../home.jsp");
%>