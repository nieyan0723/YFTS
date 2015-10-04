<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<script src="js/angular.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script>
	var app = angular.module("mainModule", []);
	app.controller("mainController", function($scope, $http) {
		$scope.transList = [];
			$http({
				method: "GET",
				url: "getHistory",
			}).success(function(data) {
				$scope.transList = data;
			}).error(function(data) {
				alert(data);
			});
	});	
</script>
<style type="text/css">
	.error {
		color: red;
		visibility: hidden;
	}
	h1 {
		color: red;
	}
</style>
</head>
<body ng-app="mainModule">
	<nav>
		<ul>
			<li><a href="home">HOME</a></li>
			<li>ABOUT</li>
			<li><a href="portfolio">My portfolio</a></li>
			<li><a href="history">Transaction History</a></li>
			<li><a href="marketdata">Market data</a></li>
		</ul>
	</nav>
	<h1>All the transaction history</h1>
	<div ng-controller="mainController">
		<table id="transHistory" border="1">
			<tr>
				<th>Transaction ID</th>
				<th>User ID</th>
				<th>Stock ID</th>
				<th>Amount</th>
				<th>Price</th>
				<th>Transaction Time</th>
			</tr>
			<tr ng-repeat="tran in transList">
				<td>{{tran.tid}}</td>
				<td>{{tran.own.user.userName}}</td>
				<td>{{tran.own.stock.symbol}}</td>
				<td>{{tran.amount}}</td>
				<td>{{tran.price}}</td>
				<td>{{tran.ts}}</td>
			</tr>
		</table>
	</div>
	<br />
</body>
</html>