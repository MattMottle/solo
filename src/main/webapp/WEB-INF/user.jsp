<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
     <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
<link rel="stylesheet" type="text/css" href="/css/user.css">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body background="/images/floor.jpg">
		<div class="container">
		<div class="banner">
			<h1>
				<img src="/images/hammerWrench1.png" alt="Hammer Wrench" style="width: 100px">
				Work In Process
			</h1>
			<div class="links">
				<a href="http://localhost:8080/workinprocess">Home</a> 
				<a href="http://localhost:8080/user/${user.id}/new_review">Add a Review</a>
			</div>
			<h3>${user.firstName} ${user.lastName}</h3>
			<h3>${user.location}</h3>
		</div>
		<div class="details">
			<p>${user.firstName}'s jobs:</p>
			<c:forEach var="job" items="${jobs}">
			  	<c:if test="${user.id == job.jobCreator.id}">
			  	<p><a href="http://localhost:8080/workinprocess/${job.id}">${job.name}</a></p>
			</c:if>
			</c:forEach>
		</div>
		<h2>Reviews:</h2>
		<p>Average Rating: <fmt:formatNumber type="number" maxFractionDigits="1" value="${averageRating}"/></p>
		<c:forEach var="thisReview" items="${user.getReviewedReviews()}">
			<div class="review">
			<p>Added By: <a href="http://localhost:8080/user/${thisReview.reviewer.id}"><c:out value="${ thisReview.reviewer.firstName}"/> <c:out value="${ thisReview.reviewer.lastName}"/></a></p>
			<p>Rating: <c:out value="${ thisReview.rating}"/>
			<p>User Review: <c:out value="${thisReview.reviewText}"/></p>
			
			<c:if test="${loggedUser.id == thisReview.reviewer.id}">
			<div class="actions">
				<form action="/reviews/${thisReview.id}/edit_review" method="get">
					<input type="hidden" value="Edit"/>
					<button type="submit" class="btn btn-dark">Edit</button>
				</form>
				<form action="/reviews/${thisReview.id}/deleteReview" method="post">
			      	<input type="hidden" name="_method" value="delete" />
			      	<button type="submit" class="btn btn-dark">Delete</button>
			    </form>
			</div>
		</c:if>
		</div>
		</c:forEach>
	</div>
</body>
</html>