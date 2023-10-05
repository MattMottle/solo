<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login And Registration</title>
<link rel="stylesheet" type="text/css" href="/css/logReg.css">
</head>
<body>
	<div class="container">
		<h1>Work In Process</h1>
		<div class="blocks">
			<div class="register">
				<h3>Register</h3>
				<form:form action="/register" method="post" modelAttribute="registerUser">
						<div><form:errors path="firstName" style="color: red"/></div>
						<div><form:errors path="lastName" style="color: red"/></div>
						<div><form:errors path="email" style="color: red"/></div>
						<div><form:errors path="password" style="color: red"/></div>
						<div><form:errors path="confirmedPassword" style="color: red"/></div>
					<p>
						<form:label path="firstName">First Name:</form:label>
						<form:input path="firstName"/>
					</p>
					<p>
						<form:label path="lastName">Last Name:</form:label>
						<form:input path="lastName"/>
					</p>
					<p>
						<form:label path="email">Email:</form:label>
						<form:input path="email"/>
					</p>
					<p>
						<form:label path="password">Password:</form:label>
						<form:input type="password" path="password"/>
					</p>
					<p>
						<form:label path="confirmedPassword">Confirm Password:</form:label>
						<form:input type="password" path="confirmedPassword"/>
					</p>
					<button type=submit>Submit</button>
				</form:form>
			</div>
			<div class="login">
				<h3>Login</h3>
				<form:form action="/login" method="post" modelAttribute="loginUser">
					
						<div><form:errors path="loginEmail" style="color: red"/></div>
						<div><form:errors path="loginPassword" style="color: red"/></div>
					<p>
						<form:label path="loginEmail">Email:</form:label>
						<form:input path="loginEmail"/>
					</p>
					<p>
						<form:label path="loginPassword">Password:</form:label>
						<form:input type="password" path="loginPassword"/>
					</p>
					<button type=submit>Submit</button>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>