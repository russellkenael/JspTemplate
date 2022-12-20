<%@ page import="javax.sql.RowSet;" %>

<%!
abstract class Repository { // these properties will be implicit properties for its implementations
    DbInstance db;
    String query;
    Object[] parameters;
    RowSet result;
}
%>
