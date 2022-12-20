<%@ page import="java.util.List" %>

<%!
interface UserRepository {
    public User getUserById(int id);
    public User getUserByEmail(String email);
    public boolean addUser(User user);
    public boolean updateUser(User user);
    public List<String> getUserTypes();
}  
%>