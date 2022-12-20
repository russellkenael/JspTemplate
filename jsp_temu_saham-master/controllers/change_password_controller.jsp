<%@ include file="../repositories/user_repository_impl.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%
    String newPassword = request.getParameter("newPassword");

    String id = (String) session.getAttribute("userId");

    UserRepository userRepository = new UserRepositoryImpl();
    if(id != null) {
        User user = userRepository.getUserById(Integer.parseInt(id));
        if(user != null) {
            user.password = newPassword;
            userRepository.updateUser(user);
        }
    }

    response.sendRedirect("../home.jsp");
%>