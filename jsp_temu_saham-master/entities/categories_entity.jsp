<%!
class CategoriesEntity {
    public static final String SQL_CREATE = "CREATE TABLE IF NOT EXISTS Categories (" +
            "   id INT NOT NULL AUTO_INCREMENT," +
            "   name VARCHAR(1000) NOT NULL," +
            "" +
            "   PRIMARY KEY (id)" +
            ")";

    public static final String SQL_DROP = "DROP TABLE Categories";
}
%>
