<%--
  Created by IntelliJ IDEA.
  User: macbookairm2
  Date: 17/10/24
  Time: 08:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Riservata</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .card {
            height: 100%;
        }

        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
        <i class="fas fa-home"></i> Amazoff</a>
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
                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="modificaProfilo.jsp">Modifica Account</a>
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
<div class="container mt-5">
    <h1 class="text-center">Catalogo Dispositivi</h1>
    <%@include file="connessione.jsp" %>
    <div class="row">
        <%
            try {
                String query = "SELECT Descrizione, prezzo, id FROM prodotto";
                ResultSet rs=funzioni.select(query);

                int count = 0;
                while (rs.next()) {
                    String nome = rs.getString("Descrizione");
                    double prezzo = rs.getDouble("prezzo");
                    String immagineUrl = rs.getString("id");

                    if (count % 4 == 0 && count != 0) { %>
    </div><div class='row mt-4'>
    <% }

        count++;
    %>
    <div class="col-md-3">
        <div class="card h-100 d-flex flex-column">
            <div class="d-flex align-items-center justify-content-center" style="flex-grow: 1;">
                <img src="images/<%= immagineUrl %>.jpg" class="card-img-top" alt="<%= nome %>" style="max-height: 200px; object-fit: contain;">
            </div>
            <div class="card-body mt-auto text-center">
                <h5 class="card-title"><%= nome %></h5>
                <p class="card-text">€<%= String.format("%.2f", prezzo) %></p>
                <a href="addCarrello.jsp?id=<%= immagineUrl %>" class="btn btn-primary">Aggiungi al carrello</a>
            </div>

        </div>
    </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>

    <%
        String messaggio = request.getParameter("messaggio");
        if (messaggio != null) {
    %>
    <!-- Modale per il messaggio -->
    <!-- Modale per il messaggio -->
    <div class="modal fade" id="messaggioModal" tabindex="-1" aria-labelledby="messaggioModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="messaggioModalLabel">Notifica</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <%= messaggio %>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Script per aprire il modale automaticamente -->
    <script>
        // Assicurarsi che la pagina sia completamente caricata prima di aprire il modale
        document.addEventListener('DOMContentLoaded', function() {
            var myModal = new bootstrap.Modal(document.getElementById('messaggioModal'));
            myModal.show();
        });
    </script>
    <%
        }
    %>
</div>

<!-- Bootstrap JS e Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
