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
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.5/angular.min.js"></script>
<script src="/YFTS/resources/js/checklist-model.js"></script>
<script>
var app = angular.module('mainModule', ['checklist-model']);
app.controller("mainController", function($scope, $http) {
			$scope.transList = [];
			$scope.ab = "jone";
			$http({
				method: "GET",
				url: "getPending",
			}).success(function(data) {
				$scope.transList = data;
			}).error(function(data) {
				alert("AJAX ERROR");
			});
			$scope.selected = {
					 trans: []
			};
			$scope.checkAll = function($event) {
				var checkbox = $event.target;
				$scope.selected.trans = [];
				if(checkbox.checked){
					for ( var i = 0; i < $scope.transList.length; i++) {
					    var entity = $scope.transList.indexOf($scope.transList[i]);
					    $scope.selected.trans.push(entity);
					}
				}else{
					$scope.selected.trans = [];
				}
	        };
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
<nav>
		<ul>
			<li><a href="home">HOME</a></li>
			<li>ABOUT</li>
			<li><a href="pending">Pending</a></li>
			<li><a href="marketdata">Market data</a></li>
		</ul>
	</nav>
<a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
<h1><font color="red">All the pending transactions</font></h1>
<form id="pendingList" action="pending" method="get">
	<table border="1" ng-controller="mainController">
		<tr>
			<th>User ID<p><font color="red">{{trans.transList[1].amount}}</font></p></th>
			<th>Stock ID</th>
			<th>Amount</th>
			<th>Price</th>
			<th>Transaction Time</th>
			<th>Commit</th>
			<th>Drop</th>
			<th><input type="checkbox" name="selectAll" ng-model="selectAll" ng-click="checkAll($event)"/></th>
		</tr>
		<tr ng-repeat="tran in transList">
			<td>{{tran.own.user.uid}}</td>
			<td>{{tran.own.stock.sid}}</td>
			<td>{{tran.amount}}</td>
			<td>{{tran.price}}</td>
			<td>{{tran.ts}}</td>
			<td><button class="commit" name="commit" value={{transList.indexOf(tran)}}>Commit</button></td>
			<td><button class="drop" name="drop" value={{transList.indexOf(tran)}}>Drop</button></td>
			<td>
				<label>{{transList.indexOf(tran)}}
					<input id="tagglebox" ng-checked="selectAll" type="checkbox" checklist-value="transList.indexOf(tran)" checklist-model="selected.trans" /> 
				</label>
			</td>
		</tr>
		<tr><td colspan="7">{{selected.trans}}</td></tr>
	</table>
	<br/>
	<div>
		<input type="button" class="commit" name="commitAll" value="Commit Selected"/>
		<input type="button" class="drop" name="dropAll" value="Drop Selected"/>
	</div>
</form>
<br/>

</body>
</html>