<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
    <script	src="js/jquery.min.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
<style>
	.alert {
		display: none;
	}
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
				<tr ng-repeat=" stock in stockInfo">
					<td>{{stock.stock.sid}}</td>
					<td>{{stock.stock.symbol}}</td>
					<td>{{stock.stockName}}</td>
					<td>{{stock.price}}</th>
					<td>
						<b ng-if="stock.change>0" style="color:green">+{{stock.change}}</b>
						<b ng-if="stock.change<0" style="color:red">{{stock.change}}</b>
						<b ng-if="stock.change==0" style="color:black">{{stock.change}}</b></th>
					<td>{{stock.quantity}}</td>
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
		</form>
		<div id="buySuccess" ng-show="buySuccess&&!sellSuccess&&!addSuccess">Buying Transaction Success!</div>
		<div id="sellSuccess" ng-show="sellSuccess&&!buySuccess&&!addSuccess">Selling Transaction Success!</div>
	
	<br/>
	</div>
	<div ng-controller="mainController">
		<div ng-controller="ModalDemoCtrl">
				<button id="addBalance" class="btn btn-primary btn-sm"
					ng-click="openAdd()">Add Balance</button>
				<span>Current Balance: <b style="color: red">{{user.balance}}</b></span>	
				<div id="addSuccess" ng-show="addSuccess&&!sellSuccess&&!sellSuccess">Adding money Success!</div>	
			
		</div>
		
	</div>


<div>
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
    <script type="text/ng-template" id="addContent.html">
        <div class="modal-header">
            <h3 class="modal-title">Add Balance (Currently have {{balance}})</h3>
        </div>
        <div class="modal-body">
			<label>Amount: </label>
			<input type="number" min="1" max={{2147483647-balance}} value={{quan}} ng-model="quan"/>
			<input type="range" min="1" max={{2147483647-balance}} value={{quan}} ng-model="quan"/>
			<br/>
        </div>		
        <div class="modal-footer">
		<div>		
			<label style="margin-right:50px">Ready to add <span style="color:red">$ {{quan}}</span>
				 to your account? <br/>
				Balance after adding: <span style="color:red">$ {{balance + quan}}</span></label>
		</div><br/>
            <button class="btn btn-primary" type="button" ng-click="ok()">OK</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>
    </script>
</div>
</body>
</html>