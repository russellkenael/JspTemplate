<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home | Temu Saham</title>
    <link rel="stylesheet" href="styles/style.css" />
    <link rel="stylesheet" href="styles/home_style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  </head>
  <body>
  <%@ include file="instances/temu_saham_db_instance.jsp" %>

  <%
    TemuSahamDbInstance.initDatabase();

    String id = (String) session.getAttribute("userId");
    String type = (String) session.getAttribute("userType");

    if (id != null && type != null && !id.isEmpty() && type.equals("investor")) {
  %>
    <%@ include file="navbars/navbar_home_investor.jsp" %>
  <%
    } else if (id != null && type != null && !id.isEmpty() && type.equals("owner")) {
  %>
    <%@ include file="navbars/navbar_home_owner.jsp" %>
  <%
    } else {
  %>
    <%@ include file="navbars/navbar_home_not_login.jsp" %>
  <%
    }
  %>

  <div class="bg-image"></div>

  <div class="d-flex flex-column h-75 justify-content-center align-items-center bg-text">
      <h2>Investasi Mulai dari Rp 10,000</h2>
      <p>Mulai Investasi Sekarang</p>
      <button onclick="location.href='views/company_list.jsp'" class="btn btn-primary">Pelajari Lebih Lanjut</button>
  </div>

  <%@ include file="footers/footer_with_fixed_bottom.jsp" %>
  </body>
</html>