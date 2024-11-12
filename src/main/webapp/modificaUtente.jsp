<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="connessione.jsp" %>
<html>
<head>
    <title>Gestione Prodotti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Puoi aggiungere il tuo CSS personalizzato qui */
    </style>
    <link rel="icon" href="./images/social.png" type="image/x-icon">

</head>
<body>
<%
    String action = request.getParameter("action");
    String password = request.getParameter("password");
    String nome = request.getParameter("nome");
    String cognome = request.getParameter("cognome");
    String email = request.getParameter("email");
    String datanascita = request.getParameter("datanascita");
    String citta = request.getParameter("citta");
    String admin = request.getParameter("admin");
    String username = request.getParameter("username");
    username = username.replace("'", "''");
    password = password.replace("'", "''");
    nome = nome.replace("'", "''");
    cognome = cognome.replace("'", "''");
    citta = citta.replace("'", "''");

    if ("on".equals(admin)) {
        admin = "1";
    } else {
        admin = "0";
    }

    String redirectUrl = "gestioneUtenti.jsp";  // Pagina di reindirizzamento
    String message = "";  // Messaggio da visualizzare

    if ("save".equals(action)) {
        // Logica per salvare le modifiche del prodotto
        try {
            String sql = "UPDATE utenti SET password = '" + password +
                    "', nome = '" + nome +
                    "', cognome = '" + cognome +
                    "', email = '" + email +
                    "', datanascita = '" + datanascita +
                    "', citta = '" + citta +
                    "', admin = '" + admin +
                    "' WHERE username = '" + username + "'";
            Boolean resul = funzioni.update(sql);

            if (resul) {
                message = "Utente modificato con successo!";
            } else {
                message = "Errore durante la modifica dell'utente";
            }
        } catch (Exception e) {
            message = "Errore durante la modifica dell'utente : " + e.getMessage();
        }
    } else if ("delete".equals(action)) {
        // Logica per eliminare il prodotto usando il metodo delete
        try {
            String sql = "DELETE FROM utenti WHERE username = '" + username + "'";
            Boolean result = funzioni.delete(sql);
            if (result) {
                message = "Utente eliminato con successo!";
            } else {
                message = "Errore durante l'eliminazione dell'utente";
            }
        } catch (Exception e) {
            message = "Errore durante l'eliminazione dell'utente: " + e.getMessage();
        }
    }
    // Reindirizza alla pagina gestioneProdotti.jsp con il messaggio come parametro
    response.sendRedirect(redirectUrl + "?message=" + message);
%>


<!-- Bootstrap JS e Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>