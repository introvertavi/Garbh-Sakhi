<%@ page import="com.garbhsakhi.model.Appointment" %>

<div class="appointment-item">

<div class="appt-date">
<span class="day"><%= a.getAppointmentDate().getDayOfMonth() %></span>
<span class="month">
<%= a.getAppointmentDate().getMonth().toString().substring(0,3) %>
</span>
</div>

<div class="appt-info">

<strong><%= a.getTitle() %></strong>

<p class="muted">
<%= a.getDoctorName() %> • <%= a.getAppointmentTime() %>
</p>

<p class="muted small"><%= a.getHospitalName() %></p>

<span class="status-badge <%= a.getStatus().toLowerCase() %>">
<%= a.getStatus() %>
</span>

</div>

<div class="appt-actions">

<%
if (!"COMPLETED".equalsIgnoreCase(a.getStatus())
 && !"MISSED".equalsIgnoreCase(a.getStatus())) {
%>
<form method="post" action="complete-appointment" style="display:inline;">
<input type="hidden" name="id" value="<%= a.getId() %>">
<input type="checkbox" onchange="this.form.submit()">
</form>
<%
}
%>

<!-- ✅ EDIT ICON FIX -->
<a href="edit-appointment?id=<%= a.getId() %>" class="btn-icon">
    <i class="bi bi-pencil"></i>
</a>

<!-- ✅ DELETE ICON FIX -->
<form method="post" action="delete-appointment">
<input type="hidden" name="id" value="<%= a.getId() %>">
<button type="submit" class="btn-icon danger">
    <i class="bi bi-trash"></i>
</button>
</form>

</div>

</div>