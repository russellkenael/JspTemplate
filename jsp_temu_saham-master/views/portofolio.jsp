<%@ page import = "java.text.NumberFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Portofolio | TemuSaham</title>
    <link rel="stylesheet" href="../styles/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <%@ include file="../models/User.jsp" %>

    <%@ include file="../repositories/investment_repository_impl.jsp" %>
    <%@ include file="../repositories/company_repository_impl.jsp" %>

    <%@ include file="../instances/temu_saham_db_instance.jsp" %>

    <%@ page import="java.text.SimpleDateFormat" %>

    <%
    String id = (String) session.getAttribute("userId");
    String type = (String) session.getAttribute("userType");

        if (id != null && type != null && !id.isEmpty() && type.equals("investor")) {
    %>
      <%@ include file="../navbars/navbar_views_investor.jsp" %>
    <%
        } else if (id != null && type != null && !id.isEmpty() && type.equals("owner")) {
    %>
      <%@ include file="../navbars/navbar_views_owner.jsp" %>
    <%
        } else {
    %>
      <%@ include file="../navbars/navbar_views_not_login.jsp" %>
    <%
        }
    %>

    <h1 style="text-align: center; font-size: 40px; padding-top: 30px">
        Portofolio
    </h1>

    <br>

    <%
        NumberFormat formatPrice = NumberFormat.getInstance();

        String userIdString = (String) session.getAttribute("userId");
        int userId = Integer.parseInt(userIdString);

        CompanyRepository companyRepository = new CompanyRepositoryImpl();
        InvestmentRepository investmentRepository = new InvestmentRepositoryImpl();

        List<Investment> investments = investmentRepository.getInvestmentByUserId(userId);

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss");  
    %>

    <% if(investments == null || investments.isEmpty()){ %>
        <div style="text-align: center;">
            <h4>You haven't make any investment yet, <a href="company_list.jsp">invest now</a></h4>
        </div>
    <% } else { %>
    <%
        int totalInvestment = 0;
        for (Investment investment : investments) {
            totalInvestment += investment.amount;
        }
    %>
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">
                                    Total Investasi Anda : Rp. <%= formatPrice.format(totalInvestment) %>
                                </h5>
                                <h6 class="card-subtitle mb-2 text-muted">
                                    Total investasi anda dalam perusahaan-perusahaan yang anda miliki.
                                </h6>
                                <p class="card-text">
                                    <%
                                        for(Investment investment : investments) {
                                            Company company = companyRepository.getCompanyById(investment.companyId);
                                            String strDate = dateFormat.format(investment.createdAt);
                                    %>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <b>
                                                <%= company.name %>
                                            </b>
                                        </div>
                                        <div class="col-md-3">
                                            <%= strDate %>
                                        </div>
                                        <div class="col-md-3">
                                            <%= investment.percentage %>%
                                        </div>
                                        <div class="col-md-3">
                                            Rp.<%= formatPrice.format(investment.amount) %>
                                        </div>
                                    </div>
                                    <%
                                        }
                                    %>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    <% } %>
</body>
</html>