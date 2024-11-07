<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: macbookairm2
  Date: 24/10/24
  Time: 22:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="connessione.jsp" %>
<html>
<head>
    <title>Storico Acquisti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .table-rounded {
            border-radius: 0.5rem; /* Arrotondamento dei bordi */
            overflow: hidden; /* Evita che il contenuto esca dai bordi arrotondati */
        }
    </style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="riservato.jsp"><i class="fas fa-home"></i> Amazoff - Storico Acquisti</a>
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
                        <a class="nav-link" href="modificaProfilo.jsp">Modifica Account</a>
                    </li>
                    <li class="nav-item" >
                        <a class="nav-link" href="carrello.jsp" >Carrello</a>
                    </li>
                    <li class="nav-item" >
                        <a class="nav-link active" href="#" >Storico Acquisti</a>
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


<%
    // ricavo il nome utente della sessione
    String userNameSession = (String) session.getAttribute("user");
// tolgo "'" e metto ""
    userNameSession = userNameSession.replace("'", "");

%>
<!-- Spazio per evitare che la navbar copra il contenuto -->
<div style="height:80px"></div>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
    <div class="card p-4" style="width: 60%;">
        <h3>Storico acquisti di <%= userNameSession %></h3>

        <!-- Creazione della tabella per mostrare i prodotti -->
        <table class="table table-bordered table-rounded mt-3">
            <thead class="table-dark">
            <tr>
                <th style="width: 50px;"></th>
                <th>Prodotto</th>
                <th>Prezzo</th>
                <th style="width: 130px;">Data Acquisto</th>
            </tr>
            </thead>
            <tbody>
            <%
                // Connessione al database (personalizza i parametri di connessione)
                try {

                    // Query per ottenere i prodotti nel carrello dell'utente
                    String sql = "SELECT idProdotto, data, costo FROM acquisti WHERE username = '" + userNameSession + "'";
                    ResultSet rs = funzioni.select(sql);

                    // Loop per ogni prodotto nel carrello
                    while (rs.next()) {
                        String nomeFoto = rs.getString("idProdotto") + ".jpg";
                        String dataAcquisto = rs.getString("data");
                        String sql1 = "SELECT descrizione FROM prodotto WHERE id = '" + rs.getString("idProdotto") + "'";
                        ResultSet rs2 = funzioni.select(sql1);
                        rs2.next();
                        String nomeProdotto = rs2.getString("descrizione");
                        int costo = rs.getInt("costo");

            %>
            <tr>
                <td><img src="images/<%= nomeFoto %>" alt="Immagine prodotto" style="max-width: 100px; max-height: 100px; object-fit: contain;"></td>
                <td><%= nomeProdotto %></td>
                <td>€<%= costo %></td>
                <td><%= dataAcquisto %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            </tbody>
        </table>
    </div>
</div>






<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
