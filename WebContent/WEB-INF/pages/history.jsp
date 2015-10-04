<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<script src="js/angular.min.js"></script>
<script src="js/checklist-model.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script>
	var app = angular.module("mainModule", ['checklist-model']);
	app.controller("pendingController", function($scope, $http) {
		$scope.pendingList = [];
		$http.get("myPending").
		success(function(data) {
			$scope.pendingList = data;
		}).error(function(data) {
			console.log("AJAX ERROR");
		});
		$scope.selected = {
				 pending: []
		};
		$scope.checkAll = function($event) {
			var checkbox = $event.target;
			$scope.selected.pending = [];
			if(checkbox.checked){
				for ( var i = 0; i < $scope.pendingList.length; i++) {
				    var entity = $scope.pendingList.indexOf($scope.pendingList[i]);
				    $scope.selected.pending.push(entity);
				}
			}else{
				$scope.selected.pending = [];
			}
        };
        $scope.hasPending = function(){
        	if ($scope.pendingList.length > 0) return true;
        	else return false;
        };
	});	
	
	app.controller("historyController", function($scope, $http) {
		$scope.transList = [];
		$http.get("getHistory")
		.success(function(data) {
			$scope.transList = data;
		}).error(function(data) {
			alert("Please sign in!");
		});
		
		$scope.hasTran = function(){
        	if ($scope.transList.length > 0) return true;
        	else return false;
        };
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
	th, td{
		text-align:center;
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
	<a href="<c:url value='/j_spring_security_logout'/>">Logout</a>	
	<div ng-controller="pendingController" >
		<div ng-if="hasPending()">
		<h1>Pending transactions</h1>
		<form id="pendingList" action="history" method="get">
			<table border="1" >
				<tr>
					<th>User ID</th>
					<th>Stock ID</th>
					<th>Amount</th>
					<th>Price</th>
					<th>Transaction Time</th>
					<th>Cancel</th>
					<th><input type="checkbox" name="selectAll" ng-model="selectAll" 
						ng-click="checkAll($event)"/></th>
				</tr>
				<tr ng-repeat="pending in pendingList">
					<td>{{pending.own.user.uid}}</td>
					<td>{{pending.own.stock.sid}}</td>
					<td>{{pending.amount}}</td>
					<td>{{pending.price}}</td>
					<td>{{pending.ts}}</td>
					<td>
						<button class="cancel" name="cancel" 
						value={{pendingList.indexOf(pending)}}>Cancel</button>
					</td>
					<td>
						<input id="tagglebox" ng-checked="selectAll" type="checkbox" 
						checklist-value="pendingList.indexOf(pending)" checklist-model="selected.pending" /> 
					</td>
				</tr>
			</table>
			<br/>
			<div>
				<button class="cancel" name="cancelAll" value={{selected.pending}}>Cancel Selected</button>
			</div>
		</form>
		</div>
	</div>
	<br/>
	<h1>Transaction history</h1>
	<div ng-controller="historyController">
		<div ng-if="!hasTran()"></div>
		<table id="transHistory" border="1">
			<tr>
				<th>Transaction ID</th>
				<th>Username</th>
				<th>Stock Symbol</th>
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