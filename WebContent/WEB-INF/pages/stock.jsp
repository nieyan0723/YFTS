<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
</head>
<body>
<h1><font color="red">All Stocks</font></h1>
<form:form action="stock" id="listForm" method="post">
	<table border="1">
		<tr>
			<th>Stock ID</th>
			<th>Symbol</th>
			<th>Stock Name</th>
			<th>Delete</th>
		</tr>
		<c:forEach var="stock" items="${stockList}">
			<tr>
				<td>${stock.sid}</td>
				<td>${stock.symbol}</td>
				<td>${stock.stockName}</td>
				<td><button class="delete" name="delete" value="${stock.sid}">Delete</button></td>
			</tr>
		</c:forEach>
	</table>
</form:form>
<br/>
<h2>Add Stock</h2>
<form:form action="add" id="addForm" method="post">
	<table>
		<tr>
			<td>Stock Symbol: </td>
			<td><input type="text" name="symbol" id="j_symbol"/></td>
		</tr>
		<tr>
			<td>Stock Name: </td>
			<td><input type="text" name="stockName" id="j_stockName"/></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<input type="reset" value="Clear"/>
				<input type="submit" value="Submit"/>
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>