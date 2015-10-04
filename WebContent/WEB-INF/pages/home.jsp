<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
	<nav>
		<ul>
			<li><a href="home">HOME</a></li>
			<li>ABOUT</li>
			<sec:authorize access="hasRole('ROLE_USER')">
				<li><a href="portfolio">My portfolio</a></li>
				<li><a href="history">Transaction History</a></li>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="stock">Add/Delete Stock</a></li>
				<li><a href="pending">Pending</a></li>
			</sec:authorize>
			<li><a href="marketdata">Market data</a></li>
		</ul>
	</nav>
	<h1>
		<font color="green">${userInfo.message}</font>
	</h1>
	<sec:authorize access="hasRole('ROLE_USER')">
		<h1>Welcome back</h1>
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<h1>Hello Admin</h1>
		<table border="1">
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
	</sec:authorize>
	<a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
</body>
</html>