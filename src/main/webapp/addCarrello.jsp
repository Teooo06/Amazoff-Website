<%--
  Created by IntelliJ IDEA.
  User: macbookairm2
  Date: 30/10/24
  Time: 23:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%@include file="connessione.jsp" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
    // Ottieni l'id del prodotto passato come parametro
    String id = request.getParameter("id");

    // ricavo il nome utente della sessione
    String userNameSession = (String) session.getAttribute("user");
    // tolgo "'" e metto ""
    userNameSession = userNameSession.replace("'", "");


    // Recupera le informazioni del prodotto dalla tabella 'prodotto'
    String sql = "SELECT * FROM prodotto WHERE id='" + id + "'";
    ResultSet rs = funzioni.select(sql);
    if(rs.next()){
        String descrizione = rs.getString("descrizione");
        String prezzo = rs.getString("prezzo");
        String idProdotto = rs.getString("id");

        // Inserisci il prodotto nel carrello
        String sql2 = "INSERT INTO carrello (username, idProdotto, data, costo) VALUES (" +"'" +
                userNameSession + "', '" +
                idProdotto + "', NOW(), '" +
                prezzo + "')";
        Boolean conferma = funzioni.update(sql2);
        if (conferma) {
            response.sendRedirect("riservato.jsp?messaggio="+descrizione+" aggiunto al carrello");
        } else {
            response.sendRedirect("riservato.jsp?messaggio=Errore nell'aggiunta del prodotto "+descrizione+" al carrello");
        }
    } else {
        response.sendRedirect("riservato.jsp?messaggio=Errore nel recupero del prodotto");
    }

%>

</body>
</html>
