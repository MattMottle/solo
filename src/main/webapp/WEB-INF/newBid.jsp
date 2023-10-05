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
</head>
<body>
	<h1>Hello, <c:out value="${loggedUser.firstName}"/>!</h1>
	<p><a href="/workinprocess">Home</a> <a href="/logout">Log out</a></p>
	<h3>Let's bid on the <c:out value="${jobToBid.name}"/>:</h3>
	<form:form action="/bids/addBid" method="POST" modelAttribute="newBid">
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
		<form:input type="hidden" path="jobWithBids" value="${jobToBid.id}"/>
		<input type="submit" value="Add Bid"/>
	</form:form>
</body>
</html>