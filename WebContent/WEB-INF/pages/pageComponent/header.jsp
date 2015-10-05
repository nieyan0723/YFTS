<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script src="js/header.js"></script>
</head>
<body>
	 <header class="header dark-bg">
            <div class="toggle-nav">
                <div class="icon-reorder tooltips" data-original-title="Toggle Navigation" data-placement="bottom"></div>
            </div>

            <!--logo start-->
            <a href="home" class="logo">Yahoo <span class="lite">Finance</span>  <sec:authorize access="hasRole('ROLE_ADMIN')">ADMIN PAGE</sec:authorize></a>
            <!--logo end-->

       <!-- <div class="nav search-row" id="top_menu">    --> 
                <!--  search form start -->
      <!--      <ul class="nav top-menu">                    
                    <li>
                        <form class="navbar-form">
                            <input class="form-control" placeholder="Search" type="text">
                        </form>
                    </li>                    
                </ul>    --> 
                <!--  search form end -->                
     <!--   </div>   --> 

			<div class="top-nav notification-row">
              <!-- sidebar menu start-->
              <ul class="nav pull-right top-menu">                
                  <li class="active">
                      <a class="" href="home">
                          <i class="icon_house_alt"></i>
                          <span>Home</span>
                      </a>
                  </li>
				  <sec:authorize access="hasRole('ROLE_USER')">
                  <li>
                      <a class="" href="portfolio">
                          <i class="icon_desktop"></i>
                          <span>My Portfolio</span>
                      </a>
                  </li>
                  <li>
                      <a class="" href="history">
                          <i class="icon_document_alt"></i>
                          <span>Transaction History</span>
                      </a>
                  </li> 
                  </sec:authorize>
                  <sec:authorize access="hasRole('ROLE_ADMIN')">
                  <li>
                      <a class="" href="pending">
                          <i class="icon_pens"></i>
                          <span>Pending Process</span>
                      </a>
                  </li>
                  <li>
                      <a class="" href="stock">
                          <i class="icon_currency"></i>
                          <span>Stock Process</span>
                      </a>
                  </li> 
                  </sec:authorize>
                  <li>
                      <a class="" href="marketdata">
                          <i class="icon_globe-2"></i>
                          <span>Market Data</span>
                      </a>
                  </li>
                  <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')">
                  <!-- user login dropdown start-->
                  <li class="dropdown" ng-controller="headerCtrl">
                      <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                          <span class="profile-ava">
                              <img alt="" src="img/download.jpg" width="30" height="30">
                          </span>
                          <span class="username">Hello, {{user.userName}}</span>
                          <b class="caret"></b>
                      </a>
                      <ul class="dropdown-menu extended logout">
                          <div class="log-arrow-up"></div>
                          <li class="prof-info-container">
                          	<div class="profile-ava prof-big"><img alt="" src="img/download.jpg" width="50" height="50"></div>
                          	<div class="prof-info">
                          		<ul>
                          			<li>{{user.firstName}} {{user.lastName}}</li>
                          			<li>{{user.email}}
                          		</ul>                          	
                          	</div>
                          </li>
                          <li>
                          	<a href="<c:url value='/j_spring_security_logout'/>"><i class="icon_key_alt"></i>Logout</a>
                          </li>
                      </ul>
                  </li>
                  </sec:authorize>
                  <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_USER')?false:true">
                  <li>
                  	<a class="" href="login#login_up">
                  	 	<span class="username">Log in</span>
                  	</a>
                  </li>
                  </sec:authorize>
                  <!-- user login dropdown end -->                
              </ul>
              <!-- sidebar menu end-->
          </div>
      </header>      
      <!--header end-->
</body>
</html>