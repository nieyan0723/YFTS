<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            <a href="home" class="logo">Yahoo <span class="lite">Finance</span></a>
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
				  <li class="dropdown">
                      <a data-toggle="dropdown" class="dropdown-toggle" >
                          <i class="icon_document_alt"></i>
                          <span>Forms</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
                      <ul class="dropdown-menu extended inbox">
                          <li><a class="" href="form_component.html">Form Elements</a></li>                          
                          <li><a class="" href="form_validation.html">Form Validation</a></li>
                      </ul>
                  </li>       
                  <li class="dropdown">
                      <a data-toggle="dropdown" class="dropdown-toggle">
                          <i class="icon_desktop"></i>
                          <span>UI Fitures</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
                      <ul class="dropdown-menu extended inbox">
                          <li><a class="" href="general.html">Elements</a></li>
                          <li><a class="" href="buttons.html">Buttons</a></li>
                          <li><a class="" href="grids.html">Grids</a></li>
                      </ul>
                  </li>
                  <li>
                      <a class="" href="widgets.html">
                          <i class="icon_genius"></i>
                          <span>Widgets</span>
                      </a>
                  </li>
                  <li>                     
                      <a class="" href="chart-chartjs.html">
                          <i class="icon_piechart"></i>
                          <span>Charts</span>
                          
                      </a>
                                         
                  </li>
                             
                  <li class="dropdown">
                      <a data-toggle="dropdown" class="dropdown-toggle">
                          <i class="icon_table"></i>
                          <span>Tables</span>
                          <span class="menu-arrow arrow_carrot-right"></span>
                      </a>
                      <ul class="dropdown-menu extended inbox">
                          <li><a class="" href="basic_table.html">Basic Table</a></li>
                      </ul>
                  </li>
                  <!-- user login dropdown start-->
                  <li class="dropdown" ng-controller="headerCtrl">
                      <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                          <span class="profile-ava">
                              <img alt="" src="img/download.jpg" width="30" height="30">
                          </span>
                          <span class="username">{{user.userName}}</span>
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
                  <!-- user login dropdown end -->                
              </ul>
              <!-- sidebar menu end-->
          </div>
      </header>      
      <!--header end-->
</body>
</html>