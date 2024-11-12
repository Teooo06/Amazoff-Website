<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: macbookairm2
  Date: 24/10/24
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="icon" href="./images/social.png" type="image/x-icon">
    <title>updateProfilePage</title>
    <%@include file="connessione.jsp" %>
    <%

        String username = ((String) session.getAttribute("user")).replace("'", "");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String citta = request.getParameter("citta");
        String datanascita = request.getParameter("datanascita");
        String newPassword = request.getParameter("newPassword");
        username = username.replace("'", "''");
        password = password.replace("'", "''");
        nome = nome.replace("'", "''");
        cognome = cognome.replace("'", "''");
        citta = citta.replace("'", "''");

        // Controllo che i campi non siano nulli
        if (username != null && password != null && email != null && nome != null && cognome != null && citta != null && datanascita != null) {
            // Controllo che la vecchia password sia corretta
            String sql = "SELECT * FROM utenti WHERE username='" + username + "' AND password='" + password + "'";
            // uso verificaEsistente
            if (funzioni.verificaEsistente(sql)) {
                // Aggiorno il profilo
                sql = "UPDATE utenti SET email='" + email + "', nome='" + nome + "', cognome='" + cognome + "', citta='" + citta + "', datanascita='" + datanascita + "'";
                if (newPassword != null) {
                    sql += ", password='" + newPassword + "'";
                }
                sql += " WHERE username='" + username + "'";
                funzioni.update(sql);
                response.sendRedirect("modificaProfilo.jsp?conferma=Profilo aggiornato");
            } else {
                response.sendRedirect("modificaProfilo.jsp?messaggio=Password errata");
            }
        } else {
            response.sendRedirect("modificaProfilo.jsp?messaggio=Campi obbligatori mancanti");
        }


    %>

</head>
<body>

</body>
</html>
