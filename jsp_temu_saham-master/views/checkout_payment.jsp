<%@ page import = "java.text.NumberFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Checkout Payment | Temu Saham</title>
    <link rel="stylesheet" href="../styles/checkout_style.css">
    <link rel="stylesheet" href="../styles/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%@ include file="../repositories/company_repository_impl.jsp" %>
    <%@ include file="../repositories/user_repository_impl.jsp" %>

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

    <%
        NumberFormat formatPrice = NumberFormat.getInstance();

        String companyId = request.getParameter("companyId");

        CompanyRepository companyRepository = new CompanyRepositoryImpl();
        Company company = companyRepository.getCompanyById(Integer.parseInt(companyId));
    %>
    <section>
        <div class="checkout">
            <h1 style="text-align: center; font-size: 40px; padding-top: 30px;">Checkout Payment</h1>
            <form action="confirm_payment.jsp" method="post" name="checkoutPaymentForm" onsubmit="return validateCheckoutPayment()">
                <input type="hidden" name="companyId" value="<%= companyId %>">
                <div class="form_input">
                    <label for="name">Company Name</label>
                    <input type="text" name="companyName" value="<%= company.name %>" readonly> 
                </div>

                <div class="form_input">
                    <label for="target">Investment Target (in IDR)</label>
                    <input type="text" name="investmentTarget" value="<%= formatPrice.format(company.investmentTarget) %>" readonly> 
                </div>

                <div class="form_input">
                    <label for="remaining">Remaining Investment Needed (in IDR)</label>
                    <input type="text" name="remainingInvestmentNeeded" value="<%= formatPrice.format(company.investmentTarget - company.investedAmount) %>" readonly> 
                </div>

                <div class="form_input">
                    <label for="stock">Investment Stock for Full Investment Target (in percentage)</label>
                    <input type="text" name="investmentStock" value="<%= company.investmentStock %>" readonly> 
                </div>

                <div class="form_input">
                    <label for="nominal">Investment Nominal (in IDR, without separator)</label>
                    <%
                        if(request.getParameter("investmentNominal") != null) {
                            %>
                            <input type="number" name="investmentNominal" value="<%= request.getParameter("investmentNominal") %>" min="10000" step="10000" max="<%= company.investmentTarget - company.investedAmount %>">
                        <%
                        } else {
                            %>
                            <input type="number" name="investmentNominal" placeholder="Your investment... (multiple of 10000)" min="10000" step="10000" max="<%= company.investmentTarget - company.investedAmount %>">
                        <%
                        }
                    %>
                </div>

                <br>

                <input type='button' value="Cancel">
                <input type="submit" id="next" value="Next">
            </form>
        </div>
    </section>
    <script>
        const cancelButton = document.querySelector('input[type="button"]');
        cancelButton.addEventListener('click', function() {
            window.location.href = "../views/company_detail.jsp?companyId=" + <%= companyId %>;
        });

        function validateCheckoutPayment() {
            let investmentNominal = document.forms["checkoutPaymentForm"]["investmentNominal"].value;

            if(investmentNominal == "") {
                alert("Investment nominal must not be empty");
                return false;
            } else {
                return true;
            }
        }
    </script>
</body>
</html>