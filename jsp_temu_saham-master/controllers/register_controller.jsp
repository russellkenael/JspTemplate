<%@ include file="../repositories/user_repository_impl.jsp" %>
<%@ include file="../repositories/company_repository_impl.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    User user = new User();

    user.name = name;
    user.email = email;
    user.password = password;
    user.type = role;

    UserRepository userRepository = new UserRepositoryImpl();
    CompanyRepository companyRepository = new CompanyRepositoryImpl();

    User userFromDB = userRepository.getUserByEmail(email);

    if (userFromDB != null) {
        response.sendRedirect("../views/login.jsp?alert=User with this email already exists");
    } else {
        userRepository.addUser(user);

        if(role.equals("investor")) {
            response.sendRedirect("../views/login.jsp?alert=User successfully registered!");
        } else {
            Company company = new Company();

            company.owner = user;
            companyRepository.createCompanyKosongan(company);

            response.sendRedirect("../views/create_company.jsp?email=" + email);
        }
    }    
%>