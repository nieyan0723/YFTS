<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirmation page</title>
</head>
<body>
	<h1>Check your email!</h1>
	<h1>
		<font color="green">${userInfo.message}</font>
	</h1>
	<table width="200" border="1">
		<tr>
			<th>User Name</th>
			<th>Email</th>
			<th>First Name</th>
			<th>Last Name</th>
			<th>Balance</th>
			<th>Authority</th>
			<th>Enabled</th>
		</tr>
		<c:forEach var="user" items="${userInfo.users}">
			<tr>
				<td>${user.userName}</td>
				<td>${user.email}</td>
				<td>${user.firstName}</td>
				<td>${user.lastName}</td>
				<td>${user.balance}</td>
				<td>${user.authority}</td>
				<td>${user.enabled}</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>