<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
		<div class="container">
		<div class="banner">
			<div class="title">
				<h1>Work In Process</h1>
				<h3>Welcome, <c:out value="${loggedUser.firstName}"/>!</h3>
				<h4>Current Jobs:</h4>
			</div>
			<div class="links">
				<a href="http://localhost:8080/logout">Logout</a>
				<a href="http://localhost:8080/workinprocess/new">+ Add a Job!</a>
			</div>
		</div>
		<div class="table">
			<table class="table table-striped">
			  <thead>
			    <tr>
			      <th scope="col">Job</th>
			      <th scope="col">Max Budget</th>
			      <th scope="col">Posted By</th>
			      <th scope="col">Actions</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="job" items="${jobs}">
				    <tr>
				      <td><c:out value="${job.name}"/></td>
				      <td>$<fmt:formatNumber type="number" minFractionDigits="2" value="${job.maxBudget}"/></td>
				      <td><c:out value="${job.jobCreator.firstName}"/></td>
				      <td>
				      	<a href="http://localhost:8080/workinprocess/${job.id}">View</a>
				      	<c:if test="${loggedUser.id == job.jobCreator.id }">
				      		<a href="/workinprocess/${job.id}/edit">Edit</a>
				      		<form action="/${job.id}/delete" method="POST">
				      			<input type="hidden" name="_method" value="Delete"/>
				      			<input type="submit" value="Delete"/>
				      		</form>
				      	</c:if>
				    </tr>
				</c:forEach>
			  </tbody>
			</table>
		</div>
	</div>
</body>
</html>