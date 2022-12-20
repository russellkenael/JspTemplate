<%!
class UsersEntity {
    public static final String SQL_CREATE = "CREATE TABLE IF NOT EXISTS Users (" +
            "   id INT NOT NULL AUTO_INCREMENT," +
            "   name VARCHAR(1000) NOT NULL," +
            "   type VARCHAR(30) NOT NULL," +
            "   email VARCHAR(1000) NOT NULL," +
            "   password VARCHAR(1000) NOT NULL," +
            "" +
            "   PRIMARY KEY (id)" +
            ")";

    public static final String SQL_DROP = "DROP TABLE Users";
}
%>

