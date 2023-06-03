<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pl.wieik.ti.ti2023lab5.model.HammingCodeApi" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.function.BinaryOperator" %>
<%@ page import="pl.wieik.ti.ti2023lab5.model.HammingResponse" %>
<jsp:useBean id="tablicaReponse" class="pl.wieik.ti.ti2023lab5.model.HammingCodeText" scope="session" />
<!DOCTYPE html>
<html>
<head>
    <title>Kodowanie Hamminga</title>
    <link rel="stylesheet" type="text/css" href="style_hamming.css">
</head>
<body>
<h1>Kodowanie Hamminga</h1>
<h2>Odebrane kody Hamminga:</h2>
<% HammingResponse tablica[] = tablicaReponse.getTable(); %>
<%for (int x = 0 ; x < tablica.length; x++) { %>
<h3> Dla ID <%= x + 1%> <%= tablica[x].getMessage()%></h3>
<br>
<table id="hammingTable">
    <tr>
        <td>ID</td>
        <%-- Wygenerowanie nagłówków dla 15 kolumn --%>
        <% for (int i = 1; i <= 11; i++) { %>
        <%-- Sprawdzenie, czy kolumna ma mieć jasnoniebieskie tło --%>
        <% if (i == 3 || i == 4 || i == 6 || i == 10) { %>
        <th class="blue-bg"><%= i %></th>
        <% } else { %>
        <th><%= i %></th>
        <% } %>
        <% } %>
    </tr>
    <tr>
        <td><%= x + 1 %></td>
        <%-- Wygenerowanie kodów Hamminga dla każdej litery --%>
        <% for (int j = 0; j < tablica[x].getResponse().length; j++) { %>
        <%-- Sprawdzenie, czy komórka ma mieć jasnoniebieskie tło --%>
        <% if (j == tablica[x].getError_loc() - 1) { %>
        <td class="blue-bg" style="background-color: red"><%= tablica[x].getResponse()[j] %></td>
        <% } else if (j == 2 || j == 3 || j == 5 || j == 9) { %>
        <td class="blue-bg"><%= tablica[x].getResponse()[j] %></td>
        <% } else if (j == tablica[x].getResponse().length - 1) { %>
        <td class="blue-bg"><%= tablica[x].getResponse()[j] %></td>
        <% } else { %>
        <td><%= tablica[x].getResponse()[j] %></td>
        <% } %>
        <% } %>
    </tr>
</table>
<% } %>
<button onclick="window.location.href = 'http://localhost:30000/TI2023_Lab5_war_exploded/main';">Powrót do strony głównej</button>
<button onclick="window.location.href = 'http://localhost:30000/TI2023_Lab5_war_exploded/hamming';">Jeszcze raz</button>


</body>
</html>
