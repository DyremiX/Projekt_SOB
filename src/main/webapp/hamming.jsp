<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pl.wieik.ti.ti2023lab5.model.HammingCodeApi" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kodowanie Hamminga</title>
    <link rel="stylesheet" type="text/css" href="style_hamming.css">
    <script>
        function toggleCellContent(cell) {
            if (cell.innerHTML === "0") {
                cell.innerHTML = "1";
            } else {
                cell.innerHTML = "0";
            }
        }
        function toggleCellColor(cell) {
            if (cell.style.backgroundColor === "red") {
                cell.style.backgroundColor = cell.getAttribute("data-original-color");
            } else {
                cell.setAttribute("data-original-color", cell.style.backgroundColor);
                cell.style.backgroundColor = "red";
            }
        }
        function sendTableValues() {
            var table = document.getElementById("hammingTable");
            var values = [];
            for (var i = 1; i < table.rows.length; i++) {
                var rowValues = [];
                for (var j = 2; j < table.rows[i].cells.length; j++) {
                    rowValues.push(table.rows[i].cells[j].innerHTML);
                }
                values.push(rowValues);
            }
            document.getElementById("tableValues").innerHTML = JSON.stringify(values);
        }
    </script>
</head>
<body>
<h1>Kodowanie Hamminga</h1>

<form method="post" action="hamming.jsp">
    <label for="inputWord">Wprowadź słowo:</label>
    <input type="text" id="inputWord" name="inputWord" required>
    <input type="submit" value="Akceptuj">
</form>

<%-- Sprawdzenie czy słowo zostało przesłane --%>
<% if (request.getParameter("inputWord") != null) { %>
<%
    String inputWord = request.getParameter("inputWord");
    byte[] inputBytes = inputWord.getBytes("UTF-8");
    String[] letters = new String[inputBytes.length];
    int[][] hammingCodes = new int[letters.length][15];
    for (int i = 0; i < inputBytes.length; i++) {
        letters[i] = new String(new byte[] { inputBytes[i] }, "UTF-8");
        int[] letterCode = HammingCodeApi.getHammingCode(HammingCodeApi.charToBinaryIntArray(letters[i].charAt(0)));
        for (int j = 0; j < letterCode.length; j++) {
            hammingCodes[i][j] = letterCode[j];
        }
    }
%>
<h2>Wygenerowane kody Hamminga:</h2>
<table id="hammingTable">
    <tr>
        <th>ID</th>
        <th>Słowo</th>
        <%-- Wygenerowanie nagłówków dla 15 kolumn --%>
        <% for (int i = 1; i <= 15; i++) { %>
        <%-- Sprawdzenie, czy kolumna ma mieć jasnoniebieskie tło --%>
        <% if (i == 3 || i == 4 || i == 6 || i == 10) { %>
        <th class="blue-bg"><%= i %></th>
        <% } else { %>
        <th><%= i %></th>
        <% } %>
        <% } %>
    </tr>
    <% for (int i = 0; i < letters.length; i++) { %>
    <tr>
        <td><%= i+1 %></td>
        <td><%= letters[i] %></td>
        <%-- Wygenerowanie kodów Hamminga dla każdej litery --%>
        <% for (int j = 0; j < hammingCodes[i].length; j++) { %>
        <%-- Sprawdzenie, czy komórka ma mieć jasnoniebieskie tło --%>
        <% if (j == 3 || j == 4 || j == 6 || j == 10) { %>
        <td class="blue-bg" onclick="toggleCellContent(this);toggleCellColor(this)"><%= hammingCodes[i][j] %></td>
        <% } else { %>
        <td onclick="toggleCellContent(this);toggleCellColor(this)"><%= hammingCodes[i][j] %></td>
        <% } %>
        <% } %>
    </tr>
    <% } %>
</table>
<br>
<button onclick="sendTableValues()">Wyślij</button>
<p id="tableValues"></p>
<% } %>
</body>
</html>
