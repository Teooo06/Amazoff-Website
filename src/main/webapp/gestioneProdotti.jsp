<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="connessione.jsp" %>
<html>
<head>
    <title>Gestione Prodotti</title>
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
    </style>
</head>
<body>
<%
// Controllo che l'utente sia amministratore
if (session.getAttribute("admin") == null || !session.getAttribute("admin").equals("TRUE")) {
    response.sendRedirect("form.jsp?messaggio=Devi effettuare il login come amministratore per accedere a questa pagina");
}
%>
<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="riservato.jsp"><i class="fas fa-home"></i> Amazoff - Gestione Prodotti</a>
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
                        <a class="nav-link active" href="#">Gestione Prodotti</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " href="gestioneUtenti.jsp">Gestione Utenti</a>
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
    <h3>Gestione Prodotti</h3>


    <!-- Tabella per la modifica dei prodotti -->
    <table class="table table-bordered table-rounded mt-3">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Descrizione</th>
            <th>Prezzo</th>
            <th>Categoria</th>
            <th>Azione</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Query per ottenere tutti i prodotti
            try {
                String query = "SELECT * FROM prodotto";
                ResultSet rs = funzioni.select(query);

                // Loop per visualizzare tutti i prodotti
                while (rs.next()) {
                    String id = rs.getString("id");
                    String descrizione = rs.getString("descrizione");
                    double prezzo = rs.getDouble("prezzo");
                    String categoria = rs.getString("categoria");
        %>
        <form action="modificaProdotto.jsp" method="post">
            <tr>
                <td><input type="text" class="form-control" name="id" value="<%= id %>" readonly></td>
                <td><input type="text" class="form-control" name="descrizione" value="<%= descrizione %>"></td>
                <td><input type="number" class="form-control" name="prezzo" step="0.01" value="<%= prezzo %>"></td>
                <td><input type="text" class="form-control" name="categoria" value="<%= categoria %>"></td>
                <td class="no-space">
                    <button type="submit" class="btn btn-success" name="action" value="save">Salva</button>
                    <button type="submit" class="btn btn-danger" name="action" value="delete" onclick="return confirm('Sei sicuro di voler eliminare questo prodotto?');">Elimina</button>
                </td>
            </tr>
        </form>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>

    <!-- Form per aggiungere un nuovo prodotto -->
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 5vh;">
        <div class="card p-4 mt-5 w-75">
            <h4>Aggiungi Nuovo Prodotto</h4>
            <form action="modificaProdotto.jsp" method="post">
                <div class="row mb-3">
                    <div class="col">
                        <label for="id" class="form-label">ID</label>
                        <input type="text" class="form-control" id="id" name="id" required>
                    </div>
                    <div class="col">
                        <label for="descrizione" class="form-label">Descrizione</label>
                        <input type="text" class="form-control" id="descrizione" name="descrizione" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col">
                        <label for="prezzo" class="form-label">Prezzo (€)</label>
                        <input type="number" class="form-control" id="prezzo" name="prezzo" step="0.01" required>
                    </div>
                    <div class="col">
                        <label for="categoria" class="form-label">Categoria</label>
                        <input type="text" class="form-control" id="categoria" name="categoria" required>
                    </div>
                </div>
                <div class="d-flex justify-content-center mt-3">
                    <button type="submit" class="btn btn-primary w-50" value="add" name="action">Aggiungi Prodotto</button>
                </div>
            </form>
        </div>
    </div>
    <br>
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
</script>
</body>
</html>