<!DOCTYPE html>
<html>
  <head>
   <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Contact Us | Temu Saham</title>
    <link rel="stylesheet" href="../styles/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  </head>

  <body>

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

    <div class="container d-flex flex-column h-75 justify-content-center align-items-center">
        <div class="col-md-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Contact Us</h5>
              <p class="card-text">
              <h6>Address</h6>
              <p>Jl. Raya Kb. Jeruk No.27, RW.9, Kb. Jeruk, Kec. Kb. Jeruk, Kota Jakarta Barat, Daerah Khusus Ibukota
                Jakarta 11530</p>
              <h6>Phone</h6>
              <p>(021) 5345830</p>
              <h6>Email</h6>
              <p>
                <a href="mailto: contact@temusaham.com">contact@temusaham.com</a>
              </p>
            </div>
          </div>
        </div>

        <div class="col-md-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Our Sponsors</h5>
              <p class="card-text">
                <img src="../assets/partner1.png" alt="partner-1" width="75" height="75">
                <img src="../assets/partner3.png" alt="partner-3" width="75" height="75">
              </p>
            </div>
          </div>
        </div>
      </div>
    
    <%@ include file="../footers/footer_with_fixed_bottom.jsp" %>

  </body>
</html>
