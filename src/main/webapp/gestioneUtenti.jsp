<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: macbookairm2
  Date: 6/11/24
  Time: 23:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="connessione.jsp" %>
<html>
<head>
    <title>Gestione Utenti</title>
    <link rel="icon" href="./images/social.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .table-rounded {
            border-radius: 0.5rem;
            overflow: hidden;
        }

        .no-space {
            display: flex;
            gap: 0;
            padding: 0;
            margin: 0;
        }
        .no-space .btn {
            flex-grow: 1;
            padding: 0.375rem 0.75rem; /* Dimensioni standard Bootstrap */
            margin-right: 10px; /* Aggiunge spazio tra i bottoni */
        }
        .no-space .btn:last-child {
            margin-right: 0; /* Rimuove il margine a destra dall'ultimo bottone */
        }
        .password-group .toggle-btn {
            height: 100%; /* Rende il pulsante della stessa altezza dell'input */
            border-radius: 0 0.25rem 0.25rem 0; /* Angoli arrotondati solo a destra */
            padding: 0.375rem 0.75rem; /* Spaziatura simile all'input */
        }

        .password-group .form-control {
            border-radius: 0.25rem 0 0 0.25rem; /* Angoli arrotondati solo a sinistra */
        }

        .password-group .input-group-append {
            display: flex;
            align-items: center; /* Allinea l'icona verticalmente */
        }

        .custom-checkbox {
            width: 20px; /* Aumenta la dimensione del checkbox */
            height: 20px; /* Aumenta la dimensione del checkbox */
        }

        /* Centra verticalmente */
        td {
            vertical-align: middle;
        }

        .cropped-image {
            width: 75%; /* Rende l'immagine più larga rispetto al contenitore */
            height: 200px; /* Imposta l'altezza per creare il ritaglio */
            object-fit: cover; /* Ritaglia l'immagine in modo uniforme sopra e sotto */
            object-position: center; /* Mantiene il centro dell'immagine al centro del contenitore */
            border-radius: 1.5rem; /* Aggiungi questo per arrotondare i bordi */
            padding: 10px;
        }
    </style>
</head>
<body>
<%
    // Controllo che l'utente sia amministratore
    if (session.getAttribute("admin") == null || !session.getAttribute("admin").equals("TRUE")) {
        response.sendRedirect("form.jsp?messaggio=Devi effettuare il login come amministratore per accedere a questa pagina");
    }

    int rowIndex = 0; // Inizializza l'indice di riga

