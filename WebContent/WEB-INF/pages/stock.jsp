<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>YFTS</title>
<script src="js/jquery.min.js"></script>
<link rel="stylesheet" href="css/bootstrap.min.css">
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
	app.config(['$httpProvider', function ($httpProvider) {    
		$httpProvider.defaults.headers.post['Content-Type'] = 'application/json; charset=UTF-8';
	}]);
	app.controller('mainController', function($scope, $http) {
		$scope.stockList = [];
		$http.get("getStock").success(function(data) {
			$scope.stockList = data;
		}).error(function(data) {
			console.log(data);
		});
		
		$scope.symbol;
		$scope.desc;
		$scope.errorMsg;
		$scope.ifValid = false;		
		$scope.validStock = function(){
			$scope.message;
			$http({
				method: "POST",
				url: "validateStock",
				data: {symbol: $scope.symbol}
			}).success(function(data){
				$scope.message = data;
				if ($scope.message == "valid"){
					$scope.errorMsg = "";
					$scope.ifValid = true;
					console.log($scope.errorMsg);
				}else{
					$scope.errorMsg = $scope.message;
					$scope.ifValid = false;
				}
			})
			.error(function(data){
				console.log(data);
			});
		};		

		$scope.own = [];
		$http.get("stockOwned")
		.success(function(data){
			$scope.own = data;
		})
		.error(function(data){
			console.log(data);
		});
		
		$scope.hasOwn = function(stock){
			for (var i=0; i<$scope.own.length; i++){
				if (stock.sid == $scope.own[i].own.stock.sid){
					return true;
				}
			}
			return false;
		};	
	});
</script>
<style type="text/css">
.errors {
	color: red;
}
</style>
</head>
<body ng-app="mainModule">
	<c:import url="pageComponent/header.jsp" />
	<session class="wrapper" ng-controller="mainController">
	<h1>
		<font color="red">All Stocks</font>
	</h1>
	<form action="stock" id="listForm" method="post">
		<table border="1">
			<tr>
				<th>Stock ID</th>
				<th>Symbol</th>
				<th>Description</th>
				<th>Action</th>
			</tr>
			<tr ng-repeat="stock in stockList">
				<td>{{stock.sid}}</td>
				<td>{{stock.symbol}}</td>
				<td>{{stock.stockDesc}}</td>
				<td>
					<button class="delete" name="delete" 
						value="{{stock.sid}}" ng-disabled="hasOwn(stock)">Delete</button>
				</td>
			</tr>
		</table>
	</form>
	<br />
	<h2>Add Stock</h2>
	<div class="errors" id="stock_error"" ng-show="!ifValid">{{errorMsg}}</div>
	<form action="addStock" id="j_addForm" name="addForm" method="post">
		<label style="width: 100px">Stock Symbol</label> 
		<input type="text" name="symbol" id="j_symbol" ng-model="symbol" ng-blur="validStock()"
		 	ng-model-options="{updateOn:'default blur'}" placeholder="e.g. YHOO" required />
		<span>*&nbsp;</span>
		<span class="errors" id="symbol_error" ng-show="addForm.symbol.$dirty && addForm.symbol.$invalid">
			Please enter the stock symbol!
		</span><br/>
		<label style="width: 100px">Description</label> 
		<input type="text" name="stockDesc" id="j_stockDesc" ng-model="desc"
			ng-model-options="{updateOn:'default blur'}" placeholder="e.g. Yahoo!" required/>
		<span>*&nbsp;</span>
		<span class="errors" id="desc_error" ng-show="addForm.stockDesc.$dirty && addForm.stockDesc.$invalid">
			Please enter the stock description!
		</span><br/>
		<input type="reset" value="Reset" id="j_reset"/>
		<input type="submit" value="Submit" id="j_submit" 
			ng-disabled="!ifValid || addForm.stockDesc.$invalid"/>
	</form>
	</session>
	<c:import url="pageComponent/footer.jsp" />
</body>
</html>