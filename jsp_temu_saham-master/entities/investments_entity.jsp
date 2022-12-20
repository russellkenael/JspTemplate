<%@ page import="java.sql.Timestamp"%>

<%!
class InvestmentsEntity {
    public static final String SQL_CREATE = "CREATE TABLE IF NOT EXISTS Investments (" +
            "   id INT NOT NULL AUTO_INCREMENT," +
            "   user_id INT NOT NULL," +
            "   company_id INT NOT NULL," +
            "   percentage DOUBLE(6, 2) NOT NULL," +
            "   created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()," +
            "   amount INT NOT NULL," +
            "" +
            "   PRIMARY KEY (id)," +
            "   FOREIGN KEY (user_id) REFERENCES Users(Id) ON DELETE CASCADE," +
            "   FOREIGN KEY (company_id) REFERENCES Companies(Id) ON DELETE CASCADE" +
            ")";

    public static final String SQL_DROP = "DROP TABLE Investments";
}
%>
