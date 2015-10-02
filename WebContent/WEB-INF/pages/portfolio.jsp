<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Portfolio</title>
<script src="js/angular.min.js"></script>
    <script src="js/ui-bootstrap-tpls-0.13.4.min.js"></script>
    <script src="js/angular-animate.min.js"></script>
    <script src="js/activity-portfolio.js"></script>
    <script src="js/angular-resource.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body ng-app="ui.bootstrap.demo">
	<nav>
		<ul>
			<li><a href="home">HOME</a></li>
			<li>ABOUT</li>
			<li><a href="portfolio">My portfolio</a></li>
			<li><a href="marketdata">Market data</a></li>
		</ul>
	</nav>
	<a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
	<div  ng-controller="ModalDemoCtrl">
		<form action="portfolio" id="listUserStocks" method="post">
			<table border="1" ng-controller="mainController">
				<tr>
					<th>Stock ID</th>
					<th>Symbol</th>
					<th>Stock Name</th>
					<th>Stock price</th>
					<th>Stock change</th>
					<th>Quantity</th>
					<th>Operation</th>
				</tr>
				<tr ng-repeat=" stock in userOwns">
					<td>{{stock.stock.sid}}</td>
					<td>{{stock.stock.symbol}}</td>
					<td>{{stock.stockName}}</td>
					<td>{{stock.price}}</th>
					<td>
						<b ng-if="stock.change>0" style="color:green">+{{stock.change}}</b>
						<b ng-if="stock.change<0" style="color:red">{{stock.change}}</b>
						<b ng-if="stock.change==0" style="color:black">{{stock.change}}</b></th>
					<td>{{stock.quantity}}</td>
					<td><input type="button" class="btn btn-default" name="buy" value="Buy" 
					ng-click="pass(stock); open()" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div  ng-controller="ModalDemoCtrl">
    <script type="text/ng-template" id="myModalContent1.html">
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