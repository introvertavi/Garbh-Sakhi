<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.util.PregnancyUtil" %>
<%@ page import="com.garbhsakhi.dao.AppointmentDAO" %>
<%@ page import="com.garbhsakhi.model.Appointment" %>
<%@ page import="com.garbhsakhi.dao.LabReportDAO" %>
<%@ page import="com.garbhsakhi.dao.DatabaseConnection" %>
<%@ page import="com.garbhsakhi.model.LabReport" %>
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

/* ================= TODAY MEDICINES ================= */

List<com.garbhsakhi.model.Medicine> todayMedicines =
        new com.garbhsakhi.dao.MedicineDAO()
                .getTodayMedicines(user.getId());

/* ================= MEDICINE GROUPING ================= */

List<com.garbhsakhi.model.Medicine> morningMeds = new java.util.ArrayList<>();
List<com.garbhsakhi.model.Medicine> afternoonMeds = new java.util.ArrayList<>();
List<com.garbhsakhi.model.Medicine> nightMeds = new java.util.ArrayList<>();

for(com.garbhsakhi.model.Medicine m : todayMedicines){

    if(m.getTimeOfDay() == null) continue;

    String t = m.getTimeOfDay().toLowerCase();

    if(t.contains("morning")){
        morningMeds.add(m);
    }
    else if(t.contains("afternoon")){
        afternoonMeds.add(m);
    }
    else if(t.contains("night")){
        nightMeds.add(m);
    }
    else if(t.contains("3")){
        morningMeds.add(m);
        afternoonMeds.add(m);
        nightMeds.add(m);
    }
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

<h2 style="margin-bottom:16px;">📅 Appointments</h2>
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

<h4 class="appointment-title">
<i class="bi bi-calendar-heart"></i> Next Appointment
</h4>

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

<div class="gs-card card-accent accent-medicine" style="padding:20px;">

<h4 class="medicine-title">💊 Today's Medicines</h4>

<%
int totalMeds = morningMeds.size() + afternoonMeds.size() + nightMeds.size();

int takenCount = 0;

for(com.garbhsakhi.model.Medicine m : morningMeds)
    if(m.isTakenMorning()) takenCount++;

for(com.garbhsakhi.model.Medicine m : afternoonMeds)
    if(m.isTakenAfternoon()) takenCount++;

for(com.garbhsakhi.model.Medicine m : nightMeds)
    if(m.isTakenNight()) takenCount++;

int progress = totalMeds == 0 ? 0 : (takenCount * 100 / totalMeds);
int missedMeds = totalMeds - takenCount;

com.garbhsakhi.model.Medicine nextMedicine = null;
String nextTime = "";

for(com.garbhsakhi.model.Medicine m : morningMeds){
    if(!m.isTakenMorning()){
        nextMedicine = m;
        nextTime = "Morning";
        break;
    }
}

if(nextMedicine == null){
    for(com.garbhsakhi.model.Medicine m : afternoonMeds){
        if(!m.isTakenAfternoon()){
            nextMedicine = m;
            nextTime = "Afternoon";
            break;
        }
    }
}

if(nextMedicine == null){
    for(com.garbhsakhi.model.Medicine m : nightMeds){
        if(!m.isTakenNight()){
            nextMedicine = m;
            nextTime = "Night";
            break;
        }
    }
}
%>

<div class="medicine-progress">

<div class="progress-text">
<%= takenCount %> / <%= totalMeds %> taken
</div>

<div class="progress-bar">
<div class="progress-fill <%= progress == 100 ? "progress-complete" : "" %>"
     style="width:<%= progress %>%"></div>
</div>

</div>
<%
if(todayMedicines == null || todayMedicines.isEmpty()){
%>

<p class="text-muted">No medicines scheduled for today.</p>

<%
} else {
%>
<% if(missedMeds > 0) { %>

<div class="medicine-alert">
⚠️ You missed <b><%= missedMeds %></b> medicine<%= missedMeds > 1 ? "s" : "" %> today
</div>

<% } %>
<!-- MORNING -->
<% if(!morningMeds.isEmpty()){ %>

<b style="display:block;margin-top:10px;">🌅 Morning</b>

<% for(com.garbhsakhi.model.Medicine m : morningMeds){ %>

<div class="mini-med-card">

<div class="med-info">
<span class="med-name"><%= m.getMedicineName() %></span>

<span class="med-dose text-muted">
<%= m.getDosage()==null?"":m.getDosage() %>
</span>
</div>

<div class="med-action">

<% if(!m.isTakenMorning()) { %>

<form action="<%=request.getContextPath()%>/medicine/taken" method="post">
<input type="hidden" name="id" value="<%= m.getId() %>">
<input type="hidden" name="time" value="morning">

<button class="btn-taken">Mark Taken</button>
</form>

<% } else { %>

<span class="badge-taken">✓ Taken</span>

<% } %>

</div>
</div>

<% } } %>
<div class="medicine-group-divider"></div>

<!-- AFTERNOON -->
<% if(!afternoonMeds.isEmpty()){ %>

<b style="display:block;margin-top:14px;">☀️ Afternoon</b>

<% for(com.garbhsakhi.model.Medicine m : afternoonMeds){ %>

<div class="mini-med-card">

<div class="med-info">
<span class="med-name"><%= m.getMedicineName() %></span>

<span class="med-dose text-muted">
<%= m.getDosage()==null?"":m.getDosage() %>
</span>
</div>

<div class="med-action">

<% if(!m.isTakenAfternoon()) { %>

<form action="<%=request.getContextPath()%>/medicine/taken" method="post">
<input type="hidden" name="id" value="<%= m.getId() %>">
<input type="hidden" name="time" value="afternoon">

<button class="btn-taken">Mark Taken</button>
</form>

<% } else { %>

<span class="badge-taken">✓ Taken</span>

<% } %>

</div>
</div>

<% } } %>
<div class="medicine-group-divider"></div>

<!-- NIGHT -->
<% if(!nightMeds.isEmpty()){ %>

<b style="display:block;margin-top:14px;">🌙 Night</b>

<% for(com.garbhsakhi.model.Medicine m : nightMeds){ %>

<div class="mini-med-card">

<div class="med-info">
<span class="med-name"><%= m.getMedicineName() %></span>

<span class="med-dose text-muted">
<%= m.getDosage()==null?"":m.getDosage() %>
</span>
</div>

<div class="med-action">

<% if(!m.isTakenNight()) { %>

<form action="<%=request.getContextPath()%>/medicine/taken" method="post">
<input type="hidden" name="id" value="<%= m.getId() %>">
<input type="hidden" name="time" value="night">

<button class="btn-taken">Mark Taken</button>
</form>

<% } else { %>

<span class="badge-taken">✓ Taken</span>

<% } %>

</div>
</div>

<% } } %>

<%
}
%>

</div>
<div class="gs-card card-accent accent-reminder" style="padding:20px;">

<h4>⏰ Next Medicine</h4>

<% if(nextMedicine != null){ %>

<div class="medicine-reminder">

<b><%= nextMedicine.getMedicineName() %></b>

<p class="text-muted">
<%= nextTime %> • <%= nextMedicine.getDosage()==null?"":nextMedicine.getDosage() %>
</p>

</div>

<% } else { %>

<p class="text-success">🎉 All medicines taken for today!</p>

<% } %>

</div>
<div class="gs-card card-accent accent-reports left-line" style="padding:20px;">

<h4>📄 Recent Lab Reports</h4>

<%
List<LabReport> reports = new java.util.ArrayList<>();

if (user != null) {
    try {
        java.sql.Connection conn = DatabaseConnection.getConnection();
        LabReportDAO dao = new LabReportDAO(conn);

        reports = dao.getReportsByUser(user.getId());

        if (reports != null && reports.size() > 3) {
            reports = reports.subList(0, 3);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>

<% if (reports != null && !reports.isEmpty()) { %>

    <% for (LabReport r : reports) {
        String file = r.getFilePath() != null ? r.getFilePath() : "";
        boolean isPdf = file.toLowerCase().endsWith(".pdf");
    %>

    <div class="report-card">

        <div class="report-header">
            <div>
                <h5 class="report-title"><%= r.getTitle() %></h5>
                <p class="report-date">Uploaded: <%= r.getUploadDate() %></p>
            </div>

            <span class="file-badge <%= isPdf ? "pdf" : "image" %>">
                <%= isPdf ? "PDF" : "Image" %>
            </span>
        </div>

        <div class="report-actions">

            <a href="<%= request.getContextPath() %>/view-report?file=<%= file %>"
               class="btn-view"
               target="_blank">
                View
            </a>

            <!-- FIX: added space before onclick -->
            <button class="btn-delete" onclick="openDeleteModal(<%= r.getId() %>)">
                Delete
            </button>

        </div>

    </div>

    <% } %>   <!-- ✅ CLOSE FOR LOOP -->

<% } else { %>

    <p class="text-muted">No lab reports uploaded yet</p>

<% } %>   <!-- ✅ CLOSE IF -->

</div>

</div>
</div>

<!-- COUNTDOWN -->
<script>
(function(){

const apptTime = '<%= preview != null ? preview.getAppointmentTime().toString() : "" %>';
const apptDate = '<%= preview != null ? preview.getAppointmentDate().toString() : "" %>';

if(!apptTime || !apptDate) return;

function updateCountdown(){

    const el = document.getElementById("countdown");
    if(!el) return;

    const now = new Date();

    const target = new Date(apptDate + "T" + apptTime);

    const diff = target - now;

    if(diff <= 0){
        el.innerText = "⏳ Starting now";
        return;
    }

    const days = Math.floor(diff / (1000*60*60*24));
    const hrs = Math.floor((diff % (1000*60*60*24)) / (1000*60*60));
    const mins = Math.floor((diff % (1000*60*60)) / 60000);

    if(days > 0)
        el.innerText = "⏳ Starts in " + days + "d " + hrs + "h";
    else
        el.innerText = "⏳ Starts in " + hrs + "h " + mins + "m";
}

updateCountdown();
setInterval(updateCountdown,60000);

})();
</script>

<script>
let selectedReportId = null;

function openDeleteModal(id) {
    selectedReportId = id;
    document.getElementById("deleteModal").style.display = "flex";
}

function closeModal() {
    document.getElementById("deleteModal").style.display = "none";
}

function closeDeleteModal() {
    document.getElementById("deleteModal").style.display = "none";
}

function confirmDelete() {
    document.getElementById("deleteReportId").value = selectedReportId;
    document.getElementById("deleteForm").submit();
}

window.onclick = function(e) {
    const modal = document.getElementById("deleteModal");
    if (e.target === modal) {
        closeDeleteModal();
    }
}
</script>

<form id="deleteForm" method="post" action="<%=request.getContextPath()%>/delete-report">
    <input type="hidden" name="reportId" id="deleteReportId">
</form>

<!-- DELETE MODAL -->
<div id="deleteModal" class="modal-overlay">
    <div class="modal-box">
        <h3>Delete Report</h3>
        <p>Are you sure you want to delete this report?</p>

        <div class="modal-actions">
            <!-- FIX: added type="button" to both buttons -->
            <button type="button" onclick="closeDeleteModal()" class="btn-cancel">Cancel</button>
            <button type="button" class="btn delete-btn" onclick="confirmDelete()">Delete</button>
        </div>
    </div>
</div>

</body>
</html>
