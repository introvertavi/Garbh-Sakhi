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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
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

<!-- APPOINTMENTS LIST -->
<div class="appt-list gs-card">

<%
List<Appointment> today    = (List<Appointment>) request.getAttribute("todayAppointments");
List<Appointment> upcoming = (List<Appointment>) request.getAttribute("upcomingAppointments");
List<Appointment> missed   = (List<Appointment>) request.getAttribute("missedAppointments");
List<Appointment> completed = (List<Appointment>) request.getAttribute("completedAppointments");
%>

<h3 style="margin-bottom:12px;">Today's Appointments</h3>
<% if (today == null || today.isEmpty()) { %>
  <p class="muted">No appointments today.</p>
<% } else { for (Appointment a : today) {
    request.setAttribute("appointment", a);
%>
  <jsp:include page="appointment-card.jsp" />
<% }} %>

<h3 class="section-title">Upcoming Appointments</h3>
<% if (upcoming == null || upcoming.isEmpty()) { %>
  <p class="muted">No upcoming appointments.</p>
<% } else { for (Appointment a : upcoming) {
    request.setAttribute("appointment", a);
%>
  <jsp:include page="appointment-card.jsp" />
<% }} %>

<h3 class="section-title missed-title">Missed Appointments</h3>
<% if (missed == null || missed.isEmpty()) { %>
  <p class="muted">No missed appointments.</p>
<% } else { for (Appointment a : missed) {
    request.setAttribute("appointment", a);
%>
  <jsp:include page="appointment-card.jsp" />
<% }} %>

<h3 class="section-title">Completed Appointments</h3>
<% if (completed == null || completed.isEmpty()) { %>
  <p class="muted">No completed appointments.</p>
<% } else { for (Appointment a : completed) {
    request.setAttribute("appointment", a);
%>
  <jsp:include page="appointment-card.jsp" />
<% }} %>

</div><!-- /appt-list -->
</div><!-- /appt-layout -->
</div><!-- /gs-card -->
</div>
</div>

<script>
// ── Flatpickr (init ONCE) ──
flatpickr("#appointmentCalendar", {
  inline: true,
  defaultDate: "today",
  dateFormat: "d-m-Y"
});

// ── Completion animation ──
function markCompleted(checkbox) {
  const card = checkbox.closest(".appointment-item");
  if (card) {
      card.classList.add("completing");
  }
  setTimeout(() => {
      checkbox.closest("form").submit();
  }, 600);
}

// ── Auto-refresh every 60 s ──
setInterval(() => {
  fetch("appointments?refresh=true").then(() => location.reload());
}, 60000);
</script>

</body>
</html>
