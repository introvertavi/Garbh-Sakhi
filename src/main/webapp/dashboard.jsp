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

/* ================= PREGNANCY DATA ================= */

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

/* ================= APPOINTMENTS ================= */

Appointment todayPreview = null;
Appointment upcomingPreview = null;

try {

    AppointmentDAO.updateMissedAppointments(user.getId());

    List<Appointment> todayList =
            AppointmentDAO.getTodayAppointments(user.getId());

    if (!todayList.isEmpty())
        todayPreview = todayList.get(0);

    List<Appointment> upcomingList =
            AppointmentDAO.getUpcomingAppointments(user.getId());

    if (!upcomingList.isEmpty())
        upcomingPreview = upcomingList.get(0);

} catch(Exception e){
    e.printStackTrace();
}

/* ================= GREETING ================= */

java.time.LocalTime currentTime = java.time.LocalTime.now();
String greetingText;

if(currentTime.isBefore(java.time.LocalTime.NOON))
    greetingText = "Good Morning ☀️";
else if(currentTime.isBefore(java.time.LocalTime.of(17,0)))
    greetingText = "Good Afternoon 🌤";
else
    greetingText = "Good Evening 🌙";

/* ================= STATS ================= */

int upcomingCount =
        AppointmentDAO.getAppointmentCount(user.getId(),"UPCOMING");

int completedCount =
        AppointmentDAO.getAppointmentCount(user.getId(),"COMPLETED");

int missedCount =
        AppointmentDAO.getAppointmentCount(user.getId(),"MISSED");

request.setAttribute("pageTitle","Dashboard");
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

<!-- ================= WELCOME ================= -->

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

<!-- ================= GRID ================= -->

<div class="dashboard-grid"
     style="display:grid;grid-template-columns:repeat(2,1fr);gap:20px;">

<!-- 📊 STATS -->
<div class="gs-card card-accent accent-stats dashboard-stats"
     style="grid-column:1/-1;padding:22px;">

<div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;">

<div class="gs-card" style="text-align:center;">
<h4>📅 Upcoming</h4>
<h2><%= upcomingCount %></h2>
</div>

<div class="gs-card" style="text-align:center;">
<h4>✅ Completed</h4>
<h2><%= completedCount %></h2>
</div>

<div class="gs-card" style="text-align:center;">
<h4>⚠️ Missed</h4>
<h2><%= missedCount %></h2>
</div>

</div>
</div>

<!-- 💡 DAILY TIP -->
<div class="gs-card card-accent accent-tip daily-tip-card"
     style="grid-column:1/-1;padding:22px;">

<b>💡 Daily Health Tip</b>

<p class="text-muted" style="margin-top:10px;">
<%= dailyTip %>
</p>

</div>

<!-- 📅 NEXT APPOINTMENT -->
<div class="gs-card card-accent accent-appointment"
     style="padding:20px;">

<h4 style="margin-bottom:15px;">📅 Next Appointment</h4>

<%
Appointment preview =
        (todayPreview != null) ? todayPreview : upcomingPreview;

String appointmentLabel = "";

if (preview != null) {
    java.time.LocalDate today = java.time.LocalDate.now();
    long days = java.time.temporal.ChronoUnit.DAYS
            .between(today, preview.getAppointmentDate());

    if (days == 0) appointmentLabel = "Today";
    else if (days == 1) appointmentLabel = "Tomorrow";
    else if (days > 1) appointmentLabel = "In " + days + " days";
}
%>

<% if (preview != null) { %>

<div class="appointment-card dashboard-appointment">

<div class="appointment-info">

<h5><%= preview.getTitle() %></h5>

<p>
<%= preview.getDoctorName() %> •
<%= preview.getAppointmentTime() %>
</p>

<p id="countdown" class="text-muted"></p>

<p class="text-muted">
<%= preview.getHospitalName() %>
</p>

<span class="status-badge upcoming">
<%= preview.getStatus() %>
</span>

</div>
</div>

<% } else { %>
<span class="text-muted">No upcoming appointments scheduled.</span>
<% } %>

</div>

<div class="gs-card" style="padding:20px;">
💊 Today’s Medicines
</div>

<div class="gs-card" style="padding:20px;">
🧪 Recent Lab Report
</div>

</div>
</div>
</div>

<!-- COUNTDOWN -->
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