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
</head>
<body>
	<div class="container">
		<h1>What job would like done today?</h1>
		<form:form action="/workinprocess/new/process" method="post" modelAttribute="job">
			<div style="color: red"><form:errors path="name"/></div>
			<div style="color: red"><form:errors path="maxBudget"/></div>
			<div style="color: red"><form:errors path="isBidAccepted"/></div>
			<div style="color: red"><form:errors path="description"/></div>
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
			<p>
				<form:input type="hidden" path="jobCreator" value="${user.id}"/>
			</p>
			<button class="button">Create</button>
		</form:form>
		<a href="http://localhost:8080/workinprocess">Home</a>
	</div>
</body>
</html>