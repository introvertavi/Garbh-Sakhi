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

<!-- SAME FILES AS DASHBOARD -->
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

<!-- MAIN CONTENT (IDENTICAL TO DASHBOARD) -->
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
<div class="gs-card card-accent" style="padding:22px;">

<h4 style="margin-bottom:16px;">Add Medicine</h4>

<form method="post" action="medicines" class="gs-form">

<div style="
display:grid;
grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
gap:14px;
margin-bottom:14px;
">

<input name="medicineName" placeholder="Medicine Name" required>

<input name="dosage" placeholder="Dosage (e.g. 1 tablet)">

<select name="frequency">
<option>Daily</option>
<option>Weekly</option>
<option>As Needed</option>
</select>

<select name="timeOfDay">
<option>Morning</option>
<option>Afternoon</option>
<option>Night</option>
<option>3 Times</option>
</select>

<input type="date" name="startDate">
<input type="date" name="endDate">

</div>

<textarea name="notes" placeholder="Notes (optional)"></textarea>

<br><br>

<button class="primary-btn">
+ Add Medicine
</button>

</form>
</div>

<!-- ================= MEDICINE LIST ================= -->
<div class="gs-card card-accent" style="padding:22px;margin-top:20px;">

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