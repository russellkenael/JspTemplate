<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>

<%@ page import="java.sql.SQLException" %>

<%@ page import="javax.sql.RowSet" %>
<%@ page import="javax.sql.rowset.CachedRowSet" %>
<%@ page import="javax.sql.rowset.RowSetProvider" %>

<%@ include file="../models/Investment.jsp" %>
<%@ include file="investment_repository.jsp" %>

<%!
class InvestmentRepositoryImpl implements InvestmentRepository {
    
    @Override
    public boolean addInvestment(Investment investment) {
        String query;   

        query = "" + 
        "INSERT INTO Investments (user_id, company_id, percentage, created_at, amount) " +
        "VALUES (?, ?, ?, NOW(), ?)";

        Object[] parameters = new Object[] {
            investment.userId,
            investment.companyId,
            investment.percentage,
            investment.amount
        };
        
        TemuSahamDbInstance.executeQuery(query, parameters);

        return true;
    }
    
    @Override
    public List<Investment> getInvestmentByUserId(int userId) {
        String query = "" +
        "SELECT i.id, i.user_id AS userId, i.company_id AS companyId, i.percentage, i.created_at AS createdAt, i.amount" +
        "  FROM Investments i" +
        " WHERE i.user_id = ?" +
        "";

        Object[] parameters = new Object[] { userId };

        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, parameters);

        List<Investment> investmentList = new ArrayList<>();
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
               Investment investment = new Investment();
               
               investment.id = rowSet.getInt(1);
               investment.userId = rowSet.getInt(2);
               investment.companyId = rowSet.getInt(3);
               investment.percentage = rowSet.getFloat(4);
               investment.amount = rowSet.getLong(6);
            
               System.out.println(rowSet.getString(5));
               SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
               try {
                   investment.createdAt = df.parse(rowSet.getString(5) + "+0700");
               } catch (ParseException e) {
                   e.printStackTrace();
                   try {
                       investment.createdAt = df.parse(rowSet.getString(5)+ ":00+0700");
                   } catch (ParseException e1) {
                       e1.printStackTrace();
                   }
               }

               investmentList.add(investment);
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

        return investmentList.size() != 0 ? investmentList : null;
    }
}
%>