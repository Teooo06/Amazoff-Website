<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@include file="connessione.jsp" %>
    <title>Modifica Profilo</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="icon" href="./images/social.png" type="image/x-icon">

</head>
<body>
<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="riservato.jsp"><i class="fas fa-home"></i> Amazoff - Modifica Profilo</a>
        <!-- Pulsante carrello che apre la pagina carrello.jsp -->
        <a href="carrello.jsp" class="btn btn-outline-light ms-auto me-3" type="button" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Carrello">
            <i class="fas fa-shopping-cart fa-lg"></i>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="offcanvas offcanvas-end text-bg-dark" tabindex="-1" id="offcanvasDarkNavbar" aria-labelledby="offcanvasDarkNavbarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasDarkNavbarLabel">Opzioni</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                    <li class="nav-item">
                        <a class="nav-link" aria-current="page" href="riservato.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#">Modifica Account</a>
                    </li>
                    <li class="nav-item" >
                        <a class="nav-link" href="carrello.jsp" aria-disabled="true">Carrello</a>
                    </li>
                    <li class="nav-item" >
                        <a class="nav-link" href="storicoAcquisti.jsp" aria-disabled="true">Storico Acquisti</a>
                    </li>
                    <%
                        if(session.getAttribute("admin").equals("TRUE")) {
                    %>
                    <li class="nav-item">
                        <a class="nav-link " href="gestioneProdotti.jsp">Gestione Prodotti</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="gestioneUtenti.jsp">Gestione Utenti</a>
                    </li>
                    <%
                        }
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="form.jsp">Logout</a>


                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>


<!-- Spazio per evitare che la navbar copra il contenuto -->
<div style="height:80px"></div>

<!-- Container principale con due colonne -->
<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="card p-4" style="width: 100%;">
        <h1 class="text-center">Modifica il tuo profilo</h1>

        <form method="post" action="updateProfile.jsp">
            <div class="row">
                        <%
                        // ricavo il nome utente della sessione
                        String userNameSession = (String) session.getAttribute("user");
                        // tolgo "'" e metto ""
                        userNameSession = userNameSession.replace("'", "");

                        String nome = "";
                        String cognome = "";
                        String email = "";
                        String citta = "";
                        String datanascita = "";

                        // Ricavo i dati dell'utente
                        String sql = "SELECT * FROM utenti WHERE username='" + userNameSession + "'";
                        try {

                            ResultSet rs = funzioni.select(sql);
                            if (rs.next()) {
                                nome = rs.getString("nome");
                                cognome = rs.getString("cognome");
                                email = rs.getString("email");
                                citta = rs.getString("citta");
                                datanascita = rs.getString("datanascita");

                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        %>
                <!-- Prima colonna -->
                <div class="col-md-6">
                    <div class="form-floating mb-3">
                        <input type="text" name="username" class="form-control" id="floatingUsername" placeholder="Username" value="<%=userNameSession %>" required disabled>
                        <label for="floatingUsername">Username</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="cognome" class="form-control" id="floatingCognome" placeholder="Cognome" value="<%=cognome%>" required>
                        <label for="floatingCognome">Cognome</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="email" name="email" class="form-control" id="floatingEmail" placeholder="Email" value="<%=email%>" required>
                        <label for="floatingEmail">Email</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Vecchia Password" required>
                        <label for="floatingPassword">Vecchia Password</label>
                    </div>
                </div>

                <!-- Seconda colonna -->
                <div class="col-md-6">
                    <div class="form-floating mb-3">
                        <input type="text" name="nome" class="form-control" id="floatingNome" placeholder="Nome" value="<%=nome%>" required>
                        <label for="floatingNome">Nome</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" name="citta" class="form-control" id="floatingCitta" placeholder="Città" value="<%=citta%>" required>
                        <label for="floatingCitta">Città</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="date" name="datanascita" class="form-control" id="floatingDataNascita" placeholder="Data di Nascita" value="<%=datanascita%>" required>
                        <label for="floatingDataNascita">Data di Nascita</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" name="newPassword" class="form-control" id="floatingNewPassword" placeholder="Nuova Password">
                        <label for="floatingNewPassword">Nuova Password</label>
                    </div>
                </div>
            </div>

            <!-- Pulsante di submit -->
            <div class="d-flex justify-content-center mt-3">
                <input type="submit" value="Aggiorna Profilo" class="btn btn-dark w-50">
            </div>

            <!-- Messaggio di errore -->
            <%
                String messaggio = request.getParameter("messaggio");
                if (messaggio != null) {
                %>
                    <div class="alert alert-danger" role="alert" style="margin-top: 5px">
                        <%=messaggio%>
                    </div>
                <%
            }%>

            <!-- Messaggio di conferma -->
            <%
                String conferma = request.getParameter("conferma");
                if (conferma != null) {
                %>
                    <div class="alert alert-success" role="alert" style="margin-top: 5px">
                        <%=conferma%>
                    </div>
                <%
            }%>

        </form>
    </div>
</div>


<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>