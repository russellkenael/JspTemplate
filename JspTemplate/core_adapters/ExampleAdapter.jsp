<%@ page import="javax.sql.RowSet;" %>

<%!
class ExampleAdapter extends Adapter<ExampleModel>{
    
    // You only need to define how to parse a single row from ResultSet
    // For many rows, `adaptSingle` and `adaptMany` will take care of that.
    @Override
    protected ExampleModel adapt(RowSet rowSet) { 
        return new ExampleModel(
            rowSet.getInt(1),
            rowSet.getString(2),
            rowSet.getString(3)
        );
    }
}
%>