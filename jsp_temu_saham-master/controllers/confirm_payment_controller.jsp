<%@ include file="../repositories/investment_repository_impl.jsp" %>
<%@ include file="../repositories/company_repository_impl.jsp" %>

<%@ include file="../models/User.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%
    String id = (String) session.getAttribute("userId");
    Integer userId = 0;
    if(id != null) {
        userId = Integer.parseInt(id);
    }

    Integer companyId = Integer.parseInt(request.getParameter("companyId"));
    Float percentage = Float.parseFloat(request.getParameter("stockReceived"));
    Long amount = Long.parseLong(request.getParameter("investmentNominal").replace(",", ""));
    
    InvestmentRepository investmentRepository = new InvestmentRepositoryImpl();
    CompanyRepository companyRepository = new CompanyRepositoryImpl();

    Investment investment = new Investment();

    investment.userId = userId;
    investment.companyId = companyId;
    investment.percentage = percentage;
    investment.amount = amount;

    investmentRepository.addInvestment(investment);

    companyRepository.updateIsInvested(companyId, true);

    response.sendRedirect("../views/portofolio.jsp");
%>