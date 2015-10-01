<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Real Time Market Data</title>
    <script src="/YFTS/resources/js/angular.min.js"></script>
    <script src="/YFTS/resources/js/ui-bootstrap-tpls-0.13.4.min.js"></script>
    <script src="/YFTS/resources/js/angular-animate.min.js"></script>
    <script src="/YFTS/resources/js/activity.js"></script>
    <link href="/YFTS/resources/css/bootstrap.min.css" rel="stylesheet">
<style>
	h3 {
		color: blue;
	}
	td {
		text-align:center;
	}
</style>
</head>
<body ng-app="ui.bootstrap.demo">
	<h2>This demo is show real time market data using Angular JS</h2>
	<div  ng-controller="ModalDemoCtrl">
		<h3>Market Data</h3>
		<table id="stockList" border="1" style="width: 800px"  ng-controller="mainController">
			<tr>
				<th>Stock ID</th>
				<th>Stock Name</th>
				<th>Price</th>
				<th>Change</th>
				<th>Transaction</th>
			</tr>
			<tr ng-repeat="stock in stocksArray">
				<td>{{stock.symbol}}</td>
				<td>{{stock.stockName}}</td>
				<td>{{stock.price}}</td>
				<td>
					<b ng-if="stock.change>0" style="color:green">{{stock.change}}</b>
					<b ng-if="stock.change<0" style="color:red">{{stock.change}}</b>
					<b ng-if="stock.change==0" style="color:black">{{stock.change}}</b>
				</td>
				<td><input type="button" class="btn btn-default" name="buy" value="Buy"
					ng-click="pass(stock); open()" /></td>
			</tr>
		</table>
	</div>
<div>
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
			<input type="number" min=1 max=10000 ng-model="quan"/><br/>	
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary" type="button" ng-click="ok()">OK</button>
            <button class="btn btn-warning" type="button" ng-click="cancel()">Cancel</button>
        </div>
    </script>

    <button type="button" class="btn btn-default" ng-click="open()">Open me!</button>
    <button type="button" class="btn btn-default" ng-click="toggleAnimation()">Toggle Animation ({{ animationsEnabled }})</button>
    <div ng-show="selected">Selection from a modal: {{ selected }}</div>
</div>
</body>
</html>