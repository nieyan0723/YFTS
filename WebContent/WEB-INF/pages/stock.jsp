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
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
</script>
<script>
	$(document).ready(function(){
 		$("#j_symbol").on("blur", validateForm);
 		$("#j_stockName").on("blur", validateForm);
	});

	function validateForm(){
		var symbol = $("#j_symbol").val();
		var stockName = $("#j_stockName").val();
		var newStock = {symbol: $("#j_symbol").val()};
		if (symbol.length==0){
			$("#symbol_error").text("Please input valid stock symbol!");
			$("#symbol_error").css("visibility", "visible");
			$("#j_add").prop("disabled", true);
		}else {
			$("#symbol_error").css("visibility", "hidden");
		}
		if (stockName.length==0){
			$("#name_error").text("Please input valid stock name!");
			$("#name_error").css("visibility", "visible");
			$("#j_add").prop("disabled", true);
		}
		else {
			$("#name_error").css("visibility", "hidden");
		}
		if (symbol.length!=0 && stockName.length!=0 && $("#stock_error").css("visibility")!="visible"){
			$("#j_add").prop("disabled", false);
		}
		
		$.ajax({
			url: "validateStock",
			type: "get",
			dataType: "text",
			data: newStock,
			async: false,
			success: function(response){
				if (response != "valid"){
					$("#stock_error").text(response);
					$("#stock_error").css("visibility", "visible");
					$("#j_add").prop("disabled", true);
				}else {
					$("#stock_error").css("visibility", "hidden");
				}
			},
			error: function(){
				alert("error");
			}
		});
	};
</script>
<style type="text/css">
.error {
	color: red;
	visibility: hidden;
}
</style>
</head>
<body>
	<h1>
		<font color="red">All Stocks</font>
	</h1>
	<form action="stock" id="listForm" method="post">
		<table border="1">
			<tr>
				<th>Stock ID</th>
				<th>Symbol</th>
				<th>Stock Name</th>
				<th>Delete</th>
			</tr>
			<c:forEach var="stock" items="${stockList}">
				<tr>
					<td>${stock.sid}</td>
					<td>${stock.symbol}</td>
					<td>${stock.stockName}</td>
					<td><button class="delete" name="delete" value="${stock.sid}">Delete</button></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<br />
	<h2>Add Stock</h2>
	<div class="error" id="stock_error">Error</div>
	<form action="addStock" id="addForm" method="post">
		<table>
			<tr>
				<td>Stock Symbol:</td>
				<td><input type="text" name="symbol" id="j_symbol" required />
				</td>
				<td>
					<div class="error" id="symbol_error">msg</div>
				</td>
			</tr>
			<tr>
				<td>Stock Name:</td>
				<td><input type="text" name="stockName" id="j_stockName"
					required /></td>
				<td>
					<div class="error" id="name_error">msg</div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td><input type="reset" value="Clear" /> <input type="submit"
					value="Submit" id="j_add" /></td>
			</tr>
		</table>
	</form>
</body>
</html>