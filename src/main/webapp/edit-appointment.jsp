<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.garbhsakhi.model.Appointment" %>

<%
Appointment a = (Appointment) request.getAttribute("appt");
if(a == null){
    out.println("Appointment missing");
    return;
}
request.setAttribute("pageTitle", "Edit Appointment");
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

    <div class="gs-card">

      <h2 style="margin-bottom:20px;">✏️ Edit Appointment</h2>

      <form method="post" action="update-appointment">

        <input type="hidden" name="id" value="<%=a.getId()%>">

        <label>Title</label>
        <input name="title" value="<%=a.getTitle()%>" required>

        <label>Doctor</label>
        <input name="doctor" value="<%=a.getDoctorName()%>" required>

        <label>Hospital</label>
        <input name="hospital" value="<%=a.getHospitalName()%>">

        <label>Date</label>
        <input type="date" name="date" value="<%=a.getAppointmentDate()%>" required>

        <label>Time</label>
        <input type="time" name="time" value="<%=a.getAppointmentTime()%>" required>

        <label>Notes</label>
        <textarea name="notes"><%=a.getNotes()%></textarea>

        <br><br>

        <button class="btn-primary">Update Appointment</button>
        <a href="appointments" style="margin-left:10px;">Cancel</a>

      </form>

    </div>

  </div>
</div>

</body>
</html>
