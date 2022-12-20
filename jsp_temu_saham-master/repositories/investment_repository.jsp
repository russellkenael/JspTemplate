<%@ page import="java.util.List" %>

<%!
interface InvestmentRepository {
    public boolean addInvestment(Investment investment);
    public List<Investment> getInvestmentByUserId(int userId);
}
%>