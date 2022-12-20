<%@ page import="java.sql.Connection;" %>
<%@ page import="java.sql.DriverManager;" %>
<%@ page import="java.sql.PreparedStatement;" %>
<%@ page import="java.sql.SQLException;" %>
<%@ page import="java.util.List;" %>
<%@ page import="java.util.Map;" %>

<%@ page import="javax.sql.RowSet;" %>
<%@ page import="javax.sql.rowset.CachedRowSet;" %>
<%@ page import="javax.sql.rowset.RowSetProvider;" %>

<%!
abstract class DbInstance {
    protected Connection connection;
    protected Map<String, String> config; // will be defined in the implementation
    protected List<Class<Entity>> entities; // will be defined in the implementation

    public Connection getConnection() {
        String driver = config.get("driver");
        String url = config.get("url");
        String name = config.get("name");
        String user = config.get("user");
        String password = config.get("password");

        try {
            Class.forName(driver);

            if (connection == null) {
                connection = DriverManager.getConnection(url + name, user, password);
                connection.setAutoCommit(true);
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            if (connection == null) {
                initDatabase();
            }
        }

        return connection;
    }

    public void drop() {
        String name = config.get("name");
        executeQuery("DROP DATABASE IF EXISTS " + name, null);
    }

    public RowSet executeQuery(String query, Object[] parameters) {
        CachedRowSet rowSet = null; // CachedRowSet is basically ResultSet that can be passed around functions/classes.
        connection = getConnection();

        try {
            //The following if else is needed because SELECT statement can only use PreparedStatement, while others can use RowSet.
            if (query.toUpperCase().indexOf("SELECT") != 0) { 
                PreparedStatement statement = connection.prepareStatement(query);

                if (parameters != null) {
                    for (int i = 0; i < parameters.length; i++) {
                        statement.setObject(i + 1, parameters[i]);
                    }
                }

                statement.executeUpdate();

                statement.close();
                statement = null;
            } else {
                rowSet = RowSetProvider.newFactory().createCachedRowSet();
                rowSet.setCommand(query);
                if (parameters != null) {
                    for (int i = 0; i < parameters.length; i++) {
                        rowSet.setObject(i + 1, parameters[i]);
                    }
                }
                rowSet.execute(connection);
                rowSet.first();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                    connection = null;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return rowSet;
    }

    public RowSet executeQuery(String query, Object[] parameters, int pageNumber, int pageSize) {
        String paginatedQuery = query + " LIMIT ?, ?";
        Object[] paginationParameters = new Object[parameters.length + 1];

        for (int i = 0; i < parameters.length; ++i) {
            paginationParameters[i] = parameters[i];
        }

        paginationParameters[parameters.length] = pageNumber * pageSize;
        paginationParameters[parameters.length + 1] = pageSize;

        return executeQuery(paginatedQuery, parameters);
    }

    // From here to the end, it is only for automating entity creation and database connection based on configuration in `DbConfig.jsp` and DbInstance implementations (See `ExampleDbInstance.jsp`)
    public void initDatabase() {
        String url = config.get("url");
        String name = config.get("name");
        String user = config.get("user");
        String password = config.get("password");

        try {
            connection = DriverManager.getConnection(url, user, password);
            executeQuery("CREATE DATABASE IF NOT EXISTS " + name, null);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) {
                    connection.close();
                    connection = null;
                }
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }

        initTables();
    }

    public void initTables() {
        String url = config.get("url");
        String name = config.get("name");
        String user = config.get("user");
        String password = config.get("password");

        try {
            connection = DriverManager.getConnection(url + name, user, password);
            connection.setAutoCommit(true);

            for (Class<Entity> entity : entities) {
                executeQuery(getField(entity, "SQL_CREATE"), null);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (connection != null) {
                    connection.close();
                    connection = null;
                }
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
    }

    private <T extends Entity> String getField(Class<T> entity, String fieldName) { //Copied from StackOverflow
        try { 
            return String.valueOf(
                entity
                .getField(fieldName)
                .get(entity
                     .getDeclaredConstructors()[0]
                     .newInstance(this)
                )
            );
        } catch (SecurityException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
%>