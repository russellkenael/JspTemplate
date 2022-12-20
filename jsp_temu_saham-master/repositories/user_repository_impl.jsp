<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="java.sql.SQLException" %>

<%@ page import="javax.sql.RowSet" %>
<%@ page import="javax.sql.rowset.CachedRowSet" %>
<%@ page import="javax.sql.rowset.RowSetProvider" %>

<%@ include file="../models/User.jsp" %>
<%@ include file="user_repository.jsp" %>

<%!
class UserRepositoryImpl implements UserRepository {

    @Override
    public User getUserById(int id) {
        String query = "" +
        "SELECT u.id, u.name, u.type, u.email, u.password" +
        "  FROM Users u" +
        " WHERE u.id = ?";

        Object[] parameters = new Object[] { id };

        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, parameters);

        User user = new User();
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                user.id = rowSet.getInt(1);
                user.name = rowSet.getString(2);
                user.type = rowSet.getString(3);
                user.email = rowSet.getString(4);
                user.password = rowSet.getString(5);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user.id != 0 ? user : null;
    }

    @Override
    public User getUserByEmail(String email) {
        String query = "" +
        "SELECT u.id, u.name, u.type, u.email, u.password" +
        "  FROM Users u" +
        " WHERE u.email = ?";

        Object[] parameters = new Object[] { email };

        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, parameters);

        User user = new User();
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                user.id = rowSet.getInt(1);
                user.name = rowSet.getString(2);
                user.type = rowSet.getString(3);
                user.email = rowSet.getString(4);
                user.password = rowSet.getString(5);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rowSet.close();
                rowSet = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return user.id != 0 ? user : null;
    }

    @Override
    public boolean addUser(User user) {
        String query = "" +
        "INSERT INTO Users (name, type, email, password) " +
        "VALUES (?, ?, ?, ?) ";

        Object[] parameters = new Object[] {
            user.name, user.type, user.email, user.password
        };

        System.out.println(user.name);
        System.out.println(user.email);
        TemuSahamDbInstance.executeQuery(query, parameters);
        return true;
    }

    @Override
    public boolean updateUser(User user) {
        String query = "" +
        "UPDATE Users u " +
        "   SET name = IFNULL(?, name) " +
        "     , email = IFNULL(?, email) " +
        "     , type  = IFNULL(?, type) " +
        "     , password = IFNULL(?, password) " +
        " WHERE u.id = ?";

        Object[] parameters = new Object[] {
            user.name, user.email, user.type, user.password, user.id
        };

        TemuSahamDbInstance.executeQuery(query, parameters);
        return true;
    }

    @Override
    public List<String> getUserTypes() {
        String query = "" +
        "SELECT DISTINCT type " +
        "  FROM Users " +
        " ORDER BY name";

        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, null);

        List<String> userTypeList = new ArrayList<>();
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                userTypeList.add(rowSet.getString(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rowSet.close();
                rowSet = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return userTypeList.size() != 0 ? userTypeList : null;
    }
}
%>