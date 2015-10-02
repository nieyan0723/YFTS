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
    <script	src="js/jquery.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
.alert {
	display: none;
}
</style>
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
	<div ng-controller="balController">
		<table  id="tbl">
			<tr>
				<th><button id="addmoney" data-toggle="modal"
						data-target="#balModal" class="btn btn-primary btn-sm">Add
						Money</button></th>
				<th>Your Balance: <span style="color: red"><span></span></span><span id="j_name" style="color: red">{{currentbalance}}</span></th>
			</tr>
		</table>
		<!-- Add Money Modal -->
		<div class="modal fade" id="balModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<!-- modal header -->
					<div class="modal-header">
						<button type="button" class="close"
							ng-click="myStyle={'display':'none'}" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Adding Money</h4>
					</div>
					<!-- modal body -->
					<div class="modal-body">
						<form name="balForm" class="form-horizontal"
							ng-submit="addMoneyRequest(request, 'ajaxResult')" novalidate>
							<div class="panel panel-default">
								<div class="panel-body bg-primary">{{welcomeMsg}}</div>
							</div>
							<!-- Amount -->
							<div class="form-group">
								<label for="amount" class="col-sm-2 control-label">Amount:</label>
								<span class="glyphicon glyphicon-asterisk"></span>
								<div class="col-sm-6">
									<input type="number" class="form-control" id="amount"
										ng-model="request.amount" placeholder="Amount" name="amount"
										required>
								</div>
							</div>
							<!--    	        		<div class="well well-sm">
          				<strong>
          					<span class="glyphicon glyphicon-asterisk"></span>
          					Required Field
          				</strong>
          			</div> -->

							<!-- alert -->
							<div class="alert" ng-style="myStyle" id="addSuccess">
								<p>Add Money Successfully</p>
							</div>
							<!-- modal footer -->
							<div class="modal-footer">
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button class="btn btn-default" data-dismiss="modal"
											ng-click="myStyle={'display':'none'}">Close</button>
										<button ng-disabled="!isAmountValid()" id="confirm"
											type="submit" class="btn btn-primary"
											ng-click="myStyle={'display':'block'}">Confirm</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div style="display: none">
		<p id="remoteBalance">${balance}</p>
		<!-- jsp expression -->
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