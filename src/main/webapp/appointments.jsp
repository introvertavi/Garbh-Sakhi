<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.garbhsakhi.model.Appointment" %>
<%@ page session="true" %>

<%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendRedirect("login.jsp");
    return;
}

/* ✅ Always ensure servlet loads data */
if (request.getAttribute("todayAppointments") == null) {
    response.sendRedirect("appointments");
    return;
}

request.setAttribute("pageTitle", "Appointments");
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">

<!-- ✅ ICON FIX (NEW) -->
<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>

<body>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<div class="main-content">
<div style="max-width:1100px;margin:0 auto;padding:24px;">

<div class="gs-card">

<div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
<h2>📅 Appointments</h2>
<a href="add-appointments.jsp" class="btn-primary">+ Add Appointment</a>
</div>

<div class="appt-layout">

<!-- CALENDAR -->
<div class="calendar-mini gs-card">
<h3 class="calendar-title">Select Date</h3>
<div class="calendar-box">
<input type="text" id="appointmentCalendar" class="calendar-input">
</div>
</div>

<!-- APPOINTMENTS -->
<div class="appt-list gs-card">

<%
List<Appointment> today =
(List<Appointment>) request.getAttribute("todayAppointments");

List<Appointment> upcoming =
(List<Appointment>) request.getAttribute("upcomingAppointments");

List<Appointment> missed =
(List<Appointment>) request.getAttribute("missedAppointments");
%>

<!-- ================= TODAY ================= -->
<h3 style="margin-bottom:12px;">Today's Appointments</h3>

<%
if (today == null || today.isEmpty()) {
%>
<p class="muted">No appointments today.</p>
<%
} else {
for (Appointment a : today) {
%>

<%@ include file="appointment-card.jsp" %>

<%
}}
%>

<!-- ================= UPCOMING ================= -->
<h3 style="margin:20px 0 12px;">Upcoming Appointments</h3>

<%
if (upcoming == null || upcoming.isEmpty()) {
%>
<p class="muted">No upcoming appointments.</p>
<%
} else {
for (Appointment a : upcoming) {
%>

<%@ include file="appointment-card.jsp" %>

<%
}}
%>

<!-- ================= MISSED ================= -->
<h3 style="margin:20px 0 12px;color:#e5484d;">Missed Appointments</h3>

<%
if (missed == null || missed.isEmpty()) {
%>
<p class="muted">No missed appointments.</p>
<%
} else {
for (Appointment a : missed) {
%>

<%@ include file="appointment-card.jsp" %>

<%
}}
%>

</div>
</div>
</div>
</div>
</div>

<script>
flatpickr("#appointmentCalendar", {
inline:true,
defaultDate:"today",
dateFormat:"d-m-Y"
});
</script>

</body>
</html>