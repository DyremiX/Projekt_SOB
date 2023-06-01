<%@ page import="pl.wieik.ti.ti2023lab5.model.CrcCodeApi" %>
<!DOCTYPE html>
<html>
<head>
  <title>Kodowanie CRC</title>
  <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h1>Kodowanie CRC</h1>

<form method="post" action="crc.jsp">
  <label for="inputData">Wprowadź dane:</label>
  <input type="text" id="inputData" name="inputData" required>
  <input type="submit" value="Wyślij">
</form>

<%-- Sprawdzenie czy dane zostały przesłane --%>
<% if (request.getParameter("inputData") != null) { %>
<h2>Wprowadzone dane:</h2>
<%
  String inputData = request.getParameter("inputData");
  String encodedData = CrcCodeApi.encodeData(inputData);
%>
<p><strong>Przed kodowaniem:</strong> <%= inputData %></p>
<p><strong>Po kodowaniu CRC:</strong> <%= encodedData %></p>
<% } %>

</body>
</html>