%>
    <nav class="navbar navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="riservato.jsp"><i class="fas fa-home"></i> Amazoff - Gestione Utenti</a>
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
                            <a class="nav-link" href="carrello.jsp" aria-disabled="false">Carrello</a>
                        </li>
                        <li class="nav-item" >
                            <a class="nav-link" href="storicoAcquisti.jsp" aria-disabled="true">Storico Acquisti</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="gestioneProdotti.jsp">Gestione Prodotti</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Gestione Utenti</a>
                        </li>
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
        <h3>Gestione Utenti</h3>


        <!-- Tabella per la modifica dei prodotti -->
        <table class="table table-bordered table-rounded mt-3">
            <thead class="table-dark">
            <tr>
                <th style="width: 8%;">Username</th>
                <th style="width: 12%;">Password</th>
                <th style="width: 10%;">Cognome</th>
                <th style="width: 10%;">Nome</th>
                <th style="width: 10%;">Città</th>
                <th style="width: 5%;">Data di nascita</th> <!-- Colonna data ridotta -->
                <th style="width: 20%;">Email</th> <!-- Colonna email più ampia -->
                <th style="width: 5%;">Admin</th>
                <th style="width: 5%;">Azione</th>
            </tr>
            </thead>
            <tbody>
            <%
                String query = "SELECT * FROM utenti";
                ResultSet rs = funzioni.select(query);
                while (rs.next()) { // Esempio di ciclo per generare ogni riga da ResultSet
                    rowIndex++; // Incrementa l'indice per ciascuna riga
            %>
            <form action="modificaUtente.jsp" method="post">
                <tr>
                    <td><input type="text" class="form-control" name="username" value="<%= rs.getString("username") %>" readonly></td>
                    <td>
                        <div class="input-group password-group">
                            <input type="password" class="form-control" name="password" id="passwordField<%= rowIndex %>" value="<%= rs.getString("password") %>">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-outline-secondary toggle-btn" onclick="togglePasswordVisibility(<%= rowIndex %>)">
                                    <i class="fa fa-eye" id="toggleIcon<%= rowIndex %>"></i>
                                </button>
                            </div>
                        </div>
                    </td>
                    <td><input type="text" class="form-control" name="cognome" value="<%= rs.getString("cognome") %>"></td>
                    <td><input type="text" class="form-control" name="nome" value="<%= rs.getString("nome") %>"></td>
                    <td><input type="text" class="form-control" name="citta" value="<%= rs.getString("citta") %>"></td>
                    <td><input type="date" class="form-control" name="datanascita" value="<%= rs.getString("datanascita") %>"></td>
                    <td><input type="text" class="form-control" name="email" value="<%= rs.getString("email") %>"></td>
                    <td style="text-align: center;">
                        <%
                            boolean admin = rs.getBoolean("admin");

                            if (admin) {
                                %><input type="checkbox" class="form-check-input custom-checkbox" name="admin" checked >
                        <%
                            } else {
                                %><input type="checkbox" class="form-check-input custom-checkbox" name="admin" >
                        <%
                            }
                        %>

                    </td>
                    <td class="no-space">
                        <button type="submit" class="btn btn-success" name="action" value="save">Salva</button>
                        <button type="submit" class="btn btn-danger" name="action" value="delete" onclick="return confirm('Sei sicuro di voler eliminare questo prodotto?');">Elimina</button>
                    </td>
                </tr>
            </form>
            <%
                }
            %>
            </tbody>
        </table>
        <div class="card container" >
            <div class=" container d-flex justify-content-center align-items-center w-75" >
                <div class="row g-0">
                    <div class="col-8 d-flex align-items-center">
                        <div class="card-body">
                            <h5 class="card-title">Aggiungi un nuovo utente</h5>
                            <p class="card-text">Per inserire un nuovo utente, clicca il pulsante sotto e sarai indirizzato alla pagina di registrazione.</p>
                            <div class="d-flex justify-content-center">
                                <a href="register.jsp" class="btn btn-primary w-100">Vai alla registrazione</a> <!-- Bottone allungato -->
                            </div>
                        </div>
                    </div>
                    <div class="col-4 d-flex align-items-center justify-content-center">
                        <img src="./images/utenti.png" class="card-img-top cropped-image" alt="Immagine utente">
                    </div>
                </div>
            </div>

        </div>
    </div>

<!-- Modale di conferma -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="confirmModalLabel">Conferma Operazione</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalMessage">
                <!-- Il messaggio sarà inserito dinamicamente tramite JavaScript -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary w-100" data-bs-dismiss="modal">Chiudi</button>
            </div>
        </div>
    </div>
</div>

    <!-- Bootstrap JS e Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Funzione per visualizzare il messaggio nel modale
        function showConfirmation(message) {
            document.getElementById("modalMessage").innerHTML = message;  // Imposta il messaggio nel modale
            var myModal = new bootstrap.Modal(document.getElementById('confirmModal')); // Inizializza il modale
            myModal.show();  // Mostra il modale
        }

        // Verifica se c'è un messaggio di conferma da visualizzare
        <%
            String message = request.getParameter("message");
            if (message != null) {
        %>
        showConfirmation("<%= message %>");  // Mostra il messaggio passato come parametro
        <%
            }
        %>

        function togglePasswordVisibility(rowIndex) {
            console.log("Toggling password visibility for row " + rowIndex); // Aggiungi un log per la verifica

            const passwordField = document.getElementById("passwordField" + rowIndex);
            const toggleIcon = document.getElementById("toggleIcon" + rowIndex);

            if (passwordField && toggleIcon) {
                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    toggleIcon.classList.remove("fa-eye");
                    toggleIcon.classList.add("fa-eye-slash");
                } else {
                    passwordField.type = "password";
                    toggleIcon.classList.remove("fa-eye-slash");
                    toggleIcon.classList.add("fa-eye");
                }
            } else {
                console.log("Could not find password field or toggle icon for row " + rowIndex);
            }
        }
</script>
</body>
</html>
