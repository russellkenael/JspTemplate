<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Company List | Temu Saham</title>
    <link rel="stylesheet" href="../styles/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
    <%@ include file="../models/User.jsp" %>

    <%@ include file="../repositories/company_repository_impl.jsp" %>

    <%@ include file="../instances/temu_saham_db_instance.jsp" %>

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
        Company List
    </h1>

    <%
        String searchQuery = request.getParameter("searchBar");
        if(searchQuery == null) searchQuery = new String();
        
        CompanyRepository companyRepository = new CompanyRepositoryImpl();
        List<Company> companies = companyRepository.getCompanyListByKeyword(searchQuery);
    %>

    <br>
    
    <form action="company_list.jsp" method="get" name="SearchCompany" onsubmit="return(validateSearch())">
        <div class="input-group" style="padding-left: 40px; padding-right: 40px;">
            <input type="text" class="form-control" name="searchBar" placeholder="Company Name">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="submit"><i class="fas fa-search"></i></button>
            </div>
        </div>
    </form>

    <br>

    <% if(companies == null || companies.isEmpty()){ %>
        <h1 style="text-align: center; font-size: 30px; padding-top: 30px">
            No Result Found
        </h1>
    <% } else { %>
    <%
        int itemPerRow = 4;
        int rowCount = companies.size() / itemPerRow;
        int lastRowCount = companies.size() % itemPerRow;
        if (lastRowCount > 0) {
          rowCount++;
        }

        int itemIndex = 0;

        for (int i = 0; i < rowCount; i++) {
        if (i == (rowCount - 1) && lastRowCount > 0) {
            itemPerRow = lastRowCount;
        }
    %>
        <div class="row" style="padding-left: 40px; padding-right: 40px;">
    <%
        for (int j = 0; j < itemPerRow; j++) {
            Company company = companies.get(itemIndex);
    %>
            <div class="col-md-3">
                <div class="card">
                    <img src="<%= company.image %>" class="card-img-top" alt="...">
                    <div class="card-body">
                      <h5 class="card-title"><%= company.name %> (<%= company.categoryName %>) </h5>
                      <p class="card-text"><b><%= company.location %></b></p>
                      <p class="card-text"><%= company.description %></p>
                      <p class="card-text">Investment Progress: <b><%= (company.fulfilledPercentage / company.investmentStock) * 100 %>%</b></p>
                      <div class="progress">
                        <div class="progress-bar bg-info progress-bar-striped progress-bar-animated" role="progressbar" style="width: <%= (company.fulfilledPercentage / company.investmentStock) * 100 %>%"  aria-valuenow="<%= (company.fulfilledPercentage / company.investmentStock) * 100 %>" aria-valuemin="0" aria-valuemax="100"></div>
                      </div>
                      <br> <br>
                      <a href="company_detail.jsp?companyId=<%= company.id %>" class="btn btn-primary">See More</a>
                    </div>
                </div>
            </div>
    <%
        itemIndex++;
    }
    %>
        </div>
        <br>
        <% } %>   
    <% } %>

    <br>
    
    <script>
        function validateSearch(){
            return true;
        }
    </script>
</body>
</html>