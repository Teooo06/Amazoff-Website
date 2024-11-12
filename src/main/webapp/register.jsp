<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet" %>
<%@include file="connessione.jsp" %>

<html>
<head>
    <title>Registration Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="./images/social.png" type="image/x-icon">
</head>
<body>

<div class="container-fluid d-flex justify-content-center align-items-center vh-100">
    <div style="max-width: 600px; width: 100%;">
        <h1 class="text-center">Registration Page</h1>
        <br>
        <form method="post" action="register.jsp">
            <div class="input-group mb-3">
                <span class="input-group-text">First and last name</span>
                <input type="text" aria-label="First name" class="form-control" name="nome" required>
                <input type="text" aria-label="Last name" class="form-control" name="cognome" required>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text" id="inputGroup-sizing-default">Username</span>
                <input type="text" aria-label="Username" name="username" class="form-control" required>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Password</span>
                <input type="password" aria-label="Password" name="password" class="form-control" required>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Email</span>
                <input type="email" aria-label="Email" name="email" class="form-control" required>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Data di nascita</span>
                <input type="date" aria-label="DataDiNascita" name="datanascita" class="form-control" required>
            </div>
            <div class="input-group mb-3">
                <span class="input-group-text">Città</span>
                <input type="text" aria-label="Città" name="citta" class="form-control" required>
            </div>
            <div class="d-grid gap-2">
                <input type="submit" value="Registrati" class="btn btn-outline-primary">
            </div>
        </form>

        <%
            boolean flag = false;
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String nome = request.getParameter("nome");
                String cognome = request.getParameter("cognome");
                String email = request.getParameter("email");
                String citta = request.getParameter("citta");
                String dataNascitaString = request.getParameter("datanascita");
                java.sql.Date dataNascita = java.sql.Date.valueOf(dataNascitaString);

                // Controllo che tutti i campi siano compilati
                if (username != null && password != null && nome != null && cognome != null && email != null && dataNascita != null && citta != null) {
                    // Verifica se l'utente esiste già
                    String query = "SELECT * FROM utenti WHERE username='" + username + "'";

                    // Uso funzioni.verificaEsistente(query); che restituisce true se l'utente esiste già
                    if (funzioni.verificaEsistente(query)) {
                        %>  <p class="text-danger text-center">ERRORE: Utente già esistente!</p>    <%
                    } else {
                        // Preparo i campi e i valori per l'inserimento dell'utente
                        String[] campi = {"username", "password", "nome", "cognome", "email", "datanascita", "citta", "admin"};
                        String[] valori = {"'" + username + "'", "'" + password + "'", "'" + nome + "'", "'" + cognome + "'", "'" + email + "'" , "'" + dataNascita + "'", "'" + citta + "'", "0"};
                        String tabella = "utenti";
                        boolean inserimento = true;
                        boolean codiceAutoIncrement = false;  // Se non c'è un campo auto-increment

                        // Eseguo l'inserimento nel database
                        if (funzioni.update(campi, valori, tabella, inserimento, codiceAutoIncrement)) {
                            // Scrivo un messaggio di successo e invio l'utente alla pagina di login dopo 2 secondi
                            %>  <p class="text-success text-center">Registrazione avvenuta con successo!</p>
                                <p class="text-success text-center">Sarai reindirizzato alla pagina di login tra 2 secondi...</p><%
                            flag = true;

                        } else {
                            %>  <p class="text-danger text-center">Errore durante la registrazione. Riprovare.</p>  <%
                        }
                    }
                } else {
                    %>
                    <p class="text-danger text-center">ERRORE: Compila tutti i campi!</p>
                    <%
                }
            }
            if (flag) {
                response.setHeader("Refresh", "2; URL=form.jsp");
            }
        %>
    </div>
</div>
</body>
</html>
