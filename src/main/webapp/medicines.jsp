<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.garbhsakhi.model.Medicine" %>

<%
request.setAttribute("pageTitle","Medicines");

List<Medicine> medicines =
    (List<Medicine>) request.getAttribute("medicines");

if (medicines == null) {
    com.garbhsakhi.model.User user =
        (com.garbhsakhi.model.User) session.getAttribute("user");

    if (user != null) {
        com.garbhsakhi.dao.MedicineDAO dao =
            new com.garbhsakhi.dao.MedicineDAO();

        medicines = dao.getMedicinesByUser(user.getId());
    }
}
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

<div class="appointment-card 
<%= m.getComputedStatus().equalsIgnoreCase("COMPLETED") ? "completed-card" : "" %>
<%= m.getComputedStatus().equalsIgnoreCase("STOPPED") ? "stopped-card" : "" %>
"
style="margin-top:12px; display:flex; justify-content:space-between; align-items:center;">

<div class="appointment-info">

<h5><%= m.getMedicineName() %></h5>

<p class="text-muted">
<%= m.getDosage()==null?"":m.getDosage() %>
</p>

<p class="text-muted">
Start: <%= m.getStartDate() %> | End: <%= m.getEndDate() %>
</p>
<%
int total = 0;
int done = 0;

String time = m.getTimeOfDay();

if ("Morning".equalsIgnoreCase(time) || "3 Times".equalsIgnoreCase(time)) {
    total++;
    if (m.isTakenMorning()) done++;
}

if ("Afternoon".equalsIgnoreCase(time) || "3 Times".equalsIgnoreCase(time)) {
    total++;
    if (m.isTakenAfternoon()) done++;
}

if ("Night".equalsIgnoreCase(time) || "3 Times".equalsIgnoreCase(time)) {
    total++;
    if (m.isTakenNight()) done++;
}

int percent = (total == 0) ? 0 : (done * 100 / total);
%>

<div class="progress-section">

<div class="progress-label">
    Progress: <%= done %>/<%= total %>
</div>

<div class="progress-bar">
    <div class="progress-fill" style="width:<%= percent %>%"></div>
</div>

<div class="dose-row">

<% if (time.equalsIgnoreCase("Morning") || time.equalsIgnoreCase("3 Times")) { %>
<a href="medicines?action=take&id=<%=m.getId()%>&time=morning"
   class="dose <%= m.isTakenMorning() ? "done" : "" %>">
   M
</a>
<% } %>

<% if (time.equalsIgnoreCase("Afternoon") || time.equalsIgnoreCase("3 Times")) { %>
<a href="medicines?action=take&id=<%=m.getId()%>&time=afternoon"
   class="dose <%= m.isTakenAfternoon() ? "done" : "" %>">
   A
</a>
<% } %>

<% if (time.equalsIgnoreCase("Night") || time.equalsIgnoreCase("3 Times")) { %>
<a href="medicines?action=take&id=<%=m.getId()%>&time=night"
   class="dose <%= m.isTakenNight() ? "done" : "" %>">
   N
</a>
<% } %>

</div>

</div>

<span class="status-badge <%= m.getComputedStatus().toLowerCase() %>">

<%
String status = m.getComputedStatus();
%>

<% if ("COMPLETED".equalsIgnoreCase(status)) { %>
    <i class="ri-check-line"></i>
<% } else if ("STOPPED".equalsIgnoreCase(status)) { %>
    <i class="ri-close-line"></i>
<% } else if ("EXPIRED".equalsIgnoreCase(status)) { %>
    <i class="ri-time-line"></i>
<% } else { %>
    <i class="ri-play-line"></i>
<% } %>

<%= "STOPPED".equalsIgnoreCase(status) ? "Discontinued" : status %>

</span>

<span class="status-badge completed">
<%= m.getTimeOfDay() %>
</span>

</div>

<div class="medicine-actions">

<a href="edit-medicine?id=<%=m.getId()%>" class="btn-ghost">
<i class="bi bi-pencil"></i>
</a>

<a href="delete-medicine?id=<%=m.getId()%>"
   onclick="return confirm('Delete this medicine?');"
   class="btn-ghost">
<i class="bi bi-trash"></i>
</a>

<% if ("ACTIVE".equalsIgnoreCase(m.getComputedStatus())) { %>

<a href="medicines?action=complete&id=<%=m.getId()%>" 
   class="btn-small success">
✓
</a>

<a href="medicines?action=stop&id=<%=m.getId()%>" 
   class="btn-small danger">
✕
</a>

<% } %>

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