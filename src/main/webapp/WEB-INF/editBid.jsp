<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ page isErrorPage="true" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Bid</title>
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
		<h3>Edit Your Bid of the <c:out value="${thisBid.jobWithBids.name}"/>:</h3>
		<form:form action="/bids/${thisBid.id }/editBid" method="POST" modelAttribute="thisBid">
			<input type="hidden" name="_method" value="PUT"/>
			<p>
				<form:errors path="amount"/>
				<form:errors path="bidRemarks"/>
				<form:errors path="bidRemarks"/>
			</p>
			<p>
				<form:label path="amount">Bid Amount:</form:label>
				<form:input type="number" step=".01" path="amount"/>
			</p>
			<p>
				<form:label path="bidRemarks">Bid Remarks:</form:label>
				<form:textarea rows="4" path="bidRemarks"/>
			</p>
			<form:input type="hidden" path="bidder" value="${loggedUser.id}"/>
			<form:input type="hidden" path="jobWithBids" value="${thisBid.jobWithBids.id}"/>
			<button type="submit" class="btn btn-dark">+ Add Bid</button>
	</form:form>
	</div>
</body>
</body>
</html>