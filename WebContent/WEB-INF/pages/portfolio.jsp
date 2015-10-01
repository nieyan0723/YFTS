<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Portfolio</title>
</head>
<body>
	<form action="portfolio" id="listUserStocks" method="post">
		<table border="1">
			<tr>
				<th>Stock ID</th>
				<th>Symbol</th>
				<th>Stock Name</th>
				<th>Quantity</th>
				<th>Operation</th>
			</tr>
			<c:forEach var="ow" items="${userOwns}">
				<tr>
					<td>${ow.own.stock.sid}</td>
					<td>${ow.own.stock.symbol}</td>
					<td>${ow.own.stock.stockName}</td>
					<td>${ow.quantity}</td>
					<td>buy/sell</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>