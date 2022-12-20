<%@ include file="company_repository_test.jsp" %>
<%@ include file="investment_repository_test.jsp" %>
<%@ include file="user_repository_test.jsp" %>

<%@ include file="../instances/temu_saham_db_instance.jsp" %>

<%@ include file="test_util.jsp" %>

<%
System.out.println("-----------------------------");
System.out.println("Start Testing");
System.out.println("-----------------------------");
CompanyRepositoryTest c = new CompanyRepositoryTest();
InvestmentRepositoryTest i = new InvestmentRepositoryTest();
UserRepositoryTest u = new UserRepositoryTest();

u.should_return_null_when_user_not_found();
u.should_return_new_user_when_add_user_success();
u.should_change_password_when_update_user_success();

c.should_return_null_when_companies_not_found();
c.should_create_new_company_when_create_company_success();
c.should_change_email_when_update_company_success();
c.should_delete_company_when_delete_company_success();

%>