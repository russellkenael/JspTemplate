<%@ include file="../repositories/investment_repository_impl.jsp" %>

<%!
class InvestmentRepositoryTest {
    InvestmentRepository repository;

    public InvestmentRepositoryTest() {
        repository = new InvestmentRepositoryImpl();
    }

}
%>