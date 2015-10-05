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
    <!-- for header and footer -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<link href="css/extra/bootstrap-theme.css" rel="stylesheet">
<link href="css/extra/elegant-icons-style.css" rel="stylesheet" />
<link href="css/extra/font-awesome.min.css" rel="stylesheet" />    
<link href="css/extra/style.css" rel="stylesheet">
<script src="js/angular.min.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<style>
	h3 {
		color: blue;
	}
	th, td {
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
<c:import url="pageComponent/header.jsp"/>
<session class="wrapper">
	<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">	
		<a href="<c:url value='/j_spring_security_logout'/>">Logout</a>
	</sec:authorize>
	<h2>This demo is show real time market data using Angular JS</h2>
	<div  ng-controller="ModalDemoCtrl">
		<h3>Market Data</h3>
		<table id="stockList" border="1" style="width: 800px"  ng-controller="mainController">
			<tr>
				<th>Stock Symbol</th>
				<th>Stock Name</th>
				<th>Price</th>
				<th>Change</th>
				<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
					<th>Transaction</th>
				</sec:authorize>
			</tr>
			<tr ng-repeat="stock in stocksArray">
				<td>{{stock.stock.symbol}}</td>
				<td>{{stock.stockName}}</td>
				<td>{{stock.price}}</td>
				<td>
					<b ng-if="stock.change>0" style="color:green">+{{stock.change}}</b>
					<b ng-if="stock.change<0" style="color:red">{{stock.change}}</b>
					<b ng-if="stock.change==0" style="color:black">{{stock.change}}</b>
				</td>
				<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
					<td>						
						<input type="button" class="btn btn-default" name="buy" value="Buy" 
							ng-click="pass(stock); openBuy()" />
						<input ng-if="hasStock(stock)" type="button" class="btn btn-default" 
						name="sell" value="Sell" ng-click="pass(stock); openSell()" />
					</td>
				</sec:authorize>
			</tr>
		</table>
	</div>
<div  ng-controller="ModalDemoCtrl">
    <script type="text/ng-template" id="buyContent.html">
        <div class="modal-header">
            <h3 class="modal-title">Buy stocks: {{buyItem.stockName}}</h3>
        </div>
        <div class="modal-body">
            <label>Stock Symbol: </label>
			<b style="color:red">{{buyItem.stock.symbol}}</b><br/>
			<label>Stock Name: </label>
			<b style="color:red">{{buyItem.stockName}}</b><br/>
			<label>Unit Price: </label>
			<b style="color:red">{{buyItem.price}}</b><br/>
			<label>Quantity: </label>
			<input type="number" min="1" max={{upper}} value={{quan}} ng-model="quan"/>
			<input type="range" min="1" max={{upper}} value={{quan}} ng-model="quan"/>
			<br/>	
        </div>				
        <div class="modal-footer">
		<div>		
			<label style="margin-right:50px">Ready to buy <span style="color:red">{{quan}}</span>
			shares of <span style="color:red">{{buyItem.stock.symbol}}</span>? 
			Balance after transaction: <span style="color:red">$
			{{Math.round(user.balance - buyItem.price * quan)}}</span> </label>
		</div><br/>
            <button class="btn btn-primary" type="button" ng-click="ok()">OK</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>
    </script>
    <script type="text/ng-template" id="sellContent.html">
        <div class="modal-header">
            <h3 class="modal-title">Sell stocks: {{sellItem.stockName}} 
				(Currently own {{getAmount(sellItem)}})</h3>
        </div>
        <div class="modal-body">
            <label>Stock Symbol: </label>
			<b style="color:red">{{sellItem.stock.symbol}}</b><br/>
			<label>Stock Name: </label>
			<b style="color:red">{{sellItem.stockName}}</b><br/>
			<label>Unit Price: </label>
			<b style="color:red">{{sellItem.price}}</b><br/>
			<label>Quantity: </label>
			<input type="number" min="1" max={{getAmount(sellItem)}} value={{quan}} ng-model="quan"/>
			<input type="range" min="1" max={{getAmount(sellItem)}} value={{quan}} ng-model="quan"/>
			<br/>	
        </div>				
        <div class="modal-footer">
		<div>		
			<label style="margin-right:50px">Ready to sell <span style="color:red">{{quan}}</span>
			shares of <span style="color:red">{{sellItem.stock.symbol}}</span>? 
			Balance after transaction: <span style="color:red">$
			{{Math.round(user.balance + sellItem.price * quan)}}</span></label>
		</div><br/>
            <button class="btn btn-primary" type="button" ng-click="ok()">OK</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>
    </script>
</div>
</session>
<c:import url="pageComponent/footer.jsp"/>
</body>
</html>