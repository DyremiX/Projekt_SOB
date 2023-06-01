<%@ page import="pl.wieik.ti.ti2023lab5.model.HammingCodeApi" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kod Hamminga</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h1>Kod Hamminga</h1>

<form method="post" action="hamming.jsp">
    <label for="inputData">Wprowadź dane:</label>
    <input type="text" id="inputData" name="inputData" required>
    <input type="submit" value="Wyślij">
</form>

<%-- Sprawdzenie czy dane zostały przesłane --%>
<% if (request.getParameter("inputData") != null) { %>
<h2>Wprowadzone dane:</h2>
<%
    String inputData = request.getParameter("inputData");
    int[] inputDataArray = HammingCodeApi.convertStringToIntArray(inputData);
    int[] hammingCode = HammingCodeApi.getHammingCode(inputDataArray);
    int[] receivedData = HammingCodeApi.receiveData(hammingCode, HammingCodeApi.calculateParityBits(hammingCode.length) -1);
%>
<p><strong>Przed kodowaniem:</strong> <%= inputData %></p>
<p><strong>Po kodowaniu:</strong> <%= HammingCodeApi.convertIntArrayToString(hammingCode) %></p>
<p><strong>Po odkodowaniu:</strong> <%= HammingCodeApi.convertIntArrayToString(receivedData) %></p>
<% } %>

</body>
</html>
