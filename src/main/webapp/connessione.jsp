<%@page import="esempio.FunzioniDB"%>
<%
    FunzioniDB funzioni=(FunzioniDB)session.getAttribute("funzioni");
    if (funzioni==null){
        funzioni=new FunzioniDB("jdbc:mysql://localhost/amazoff","root","");
        session.setAttribute("funzioni", funzioni);
    }
%>