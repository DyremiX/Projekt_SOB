<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="pl.wieik.ti.ti2023lab5.model.HammingCodeApi" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.function.BinaryOperator" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kodowanie Hamminga</title>
    <link rel="stylesheet" type="text/css" href="style_hamming.css">
    <script>function sendHamming() {
        // Pobranie referencji do tabelki
        var table = document.getElementById("hammingTable");

        // Utworzenie pustej tablicy dla danych
        var data = [];

        // Przechodzenie przez wiersze tabelki
        for (var i = 1; i < table.rows.length; i++) {
            var rowData = [];

            // Przechodzenie przez komórki w wierszu
            for (var j = 2; j < table.rows[i].cells.length; j++) {
                rowData.push(table.rows[i].cells[j].innerHTML);
            }

            // Dodanie wiersza danych do tablicy
            data.push(rowData);
        }

        // Utworzenie obiektu żądania
        var request = {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        };

        // Wywołanie żądania do serwera
        fetch("http://localhost:30000/TI2023_Lab5_war_exploded/hamming", request)
            .then(function(response) {
                var redirected = response.redirected;
                var url = response.url;

                if (redirected) {
                    // Przekierowanie - przekieruj na nowy adres URL
                    window.location.href = url;
                }
                if (response.ok) {
                    return response.text();
                } else {
                    throw new Error("Wystąpił błąd podczas wysyłania danych na serwer.");
                }
            })
            .then(function(responseText) {
                // Obsługa odpowiedzi serwera
                // Sprawdź, czy odpowiedź zawiera przekierowanie
                    // Kontynuuj inna logikę
                    console.log(responseText);
            })
            .catch(function(error) {
                // Obsługa błędów
                console.error(error);
            });
    }
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
            var valuesAscii = [];
            var values = [];
            for (var i = 1; i < table.rows.length; i++) {
                var rowValues = [];
                for (var j = 2; j < table.rows[i].cells.length; j++) {
                    rowValues.push(table.rows[i].cells[j].innerHTML);
                }
                values.push(rowValues);
                var asciiChar = convertBinaryToAscii(rowValues);
                valuesAscii.push(asciiChar);
            }
            var result = valuesAscii.join(""); // Konwersja tablicy na string
            document.getElementById("tableValues").innerHTML = result;
        }
        function convertBinaryToAscii(inputArray) {
            const indexesToRemove = [0, 1, 3, 7, inputArray.length - 1];
            // const reversedArray = inputArray.reverse();
            const shortenedArray = inputArray.filter((_, index) => !indexesToRemove.includes(index));

            const binaryString = shortenedArray.join('');
            const decimalValue = parseInt(binaryString, 2);
            const asciiChar = String.fromCharCode(decimalValue);

            return asciiChar;
        }


    </script>
</head>
<body>
<h1>Kodowanie Hamminga</h1>

<form method="post" action="hamming.jsp">
    <label for="inputWord">Wprowadź słowo:</label>
    <input type="text" id="inputWord" name="inputWord" value="<%= (request.getParameter("inputWord") != null) ? request.getParameter("inputWord") : "" %>" required>
    <input type="submit" value="Akceptuj">
</form>

<%-- Sprawdzenie czy słowo zostało przesłane --%>
<% if (request.getParameter("inputWord") != null) { %>
<%
    String inputWord = request.getParameter("inputWord");
    int[][] hammingCodes = new int[inputWord.length()][];
    for (int i = 0; i < inputWord.length(); i ++){
        hammingCodes[i] = HammingCodeApi.getHammingCode(HammingCodeApi.charToBinaryIntArray(inputWord.charAt(i)));
    }
%>
<h2>Wygenerowane kody Hamminga:</h2>
<table id="hammingTable">
    <tr>
        <th>ID</th>
        <th>Słowo</th>
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
    <% for (int i = 0; i < inputWord.length(); i++) { %>
    <tr>
        <td><%= i+1 %></td>
        <td><%= inputWord.charAt(i) %></td>
        <%-- Wygenerowanie kodów Hamminga dla każdej litery --%>
        <% for (int j = 0; j < hammingCodes[i].length; j++) { %>
        <%-- Sprawdzenie, czy komórka ma mieć jasnoniebieskie tło --%>
        <% if (j == 3 || j == 4 || j == 6 || j == 10) { %>
        <td class="blue-bg" onclick="toggleCellContent(this);toggleCellColor(this);sendTableValues()"><%= hammingCodes[i][j] %></td>
        <% } else if (j == hammingCodes[i].length - 1) { %>
        <td class="blue-bg"><%= hammingCodes[i][j] %></td>
        <% } else { %>
        <td onclick="toggleCellContent(this);toggleCellColor(this);sendTableValues()"><%= hammingCodes[i][j] %></td>
        <% } %>
        <% } %>
    </tr>
    <% } %>
</table>
<br>
<p id="tableValues"><%= inputWord%></p>
<button onclick="sendHamming()">Wyślij</button>
<% } %>
<button onclick="window.location.href = 'http://localhost:30000/TI2023_Lab5_war_exploded/main';">Powrót do strony głównej</button>
</body>
</html>
