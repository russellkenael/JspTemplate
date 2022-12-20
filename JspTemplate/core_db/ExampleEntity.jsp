<%!
class ExampleEntity {
    public ExampleEntity() {
        this.SQL_CREATE = "CREATE TABLE IF NOT EXISTS Example (" +
                "   Id INT," +
                "   Title VARCHAR(255)," +
                "   Content VARCHAR(255)," +
                "" +
                "PRIMARY KEY (Id)";

        this.SQL_DROP = "DROP TABLE Example";
    }
}
%>