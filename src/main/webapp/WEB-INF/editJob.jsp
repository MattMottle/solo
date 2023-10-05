<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Job</title>
</head>
<body>
	<div class="container">
	<h1>What would you like to change?</h1>
		<div class="form">
				<form:form action="/workinprocess/${job.id}/edit/process" method="post" modelAttribute="job">
				 <input type="hidden" name="_method" value="put">
					<div style="color: red;"><form:errors path="name"/></div>
					<div style="color: red;"><form:errors path="maxBudget"/></div>
					<div style="color: red;"><form:errors path="isBidAccepted"/></div>
					<div style="color: red;"><form:errors path="description"/></div>
					<p>
						<form:label path="name">Name:</form:label>
						<form:input path="name"/>
					</p>
					<p>
						<form:label path="maxBudget">Max Budget:</form:label>
						<form:input type="number" step="0.01" path="maxBudget"/>
					</p>
					<p>
						<form:label path="isBidAccepted">Bid Accepted?</form:label>
						<form:radiobutton path="isBidAccepted" value="true" label="yes"/>
						<form:radiobutton path="isBidAccepted" value="false" label="no" checked="true"/>
					<p>
						<form:label path="description">Description:</form:label>
						<form:textarea rows="4" path="description"/>
					</p>
				    <form:input type="hidden" path="jobCreator" value="${user.id}"/>
				    <form:input type="hidden" path="id" value="${job.id}"/>    
				    <button class="button">Submit</button>
				</form:form>
			</div>
		<a href="http://localhost:8080/workinprocess">Home</a>
		</div>
</body>
</html>