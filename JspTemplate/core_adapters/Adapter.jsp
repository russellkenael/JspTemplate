<%@ page import="javax.sql.RowSet;" %>

<%!
abstract class Adapter<T> { //This is for transforming ResultSet into Model
    protected T adapt(RowSet rowSet);

    public T adaptSingle(RowSet rowSet) {
        T model;
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                model = adapt(rowSet);
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

        return model;
    }

    public List<T> adaptMany(RowSet rowSet) {
        List<T> models = new ArrayList<>();

        T model;
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) { 
                model = adapt(rowSet);
                models.add(model);
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

        return models.size() == 0 ? null : models;
    }
}
%>