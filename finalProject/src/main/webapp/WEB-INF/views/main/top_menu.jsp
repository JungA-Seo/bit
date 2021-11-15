<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	.carousel-background{
		background-color: #000;
    	opacity: 0.8;
	}
</style>

<div id="top_menu_wrap">
	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel" >
	  <div class="carousel-indicators">
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  </div>
	  <div class="carousel-inner">
	  	<div class="carousel-background">
		    <div class="carousel-item active">
		      <!-- <img src="./image/menu1.jpg" class="d-block w-100" alt="..."> -->	<!-- 사이즈 3363 x 1000 -->
		      <img src="./image/bada.jpg" class="d-block w-100" alt="...">	<!-- 사이즈 3363 x 1000 -->
		    </div>
		    <div class="carousel-item">
		      <!-- <img src="./image/menu2.jpg" class="d-block w-100" alt="..."> -->	<!-- 사이즈 3363 x 1000 -->
		      <img src="./image/hana.jpg" class="d-block w-100" alt="...">	<!-- 사이즈 3363 x 1000 -->
		    </div>
		    <div class="carousel-item">
		      <!-- <img src="./image/menu2.jpg" class="d-block w-100" alt="..."> -->	<!-- 사이즈 3363 x 1000 -->
		      <img src="./image/pinkpink.jpg" class="d-block w-100" alt="...">	<!-- 사이즈 3363 x 1000 -->
		    </div>
		    <!-- <div class="carousel-item">
		      <img src="./image/menu2.jpg" class="d-block w-100" alt="...">	사이즈 3363 x 1000
		      <img src="./image/noeul.jpg" class="d-block w-100" alt="...">	사이즈 3363 x 1000
		    </div> -->
	    </div>
	  </div>
	  
	</div>
</div>