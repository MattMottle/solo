<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add a Job</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/newJob.css">
</head>
<body background="/images/tools3.jpg">
	<div class="container">
		<h1>
			<img src="/images/hammerWrench1.png" alt="Hammer Wrench" style="width: 100px">
			Work In Process
		</h1>
		<div class="links">
			<a href="http://localhost:8080/workinprocess">Home</a>
			<a href="http://localhost:8080/logout">Logout</a>
		</div>
		<div class="form">
			<h3>What Job Would You Like</h3>
			<h3>Done Today?</h3>
			<form:form action="/workinprocess/new/process" method="post" modelAttribute="job">
				<div style="color: red"><form:errors path="name"/></div>
				<div style="color: red"><form:errors path="maxBudget"/></div>
				<div style="color: red"><form:errors path="isBidAccepted"/></div>
				<div style="color: red"><form:errors path="description"/></div>
				<p>
					<%-- <form:label path="name">Name:</form:label> --%>
					<form:input path="name" placeholder="Name"/>
				</p>
				<p>
					<%-- <form:label path="maxBudget">Budget:</form:label> --%>
					<form:input type="number" step="0.01" path="maxBudget" placeholder="Budget"/>
				</p>
				<p>
					<form:label path="isBidAccepted">Bid Accepted?</form:label>
					<form:radiobutton path="isBidAccepted" value="true" label="yes"/>
					<form:radiobutton path="isBidAccepted" value="false" label="no" checked="true"/>
				<p>
					
					<form:textarea rows="4" path="description" placeholder="Description"/>
				</p>
				<p>
					<form:input type="hidden" path="jobCreator" value="${user.id}"/>
				</p>
				<button type="submit" class="btn btn-dark">Create</button>
			</form:form>
		</div>
	</div>
</body>
</html>