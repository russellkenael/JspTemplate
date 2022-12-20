<%@ include file="../repositories/company_repository_impl.jsp" %>
<%@ include file="../repositories/user_repository_impl.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%
    String id = (String) session.getAttribute("userId");
    int userId = Integer.parseInt(id);
    
    CompanyRepository companyRepository = new CompanyRepositoryImpl();
    companyRepository.deleteCompany(userId);

    session.setAttribute("userType", "investor");

    response.sendRedirect("../home.jsp");
%>