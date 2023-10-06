<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Job</title>
</head>
<body background="">
	<div class="container">
		<div class="banner">
			<h1>${job.name}</h1>
			<a href="http://localhost:8080/workinprocess">Home</a> |
			<a href="http://localhost:8080/bids/${job.id}/new_bid">Add a Bid</a>
		</div>
		<div class="details">
			<c:choose>
				<c:when test="${loggedUser.id == job.jobCreator.id}">
					<h3>You are looking to hire for ${job.name}!</h3>
				</c:when>
				<c:otherwise>
					<h3>${job.jobCreator.firstName} is looking to hire for ${job.name}!</h3>
				</c:otherwise>
			</c:choose>
			<p>${job.description}</p>
		</div>
		<c:if test="${loggedUser.id == job.jobCreator.id}">
			<div class="actions">
				<form action="/workinprocess/${job.id}/edit" method="get">
					<input type="hidden" value="Edit"/>
					<button class="edit">Edit</button>
				</form>
				<form action="/${job.id}/delete" method="post">
			      	<input type="hidden" name="_method" value="delete" />
			      	<button class="delete">Delete</button>
			    </form>
			</div>
		</c:if>
		<h2>Bids:</h2>
		<c:forEach var="thisBid" items="${job.allBids}">
			<p>Added By: <a href="http://localhost:8080/user/${thisBid.bidder.id}"><c:out value="${ thisBid.bidder.firstName}"/> <c:out value="${ thisBid.bidder.lastName}"/></a></p>
			<p>Amount: $<fmt:formatNumber type="number" minFractionDigits="2" value="${thisBid.amount}"/></p>
			<p>Bid Remarks: <c:out value="${thisBid.bidRemarks}"/></p>
			
			<c:if test="${loggedUser.id == thisBid.bidder.id}">
			<div class="actions">
				<form action="/bids/${thisBid.id}/edit_bid" method="get">
					<input type="hidden" value="Edit"/>
					<button class="edit">Edit</button>
				</form>
				<form action="/bids/${thisBid.id}/deleteBid" method="post">
			      	<input type="hidden" name="_method" value="delete" />
			      	<button class="delete">Delete</button>
			    </form>
			</div>
		</c:if>
		<c:if test="${loggedUser.id == job.jobCreator.id}">
			<div class="accept">
				<form:form action="/workinprocess/${job.id}/edit/process" method="post" modelAttribute="job">
				 <input type="hidden" name="_method" value="put">
	
						<form:input type="hidden" path="name"/>
					
						<form:input type="hidden" step="0.01" path="maxBudget"/>

						<form:input type="hidden" path="isBidAccepted" value="true" label="yes"/>
					
						<form:input type="hidden" rows="4" path="description"/>
	
				    <form:input type="hidden" path="jobCreator" value="${user.id}"/>
				    <form:input type="hidden" path="id" value="${job.id}"/>    
				    <button class="button">Accept Bid</button>
				</form:form>
			</div>
		</c:if> 
		</c:forEach>
	</div>
</body>
</html>