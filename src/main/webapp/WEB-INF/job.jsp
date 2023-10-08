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
<link rel="stylesheet" type="text/css" href="/css/job.css">
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
</head>
<body background="/images/brick2.jpg">
	<div class="container">
		<div class="banner">
			<h1>
				<img src="/images/hammerWrench1.png" alt="Hammer Wrench" style="width: 100px">
				Work In Process
			</h1>
			<div class="links">
				<a href="http://localhost:8080/workinprocess">Home</a> 
				<a href="http://localhost:8080/bids/${job.id}/new_bid">+ Add a Bid</a>
				<a href="http://localhost:8080/logout">Logout</a>
			</div>
		</div>
		<div class="details">
			<%-- <h3>${job.name}</h3> --%>
			<c:choose>
				<c:when test="${loggedUser.id == job.jobCreator.id}">
					<h3>You are looking to hire for ${job.name}!</h3>
				</c:when>
				<c:otherwise>
					<h3>${job.jobCreator.firstName} is looking to hire for ${job.name}!</h3>
				</c:otherwise>
			</c:choose>
			<div class="desc">
				<p>Budget: $<fmt:formatNumber type="number" minFractionDigits="2" value="${job.maxBudget}"/></p>
				<p>Job Description:</p>
				<p>${job.description}</p>
		<c:if test="${loggedUser.id == job.jobCreator.id}">
			<div class="actions">
				<form action="/workinprocess/${job.id}/edit" method="get">
					<input type="hidden" value="Edit"/>
					<button type="submit" class="btn btn-dark">Edit</button>
				</form>
				<form action="/${job.id}/delete" method="post">
			      	<input type="hidden" name="_method" value="delete" />
			      	<button type="submit" class="btn btn-dark">Delete</button>
			    </form>
			</div>
		</c:if>
		</div>
		</div>
		<h2>Bids:</h2>
		<c:forEach var="thisBid" items="${job.allBids}">
			<div class=bid>
			<p>Added By: <a href="http://localhost:8080/user/${thisBid.bidder.id}"><c:out value="${ thisBid.bidder.firstName}"/> <c:out value="${ thisBid.bidder.lastName}"/></a></p>
			<p>Amount: $<fmt:formatNumber type="number" minFractionDigits="2" value="${thisBid.amount}"/></p>
			<p>Bid Remarks: <c:out value="${thisBid.bidRemarks}"/></p>
			
			<c:if test="${loggedUser.id == thisBid.bidder.id}">
			<div class="actions">
				<form action="/bids/${thisBid.id}/edit_bid" method="get">
					<input type="hidden" value="Edit"/>
					<button type="submit" class="btn btn-dark">Edit</button>
				</form>
				<form action="/bids/${thisBid.id}/deleteBid" method="post">
			      	<input type="hidden" name="_method" value="delete" />
			      	<button type="submit" class="btn btn-dark">Delete</button>
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
				    <button type="submit" class="btn btn-dark">Accept Bid</button>
				</form:form>
			</div>
		</c:if> 
		</div>
		</c:forEach>
	</div>
</body>
</html>