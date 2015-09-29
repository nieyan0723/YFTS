<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirmation page</title>
<style type="text/css">
#time, p, a {
	text-align:center;
	font-family: 'Unkempt', cursive;
	letter-spacing: 2px;
	font-weight: 700;
}

</style>
</head>
<body>
	<script language="JavaScript1.2" type="text/javascript">
		function delay() {
	   		var delay=document.getElementById("time").innerHTML;
	   		if(delay>0){
	   			delay--;
	   			document.getElementById("time").innerHTML=delay;
	   		} else {
	   			document.getElementById("signin").click();
	   		}
			setTimeout("delay()", 1000);
		}
	</script>
	<span id="time" style="background: red">3</span>
	<p>Activation succcess! ${userName}</p>
	
	<h2 id="go_home">This page will goto Yahoo Finance page after 3 seconds, if not click this link</h2>

	<form name="login-form" action="login_auto" method="POST" id="login-form" style="display:none">
		<input type="text" name="j_username" id="j_username" value="${userName}"/>
		<input type="submit" id="signin" type="submit" name="submit1">
	</form>
	<script type="text/javascript">
		delay();
	</script>&nbsp;

</body>
</html>