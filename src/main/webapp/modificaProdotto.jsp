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
    String id = request.getParameter("id");
    String descrizione = request.getParameter("descrizione");
    String categoria = request.getParameter("categoria");
    double prezzo = 0.0;

    if (request.getParameter("prezzo") != null) {
        prezzo = Double.parseDouble(request.getParameter("prezzo"));
    }

    String redirectUrl = "gestioneProdotti.jsp";  // Pagina di reindirizzamento
    String message = "";  // Messaggio da visualizzare

    if ("save".equals(action)) {
        // Logica per salvare le modifiche del prodotto
        try {
            String sql = "UPDATE prodotto SET descrizione = '" + descrizione + "', categoria = '" + categoria + "', prezzo = '" + prezzo + "' WHERE id = '" + id + "'";
            Boolean resul = funzioni.update(sql);

            if (resul) {
                message = "Prodotto modificato con successo!";
            } else {
                message = "Errore durante la modifica del prodotto";
            }
        } catch (Exception e) {
            message = "Errore durante la modifica del prodotto: " + e.getMessage();
        }
    } else if ("delete".equals(action)) {
        // Logica per eliminare il prodotto usando il metodo delete
        try {
            String sql = "DELETE FROM prodotto WHERE `prodotto`.`id` = '" + id + "'";
            Boolean result = funzioni.delete(sql);
            if (result) {
                message = "Prodotto eliminato con successo!";
            } else {
                message = "Errore durante l'eliminazione del prodotto";
            }
        } catch (Exception e) {
            message = "Errore durante l'eliminazione del prodotto: " + e.getMessage();
        }
    }  else if ("add".equals(action)) {
        // Logica per aggiungere un nuovo prodotto
        try {

            // Devo controllare che i campi non siano vuoti e che il prezzo sia maggiore di 0 e che id non sia già presente
            if (descrizione == null || categoria == null || prezzo <= 0) {
                message = "Errore: descrizione, categoria e prezzo sono campi obbligatori";
            } else {
                boolean presente = funzioni.verificaEsistente( "SELECT * FROM prodotto WHERE id = '" + id + "'");
                if (presente) {
                    message = "Errore: id già presente";
                } else {
                    String sql = "INSERT INTO prodotto (id, descrizione, categoria, prezzo) VALUES ('" + id + "', '" + descrizione + "', '" + categoria + "', '" + prezzo + "')";

                    Boolean result = funzioni.update(sql);
                    if (result) {
                        message = "Prodotto aggiunto con successo!";
                    } else {
                        message = "Errore durante l'aggiunta del prodotto";
                    }
                }
            }
        } catch (Exception e) {
            message = "Errore durante l'aggiunta del prodotto: " + e.getMessage();
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