<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/angular.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
<script>
	angular.module("mainModule", []).controller("mainController", function($scope, $interval, $http) {
		// Initialization
		$scope.stocksArray = [];
		$interval(function() {
			$http({
				method: "GET",
				url: "market",
			}).success(function(data) {
				$scope.stocksArray = data;
			}).error(function(data) {
				alert(data);
			});
		}, 500);
	});	
</script>
<style>
	h3 {
		color: blue;
	}
</style>
</head>
<body ng-app="mainModule">
	<h2>This demo is show real time market data using Angular JS</h2>
	<div ng-controller="mainController">
		<h3>Market Data</h3>
		<table id="stockList" border="1" style="width: 500px">
			<tr>
				<th>Stock ID</th>
				<th>Price</th>
				<th>Change</th>
			</tr>
			<tr ng-repeat="stock in stocksArray">
				<td>{{stock.symbol}}</td>
				<td>{{stock.price}}</td>
				<td>
					<b ng-if="stock.change>0" style="color:green">{{stock.change}}</b>
					<b ng-if="stock.change<0" style="color:red">{{stock.change}}</b>
					<b ng-if="stock.change==0" style="color:black">{{stock.change}}</b>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>