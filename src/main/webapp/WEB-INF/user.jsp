<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>
</head>
<body>
		<div class="container">
		<div class="banner">
			<h1>${user.firstName} ${user.lastName}</h1>
			<a href="http://localhost:8080/workinprocess">Home</a> |
			<a href="http://localhost:8080/user/${user.id}/new_review">Add a Review</a>
		</div>
		<div class="details">
			<p>${user.location}</p>
			<p>User's jobs:</p>
			<c:forEach var="job" items="${jobs}">
			  	<c:if test="${user.id == job.jobCreator.id}">
			  	<p><a href="http://localhost:8080/workinprocess/${job.id}">${job.name}</a></p>
			</c:if>
			</c:forEach>
		</div>
		<c:if test="${loggedUser.id == reviewer.id}">
			<div class="actions">
				<form action="/workinprocess/${job.id}/edit" method="get">
					<input type="hidden" value="Edit"/>
					<button class="edit">Edit</button>
				</form>
				<form action="/${job.id}/delete" method="post">
			      	<input type="hidden" name="_method" value="delete" />
			      	<button class="delete">Delete</button>
			    </form>
			</div>
		</c:if>
		<h2>Reviews:</h2>
		<p>Average Rating: <c:out value="${averageRating}"/></p>
		<c:forEach var="thisReview" items="${user.getReviewedReviews()}">
			<p>Added By: <c:out value="${ thisReview.reviewer.firstName}"/> <c:out value="${ thisReview.reviewer.lastName}"/></p>
			<p>Rating: <c:out value="${ thisReview.rating}"/>
			<p>User Review: <c:out value="${thisReview.reviewText}"/></p>
			
			<c:if test="${loggedUser.id == thisReview.reviewer.id}">
			<div class="actions">
				<form action="/review/${thisReview.id}/edit_review" method="get">
					<input type="hidden" value="Edit"/>
					<button class="edit">Edit</button>
				</form>
				<form action="/reviews/${thisReview.id}/deleteReview" method="post">
			      	<input type="hidden" name="_method" value="delete" />
			      	<button class="delete">Delete</button>
			    </form>
			</div>
		</c:if>
		</c:forEach>
	</div>
</body>
</html>