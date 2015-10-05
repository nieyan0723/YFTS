<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<link href="css/extra/bootstrap-theme.css" rel="stylesheet">
<link href="css/extra/elegant-icons-style.css" rel="stylesheet" />
<link href="css/extra/font-awesome.min.css" rel="stylesheet" />    
<link href="css/extra/style.css" rel="stylesheet">
<script src="js/angular.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/checklist-model.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script>
var app = angular.module('mainModule', ['checklist-model']);
app.controller("mainController", function($scope, $http) {
			$scope.transList = [];
			$http.get("getPending")
			.success(function(data) {
				$scope.transList = data;
				console.log($scope.hasPending());
			}).error(function(data) {
				console.log("AJAX ERROR");
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
	        $scope.hasPending = function(){
	        	if ($scope.transList.length > 0) return true;
	        	else return false;
	        };
		});	
</script>
<style type="text/css">
	.error {
		color:red;
		visibility:hidden;
	}
	th, td {
		text-align:center;
	}
</style>
</head>
<body ng-app="mainModule">
<c:import url="pageComponent/header.jsp"/>
<session class="wrapper">
<!--overview start-->
	<div class="row">
		<div class="col-lg-12">
			<h3 class="page-header"><i class="fa fa-home"></i> Home</h3>
			<ol class="breadcrumb">
				<li><i class="fa fa-home"></i><a href="index.html">Home</a></li>		
				<li></li>			  	
			</ol>
		</div>
	</div>

<div ng-controller="mainController">
	<div ng-if="!hasPending()">
		<h1>No Pendings!</h1>
	</div>
<div ng-if="hasPending()">
<h3>All the pending transactions</h3>
<form id="pendingList" action="pending" method="get">
	<table border="1" >
		<tr>
			<th>User ID</th>
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
				<input id="tagglebox" ng-checked="selectAll" type="checkbox" 
				checklist-value="transList.indexOf(tran)" checklist-model="selected.trans" /> 
			</td>
		</tr>
	</table>
	<br/>
	<div>
		<button class="commit" name="commitAll" value={{selected.trans}}>Commit Selected</button>
		<button class="drop" name="dropAll" value={{selected.trans}}>Drop Selected</button>
	</div>
</form>
</div>
</div>
<br/>
</session>
<c:import url="pageComponent/footer.jsp"/>
</body>
</html>