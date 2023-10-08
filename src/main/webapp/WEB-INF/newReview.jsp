<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review User</title>
<link rel="stylesheet" type="text/css" href="/css/review.css">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body background="/images/floor.jpg">
	<div class="container">
		<h1>
			<img src="/images/hammerWrench1.png" alt="Hammer Wrench" style="width: 100px">
			Work In Process
		</h1>
		<div class="links">
			<a href="/workinprocess">Home</a> 
			<a href="/logout">Log out</a>
		</div>
		<h3>Hello, <c:out value="${loggedUser.firstName}"/>!</h3>
		<h3>You Are Reviewing <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/>:</h3>
		<form:form action="/reviews/addReview" method="POST" modelAttribute="newReview">
				<form:errors style="red" path="rating"/>
				<form:errors style="red" path="reviewText"/>
				
			<p>
				<form:input type="number" path="rating" placeholder="Rating 1-5"/>
			</p>
			<p>
				<form:textarea rows="4" path="reviewText" placeholder="Review Text"/>
			</p>
			<form:input type="hidden" path="reviewer" value="${loggedUser.id}"/>
			<form:input type="hidden" path="reviewedPerson" value="${user.id}"/>
			<button type="submit" class="btn btn-dark">+ Add Review</button>
		</form:form>
	</div>
</body>
</html>