<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
<script>
	var app = angular.module("mainModule", []);
	app.controller("mainController", function($scope, $http) {
		$scope.transList = [];
			$http({
				method: "GET",
				url: "getPending",
			}).success(function(data) {
				$scope.transList = data;
			}).error(function(data) {
				alert("AJAX ERROR");
			});
	});	
</script>
<style type="text/css">
	.error {
		color:red;
		visibility:hidden;
	}
</style>
</head>
<body ng-app="mainModule">
<h1><font color="red">All the pending transactions</font></h1>
<form id="pendingList" action="pending" method="get">
	<table border="1" ng-controller="mainController">
		<tr>
			<th>User ID</th>
			<th>Stock ID</th>
			<th>Amount</th>
			<th>Price</th>
			<th>Transaction Time</th>
			<th>Commit</th>
			<th>Drop</th>
		</tr>
		<tr ng-repeat="tran in transList">
			<td>{{tran.own.user.uid}}</td>
			<td>{{tran.own.stock.sid}}</td>
			<td>{{tran.amount}}</td>
			<td>{{tran.price}}</td>
			<td>{{tran.ts}}</td>
			<td><button class="commit" name="commit" value={{transList.indexOf(tran)}}>Commit</button></td>
			<td><button class="drop" name="drop" value={{transList.indexOf(tran)}}>Drop</button></td>
		</tr>
	</table>
</form>
<br/>

</body>
</html>