<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
</script>
<script>

</script>
<style type="text/css">
.error {
	color: red;
	visibility: hidden;
}
</style>
</head>
<body>
	<h1>
		<font color="red">All the transaction history</font>
	</h1>
	<form id="listForm">
		<table border="1">
			<tr>
				<th>Transaction ID</th>
				<th>User ID</th>
				<th>Stock ID</th>
				<th>Amount</th>
				<th>Price</th>
				<th>Transaction Time</th>
			</tr>
			<c:forEach var="tran" items="${transList}">
				<tr>
					<td>${tran.tid}</td>
					<td>${tran.own.user.uid}</td>
					<td>${tran.own.stock.sid}</td>
					<td>${tran.amount}</td>
					<td>${tran.price}</td>
					<td>${tran.ts}</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<br />

</body>
</html>