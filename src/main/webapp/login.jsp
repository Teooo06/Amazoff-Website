<%@ page import="java.sql.ResultSet" %>

<%--
  Created by IntelliJ IDEA.
  User: macbookairm2
  Date: 17/10/24
  Time: 08:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel="icon" href="./images/social.png" type="image/x-icon">

</head>
<body>
    <h1>Pagina di recupero parametri</h1>
    <%@include file="connessione.jsp" %>
    <%
        String username=request.getParameter("username");
        String password=request.getParameter("password");

        username=funzioni.fc(username);
        password=funzioni.fc(password);
        String sql="SELECT * FROM utenti WHERE username="+username+" AND PASSWORD="+password;

        //apertura connessione ed esecuzione query

        ResultSet rs=funzioni.select(sql);

        if(rs.next()) {
            //accesso autorizzato
            session.setAttribute("user", username);

            String admin = rs.getString("admin");
            if (admin.equals("1")) {
                session.setAttribute("admin", "TRUE");
            } else {
                session.setAttribute("admin", "FALSE");
            }

            response.sendRedirect("riservato.jsp");
        }else{
            //accesso negato
            response.sendRedirect("form.jsp?messaggio=Credenziali errate");
        }

    %>
</body>
</html>
