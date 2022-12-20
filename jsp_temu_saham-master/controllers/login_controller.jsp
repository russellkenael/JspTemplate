<%@ include file="../repositories/user_repository_impl.jsp" %>
<%@ include file="../repositories/company_repository_impl.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    UserRepository userRepository = new UserRepositoryImpl();
    CompanyRepository companyRepository = new CompanyRepositoryImpl();

    User user = userRepository.getUserByEmail(email);

    if (user != null) {
        if (password.equals(user.password)) {
            boolean isCompleted = true;
            if(user.type.equals("owner")) {
                Company company = companyRepository.getCompanyByUserEmail(email);

                isCompleted = company.isCompleted;
            }

            if (!isCompleted) {
                response.sendRedirect("../views/create_company.jsp?email=" + email);
            } else {
                session.setAttribute("userId", String.valueOf(user.id));
                session.setAttribute("userType", user.type);
                session.setMaxInactiveInterval(-1);

                response.sendRedirect("../home.jsp");
            }
        } else {
            response.sendRedirect("../views/login.jsp?alert=Login Failed!");
        }
    } else {
        response.sendRedirect("../views/login.jsp?alert=User Not Found, Please Register!");
    }
%>