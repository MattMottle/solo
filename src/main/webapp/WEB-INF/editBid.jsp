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
</head>
<body>
	<h1>Hello, <c:out value="${loggedUser.firstName}"/>!</h1>
	<p><a href="/workinprocess">Home</a> <a href="/logout">Log out</a></p>
	<h3>Edit your bid of the <c:out value="${thisBid.jobWithBids.name}"/>:</h3>
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
		<input type="submit" value="Add Bid"/>
	</form:form>
</body>
</body>
</html>