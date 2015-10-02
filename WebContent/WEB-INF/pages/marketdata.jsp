<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Real Time Market Data</title>
    <script src="js/angular.min.js"></script>
    <script src="js/ui-bootstrap-tpls-0.13.4.min.js"></script>
    <script src="js/angular-animate.min.js"></script>
    <script src="js/activity.js"></script>
    <script src="js/angular-resource.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
<style>
	h3 {
		color: blue;
	}
	td {
		text-align:center;
	}
	input[type="range"] {
    display:inline;
	padding-top:6px;
    width: 200px;
    height:20px;
	}
	input[type="range"]::-webkit-slider-thumb {
    	background-color: #666;
    	padding-top:10px;
    	width: 10px;
    	height: 20px;
	}
</style>
</head>
<body ng-app="ui.bootstrap.demo">
	<nav>
		<ul>
			<li><a href="home">HOME</a></li>
			<li>ABOUT</li>
			<li><a href="portfolio">My portfolio</a></li>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<li><a href="pending">Pending</a></li>
			</sec:authorize>
			<li><a href="marketdata">Market data</a></li>
		</ul>
	</nav>
<a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
	<h2>This demo is show real time market data using Angular JS</h2>
	<div  ng-controller="ModalDemoCtrl">
		<h3>Market Data</h3>
		<table id="stockList" border="1" style="width: 800px"  ng-controller="mainController">
			<tr>
				<th>Stock ID</th>
				<th>Stock Name</th>
				<th>Price</th>
				<th>Change</th>
				<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
					<th>Transaction</th>
				</sec:authorize>
			</tr>
			<tr ng-repeat="stock in stocksArray">
				<td>{{stock.symbol}}</td>
				<td>{{stock.stockName}}</td>
				<td>{{stock.price}}</td>
				<td>
					<b ng-if="stock.change>0" style="color:green">+{{stock.change}}</b>
					<b ng-if="stock.change<0" style="color:red">{{stock.change}}</b>
					<b ng-if="stock.change==0" style="color:black">{{stock.change}}</b>
				</td>
				<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
					<td><input type="button" class="btn btn-default" name="buy" value="Buy" 
						ng-click="pass(stock); open()" /></td>
				</sec:authorize>
			</tr>
		</table>
	</div>
<div  ng-controller="ModalDemoCtrl">
    <script type="text/ng-template" id="myModalContent.html">
        <div class="modal-header">
            <h3 class="modal-title">Buy stocks: {{buyItem.stockName}}</h3>
        </div>
        <div class="modal-body">
            <label>Stock Symbol: </label>
			<input type="text" ng-model="buyItem.symbol"/><br/>
			<label>Stock Name: </label>
			<input type="text" ng-model="buyItem.stockName"/><br/>
			<label>Unit Price: </label>
			<input type="text" ng-model="buyItem.price"/><br/>
			<label>Quantity: </label>
			<input type="number" min="1" max={{upper}} value={{quan}} ng-model="quan"/>
			<input type="range" min="1" max={{upper}} value={{quan}} ng-model="quan"/>
			<br/>	
        </div>		
		
        <div class="modal-footer">
		<div>		
			<label style="margin-right:50px">Ready to buy {{quan}} shares of {{buyItem.symbol}}? 
				Balance after transaction: {{Math.round(user.balance - buyItem.price * quan)}}</label>
		</div><br/>
            <button class="btn btn-primary" type="button" ng-click="ok()">OK</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>
    </script>

    <button type="button" class="btn btn-default" ng-click="toggleAnimation()">Toggle Animation ({{ animationsEnabled }})</button>
    <div ng-show="selected">Selection from a modal: {{ selected }}</div>
</div>
</body>
</html>