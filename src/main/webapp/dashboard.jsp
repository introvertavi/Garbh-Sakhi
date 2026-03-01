<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.util.PregnancyUtil" %>
<%@ page import="com.garbhsakhi.dao.AppointmentDAO" %>
<%@ page import="com.garbhsakhi.model.Appointment" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>

<%
Integer userId = (Integer) session.getAttribute("userId");
if (userId == null) {
    response.sendRedirect("login.jsp");
    return;
}

User user = (User) session.getAttribute("user");

if (user != null && !user.isProfileComplete()) {
    response.sendRedirect("onboarding.jsp");
    return;
}

int pregWeek = 0;
String babyFruit = "";
int pregnancyPercent = 0;
String dailyTip = "";

if (user != null && user.getDueDate() != null && !user.getDueDate().isBlank()) {

    pregWeek = PregnancyUtil.getPregnancyWeek(user.getDueDate());
    babyFruit = PregnancyUtil.getFruitForWeek(pregWeek);
    dailyTip = PregnancyUtil.getDailyHealthTip(pregWeek);

    pregnancyPercent = (int)Math.round((pregWeek / 40.0) * 100);
    if (pregnancyPercent > 100) pregnancyPercent = 100;
}

Appointment todayPreview = null;
Appointment upcomingPreview = null;

try {

    AppointmentDAO.updateMissedAppointments(user.getId());

    List<Appointment> todayList =
            AppointmentDAO.getTodayAppointments(user.getId());

    if (todayList != null && !todayList.isEmpty())
        todayPreview = todayList.get(0);

    List<Appointment> upcomingList =
            AppointmentDAO.getUpcomingAppointments(user.getId());

    if (upcomingList != null && !upcomingList.isEmpty())
        upcomingPreview = upcomingList.get(0);

} catch(Exception e){
    e.printStackTrace();
}

request.setAttribute("pageTitle","Dashboard");
/* ================= DYNAMIC GREETING ================= */

java.time.LocalTime currentTime = java.time.LocalTime.now();
String greetingText;

if(currentTime.isBefore(java.time.LocalTime.NOON)){
    greetingText = "Good Morning ☀️";
}
else if(currentTime.isBefore(java.time.LocalTime.of(17,0))){
    greetingText = "Good Afternoon 🌤";
}
else{
    greetingText = "Good Evening 🌙";
}
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">

</head>

<body>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<div class="main-content">
<div style="max-width:1100px;margin:0 auto;padding:24px;">

<div class="welcome-card">

<div class="welcome-text">

<h2><%= greetingText %>, <%= user.getFullName() %> 👋</h2>

<div class="detail-line">
<span class="detail-label">Due Date:</span>
<span class="detail-value"><%= user.getDueDate() %></span>
</div>

<div class="detail-line">
<span class="detail-label">Pregnancy Week:</span>
<span class="detail-value"><%= pregWeek %> / 40</span>
</div>

<div class="detail-line">
<span class="detail-label">Baby Size:</span>
<span class="detail-value"><%= babyFruit %></span> 🍋
</div>

</div>

<% if (pregWeek > 0) { %>
<div class="pregnancy-ring" style="--percent:<%= pregnancyPercent %>">
<svg width="96" height="96">
<circle cx="48" cy="48" r="42" class="ring-bg"/>
<circle cx="48" cy="48" r="42" class="ring-progress"/>
</svg>

<div class="ring-text">
<%= pregnancyPercent %><span>%</span>
</div>
</div>
<% } %>

</div>

<div style="display:grid;grid-template-columns:repeat(2,1fr);gap:20px;">

<div style="grid-column:1/-1;background:#fff;padding:22px;border-radius:14px;border-left:5px solid #ffd166;">

<b>💡 Daily Health Tip</b>

<p class="text-muted" style="margin-top:10px;">
<%= dailyTip %>
</p>

</div>

<!-- 📅 NEXT APPOINTMENT -->

<div style="background:#fff;padding:20px;border-radius:14px;">

<h4 style="margin-bottom:15px;">📅 Next Appointment</h4>

<%
Appointment preview =
        (todayPreview != null) ? todayPreview : upcomingPreview;

String appointmentLabel = "";

if (preview != null) {
    java.time.LocalDate today = java.time.LocalDate.now();
    java.time.LocalDate apptDate = preview.getAppointmentDate();

    long days = java.time.temporal.ChronoUnit.DAYS.between(today, apptDate);

    if (days == 0) appointmentLabel = "Today";
    else if (days == 1) appointmentLabel = "Tomorrow";
    else if (days > 1) appointmentLabel = "In " + days + " days";
}
%>

<% if (preview != null) { %>

<a href="appointments.jsp" style="text-decoration:none;color:inherit;display:block;">

<div class="appointment-card dashboard-appointment">

<div class="appointment-date">
<%
java.time.LocalDate d = preview.getAppointmentDate();
%>
<span class="day"><%= d.getDayOfMonth() %></span>
<span class="month"><%= d.getMonth().toString().substring(0,3) %></span>
</div>

<div class="appointment-info">

<h5 style="margin:0;"><%= preview.getTitle() %></h5>

<p style="margin:4px 0;">
<%= preview.getDoctorName() %> •
<%= preview.getAppointmentTime() %>
</p>

<!-- ✅ COUNTDOWN (FIXED POSITION) -->
<p id="countdown" class="text-muted" style="margin-top:6px;"></p>

<p class="text-muted" style="margin:0;">
<%= preview.getHospitalName() %>
</p>

<div class="appointment-meta">

<span class="status-badge upcoming">
<%= preview.getStatus() %>
</span>

<% if(!appointmentLabel.isEmpty()) { %>
<span class="appt-label">
<%= appointmentLabel %>
</span>
<% } %>

</div>

</div>
</div>

</a>

<% } else { %>

<span class="text-muted">
No upcoming appointments scheduled.
</span>

<% } %>

</div>

<div style="background:#fff;padding:20px;border-radius:14px;">
💊 Today’s Medicines
</div>

<div style="background:#fff;padding:20px;border-radius:14px;">
🧪 Recent Lab Report
</div>

</div>

</div>
</div>

<!-- ===== COUNTDOWN SCRIPT (UNCHANGED LOGIC) ===== -->
<script>
(function(){

const apptTime = '<%= preview != null ? preview.getAppointmentTime().toString() : "" %>';
if(!apptTime) return;

function updateCountdown(){

    const el = document.getElementById("countdown");
    if(!el) return;

    const now = new Date();
    const today = now.toISOString().split("T")[0];
    const target = new Date(today + "T" + apptTime);

    const diff = target - now;

    if(diff <= 0){
        el.innerText = "⏳ Starting now";
        return;
    }

    const hrs = Math.floor(diff / 3600000);
    const mins = Math.floor((diff % 3600000) / 60000);

    el.innerText = "⏳ Starts in " + hrs + "h " + mins + "m";
}

updateCountdown();
setInterval(updateCountdown,60000);

})();
</script>

</body>
</html>