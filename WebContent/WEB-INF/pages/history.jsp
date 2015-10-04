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
	
	app.controller("historyController", ["$scope", "$http", "$filter", function($scope, $http, $filter) {
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
        
        $scope.predicate = 'tid';
        $scope.reverse = true;
        $scope.order = function(predicate) {
          $scope.reverse = ($scope.predicate === predicate) ? !$scope.reverse : false;
          $scope.predicate = predicate;
        };
	}]);
	app.filter("dateRange", function(){
		return function(items, d1, d2){
			if (!d1 || !d2){
				return items;
			}
			var filtered = [];
			angular.forEach(items, function(item){
				var timestamp = new Date(item.ts);
				timestamp.setHours(0,0,0,0);
				if (timestamp >= d1 && timestamp <= d2){
					filtered.push(item);
				}
			});
			return filtered;
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
	.sortorder:after {
    	content: '\25b2';
  	}
	.sortorder.reverse:after {
    	content: '\25bc';
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
		<div ng-if="!hasTran()">
			<h1>No transaction history</h1>
		</div>
		<div ng-if="hasTran()">
		<form id="search">
			<label>Key word: </label>
			<input type="text" placeholder="Filter by" ng-model="criteria"/>
			<label>Between </label>
			<input type="date" name="lower" ng-model="startDate"/>
			<label>and</label>
			<input type="date" name="upper" ng-model="endDate"/>
		</form>
		<hr/>
		<table id="transHistory" border="1">
		<tr>
			<th>
				<a href="" ng-click="order('tid')">TID</a>
       			<span class="sortorder" ng-show="predicate === 'tid'" ng-class="{reverse:reverse}"></span>
			</th>
			<th>
				<a href="" ng-click="order('own.user.userName')">Username</a>
       			<span class="sortorder" ng-show="predicate === 'own.user.userName'" ng-class="{reverse:reverse}"></span>
			</th>
			<th>
				<a href="" ng-click="order('own.stock.symbol')">Stock Symbol</a>
       			<span class="sortorder" ng-show="predicate === 'own.stock.symbol'" ng-class="{reverse:reverse}"></span>
			</th>
			<th>
				<a href="" ng-click="order('amount')">Amount</a>
       			<span class="sortorder" ng-show="predicate === 'amount'" ng-class="{reverse:reverse}"></span>
			</th>
			<th>
				<a href="" ng-click="order('price')">Price</a>
       			<span class="sortorder" ng-show="predicate === 'price'" ng-class="{reverse:reverse}"></span>
			</th>
			<th>
				<a href="" ng-click="order('ts')">Transaction Time</a>
       			<span class="sortorder" ng-show="predicate === 'ts'" ng-class="{reverse:reverse}"></span>
			</th>
		</tr>
		<tr ng-repeat="tran in transList |dateRange:startDate:endDate |filter:criteria| orderBy:predicate:reverse">
			<td>{{tran.tid}}</td>
			<td>{{tran.own.user.userName}}</td>
			<td>{{tran.own.stock.symbol}}</td>
			<td>{{tran.amount}}</td>
			<td>{{tran.price}}</td>
			<td>{{tran.ts}}</td>
		</tr>
		</table>
		</div>
		
	</div>	
	<br />
</body>
</html>