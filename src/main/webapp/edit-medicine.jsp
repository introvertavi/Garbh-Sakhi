<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.garbhsakhi.model.Medicine" %>

<%
Medicine m = (Medicine) request.getAttribute("medicine");
request.setAttribute("pageTitle","Medicines");
%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Edit Medicine</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/modern-style.css">

</head>

<body>

<jsp:include page="components/header.jsp"/>
<jsp:include page="components/sidebar.jsp"/>
<jsp:include page="components/bottom-nav.jsp"/>

<div class="main-content">
<div style="max-width:800px;margin:0 auto;padding:24px;">

<div class="gs-card">

<h3>Edit Medicine</h3>

<form method="post" action="edit-medicine">

<input type="hidden" name="id" value="<%=m.getId()%>">

<div class="row-2">

<div class="field">
<label>Medicine Name</label>
<input type="text" name="medicineName" value="<%=m.getMedicineName()%>">
</div>

<div class="field">
<label>Dosage</label>
<input type="text" name="dosage" value="<%=m.getDosage()%>">
</div>

</div>

<div class="row-2">

<div class="field">
<label>Frequency</label>
<input type="text" name="frequency" value="<%=m.getFrequency()%>">
</div>

<div class="field">
<label>Time of Day</label>
<input type="text" name="timeOfDay" value="<%=m.getTimeOfDay()%>">
</div>

</div>

<div class="row-2">

<div class="field">
<label>Start Date</label>
<input type="date" name="startDate" value="<%=m.getStartDate()%>">
</div>

<div class="field">
<label>End Date</label>
<input type="date" name="endDate" value="<%=m.getEndDate()%>">
</div>

</div>

<div class="field">
<label>Notes</label>
<textarea name="notes"><%=m.getNotes()%></textarea>
</div>

<br>

<button class="btn-primary">Update Medicine</button>

</form>

</div>
</div>
</div>

</body>
</html>