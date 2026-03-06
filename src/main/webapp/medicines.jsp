<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.garbhsakhi.model.Medicine" %>

<%
List<Medicine> medicines =
    (List<Medicine>) request.getAttribute("medicines");

request.setAttribute("pageTitle","Medicines");
%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Medicines - Garbh Sakhi</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/modern-style.css">

<link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css"
      rel="stylesheet">

</head>

<body>

<!-- GLOBAL LAYOUT -->
<jsp:include page="components/header.jsp"/>
<jsp:include page="components/sidebar.jsp"/>
<jsp:include page="components/bottom-nav.jsp"/>
<jsp:include page="components/fab-emergency.jsp"/>

<div class="main-content">
<div style="max-width:1100px;margin:0 auto;padding:24px;">

<!-- ================= PAGE HEADER ================= -->
<div class="page-header">
    <h2>💊 Medicines</h2>
    <p class="text-muted">
        Track daily supplements and prescriptions
    </p>
</div>

<!-- ================= ADD MEDICINE ================= -->
<div class="gs-card card-accent">

<h4 style="margin-bottom:20px;">Add Medicine</h4>

<form method="post" action="medicines">

<div class="row-2">

<div class="field">
<label>Medicine Name</label>
<input type="text" name="medicineName" placeholder="e.g. Iron Tablet" required>
</div>

<div class="field">
<label>Dosage</label>
<input type="text" name="dosage" placeholder="e.g. 1 tablet">
</div>

</div>

<div class="row-2">

<div class="field">
<label>Frequency</label>
<select name="frequency">
<option>Daily</option>
<option>Weekly</option>
<option>As Needed</option>
</select>
</div>

<div class="field">
<label>Time of Day</label>
<select name="timeOfDay">
<option>Morning</option>
<option>Afternoon</option>
<option>Night</option>
<option>3 Times</option>
</select>
</div>

</div>

<div class="row-2">

<div class="field">
<label>Start Date</label>
<input type="date" name="startDate">
</div>

<div class="field">
<label>End Date</label>
<input type="date" name="endDate">
</div>

</div>

<div class="field">
<label>Notes</label>
<textarea name="notes" rows="3" placeholder="Notes (optional)"></textarea>
</div>

<div class="actions">
<button type="submit" class="btn-primary">
➕ Add Medicine
</button>
</div>

</form>
</div>

<!-- ================= MEDICINE LIST ================= -->
<div class="gs-card card-accent" style="margin-top:20px;">

<h4>Your Medicines</h4>

<%
if (medicines == null || medicines.isEmpty()) {
%>

<p class="text-muted" style="margin-top:10px;">
💊 No medicines added yet
</p>

<%
} else {
for (Medicine m : medicines) {
%>

<div class="appointment-card" style="margin-top:12px;">

<div class="appointment-info">

<h5><%= m.getMedicineName() %></h5>

<p class="text-muted">
<%= m.getDosage()==null?"":m.getDosage() %>
</p>

<span class="status-badge upcoming">
<%= m.getFrequency() %>
</span>

<span class="status-badge completed">
<%= m.getTimeOfDay() %>
</span>

</div>
</div>

<%
}
}
%>

</div>

</div>
</div>

</body>
</html>