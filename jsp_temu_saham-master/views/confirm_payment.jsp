<%@ page import = "java.text.NumberFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Confirm Payment | Temu Saham</title>
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
        NumberFormat formatPrice = NumberFormat.getInstance();

        String companyId = request.getParameter("companyId");

        CompanyRepository companyRepository = new CompanyRepositoryImpl();
        Company company = companyRepository.getCompanyById(Integer.parseInt(companyId));
    
        Long investmentNominal = Long.parseLong(request.getParameter("investmentNominal"));
        Double stockReceived = Double.valueOf(investmentNominal) / Double.valueOf(company.investmentTarget) * Double.valueOf(company.investmentStock);
    %>
    <section>
        <div class="checkout">
            <h1 style="text-align: center; font-size: 40px; padding-top: 30px;">Confirm Payment</h1>
            <form action="../controllers/confirm_payment_controller.jsp" method="post" name="confirmPaymentForm" onsubmit="return validateConfirmPayment()">
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
                    <label for="nominal">Investment Nominal (in IDR)</label>
                    <input type="text" name="investmentNominal" value="<%= formatPrice.format(investmentNominal) %>" readonly> 
                </div>

                <div class="form_input">
                    <label for="received">Stock Received (in percent)</label>
                    <input type="text" name="stockReceived" value="<%= stockReceived %>" readonly> 
                </div>

                <br>   
                <input type='button' value="Cancel">
                <input type="submit" id="pay" value="Pay">
            </form>
        </div>
    </section>
    <script>        
        const cancelButton = document.querySelector('input[type="button"]');
        cancelButton.addEventListener('click', function() {
            window.location.href = "../views/checkout_payment.jsp?companyId=" + <%= companyId %>;
        });

        function validateConfirmPayment() {
            let confirmPayment = confirm("Are you sure you want to invest?");
            if(confirmPayment) {
                alert("Investment successful");
                return true;
            } else {
                return false;
            }
        }
    </script>
</body>
</html>