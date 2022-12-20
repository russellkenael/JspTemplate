<%!
class CompaniesEntity {
    public static final String SQL_CREATE = "CREATE TABLE IF NOT EXISTS Companies (" +
            "   id INT NOT NULL AUTO_INCREMENT," +
            "   user_id INT NOT NULL," +
            "   category_id INT," +
            "   name VARCHAR(1000)," +
            "   description VARCHAR(1000)," +
            "   location VARCHAR(1000)," +
            "   investment_stock INT," +
            "   investment_target BIGINT(20)," +
            "   image TEXT," +
            "   email VARCHAR(1000)," +
            "   phone VARCHAR(1000)," +
            "   url VARCHAR(1000)," +
            "   founded_year CHAR(4)," +
            "   is_invested CHAR(1) DEFAULT ('N')," +
            "   is_completed CHAR(1) DEFAULT ('N')," +
            "" +
            "   PRIMARY KEY (id)," +
            "   FOREIGN KEY (user_id) REFERENCES Users(Id) ON DELETE CASCADE," +
            "   FOREIGN KEY (category_id) REFERENCES Categories(Id) ON DELETE CASCADE" +
            ")";

    public static final String SQL_DROP = "DROP TABLE Companies";
}
%>
