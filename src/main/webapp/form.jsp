<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Demo - Test</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<% session.setAttribute("user", null); %>
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
        <div class="card p-4" style="width: 22rem;">
            <h1 class="text-center">Accedi</h1>
            <form method="post" action="login.jsp">
                <div class="form-floating mb-3">
                    <input type="text" name="username" class="form-control" id="floatingInput" placeholder="name@example.com" required>
                    <label for="floatingInput">Username</label>
                </div>
                <div class="form-floating mb-3">
                    <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password" required>
                    <label for="floatingPassword">Password</label>
                </div>
                <input type="submit" value="Login" class="btn btn-primary w-100 mt-2">
                <%
                    String messaggio = request.getParameter("messaggio");
                    if (messaggio != null) {
                %>
                <div class="alert alert-danger" role="alert" style="margin-top: 5px">
                        <%=messaggio%>
                </div>
                <%
                    }
                %>
            </form>
            <div class="text-center mt-3">oppure:</div>
            <br>
            <button type="button" class="btn btn-dark w-100" onclick="window.location.href='register.jsp'">Registrati</button>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
