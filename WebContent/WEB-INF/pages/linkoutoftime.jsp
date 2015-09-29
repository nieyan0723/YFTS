<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1>linkoutoftime!!!!!!!!!!!!!!!!!</h1>
<script language="JavaScript1.2" type="text/javascript">
	function delayURL(url) {
   		var delay=document.getElementById("time").innerHTML;
   		if(delay>0){
   			delay--;
   			document.getElementById("time").innerHTML=delay;
   		} else {
   			window.top.location.href=url;
   		}
		setTimeout("delayURL('" + url + "')", 1000);
	}
</script>
	<span id="time" style="background: red">3</span>
	<br>
	<a href="http://localhost:8080/YFTS/login.html">This page will goto Yahoo Finance page after 3 seconds, if not click this link</a>
<script type="text/javascript">
	delayURL("http://localhost:8080/YFTS/login.html");
</script>&nbsp;
</body>
</html>