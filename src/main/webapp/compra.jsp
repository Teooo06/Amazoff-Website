<%--
  Created by IntelliJ IDEA.
  User: macbookairm2
  Date: 31/10/24
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ include file="connessione.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Compra</title>
    <link rel="icon" href="./images/social.png" type="image/x-icon">

</head>
<body>
<%
    String userNameSession = (String) session.getAttribute("user");
    userNameSession = userNameSession.replace("'", "");  // Sanifica il nome utente

    try {
        // Ottieni tutti gli articoli dal carrello dell'utente
        String querySelect = "SELECT idProdotto, data, costo FROM carrello WHERE username = '" + userNameSession + "'";
        ResultSet rs = funzioni.select(querySelect);

        // Inserisci gli articoli nella tabella acquisti e poi rimuovili dal carrello
        while (rs.next()) {
            String idProdotto = rs.getString("idProdotto");
            String dataAcquisto = rs.getString("data");
            int costo = rs.getInt("costo");

            // Query per inserire l'articolo nella tabella acquisti
            String queryInsert = "INSERT INTO acquisti (username, idProdotto, data, costo) VALUES ('" + userNameSession + "', '" + idProdotto + "', '" + dataAcquisto + "', " + costo + ")";
            funzioni.update(queryInsert);

            // Query per rimuovere l'articolo dal carrello
            String queryDelete = "DELETE FROM carrello WHERE username = '" + userNameSession + "' AND idProdotto = '" + idProdotto + "'";
            funzioni.update(queryDelete);
        }

        // Redirect a carrello.jsp con messaggio di conferma
        response.sendRedirect("carrello.jsp?acquisto=successo");

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("carrello.jsp?acquisto=errore");
    }
%>
</body>
</html>