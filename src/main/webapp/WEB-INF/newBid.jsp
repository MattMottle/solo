<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ page isErrorPage="true" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Bid</title>
<link rel="stylesheet" type="text/css" href="/css/newBid.css">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body background="/images/brick2.jpg">
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
		<h3>Let's Bid on the <c:out value="${jobToBid.name}"/>:</h3>
		<form:form action="/bids/addBid" method="POST" modelAttribute="newBid">
			<p>
				<form:errors style="color: red" path="amount"/>
				<form:errors style="color: red" path="bidRemarks"/>
				<form:errors style="color: red" path="bidRemarks"/>
			</p>
			<p>
				<form:input type="number" step=".01" path="amount" placeholder="Bid Amount"/>
			</p>
			<p>
				<form:textarea rows="4" path="bidRemarks" placeholder="Bid Remarks"/>
			</p>
			<form:input type="hidden" path="bidder" value="${loggedUser.id}"/>
			<form:input type="hidden" path="jobWithBids" value="${jobToBid.id}"/>
			<button type="submit" class="btn btn-dark">+ Add Bid</button>
		</form:form>
	</div>
</body>
</html>