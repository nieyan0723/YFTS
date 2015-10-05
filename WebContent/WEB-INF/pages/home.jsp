<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<!-- for header and footer -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/extra/bootstrap-theme.css" rel="stylesheet">
<link href="css/extra/elegant-icons-style.css" rel="stylesheet" />
<link href="css/extra/font-awesome.min.css" rel="stylesheet" />    
<link href="css/extra/style.css" rel="stylesheet">
<script src="js/angular.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
var app = angular.module('mainModule', []);
</script>
</head>
<body style="height:100%" ng-app="mainModule">
	<c:import url="pageComponent/header.jsp"/>
	<session class="wrapper">
	<!--overview start-->
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header"><i class="fa fa-laptop"></i> Home</h3>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="index.html">Home</a></li>		
				<li></li>			  	
			</ol>
		</div>
	</div>
	
	<nav style="margin-top:100px">
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
	</session>
	<c:import url="pageComponent/footer.jsp"/>
</body>
</html>