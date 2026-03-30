<%@ page import="com.garbhsakhi.model.Appointment" %>

<%
    Appointment appt = (Appointment) request.getAttribute("appointment");
%>

<div class="appointment-item">

    <!-- DATE -->
    <div class="appt-date">
        <span class="day">
            <%= appt.getAppointmentDate() != null
                    ? appt.getAppointmentDate().getDayOfMonth()
                    : "" %>
        </span>
        <span class="month">
            <%= appt.getAppointmentDate() != null
                    ? appt.getAppointmentDate().getMonth()
                        .toString().substring(0,3).toUpperCase()
                    : "" %>
        </span>
    </div>

    <!-- INFO -->
    <div class="appt-info">
        <strong><%= appt.getTitle() %></strong>

        <div class="info-line">
            <i class="bi bi-person"></i>
            <span><%= appt.getDoctorName() %></span>
        </div>

        <div class="info-line">
            <i class="bi bi-geo-alt"></i>
            <span><%= appt.getHospitalName() %></span>
        </div>
    </div>

    <!-- TIME & ACTIONS -->
    <div class="appt-actions">
        <div class="time-and-status">
            <span class="time"><i class="bi bi-clock"></i> <%= appt.getAppointmentTime() %></span>
            <span class="status-badge <%= appt.getStatus().toLowerCase() %>">
                <%= appt.getStatus() %>
            </span>
        </div>

        <div class="action-buttons">
            <% if (!"COMPLETED".equalsIgnoreCase(appt.getStatus()) && !"MISSED".equalsIgnoreCase(appt.getStatus())) { %>
                <form method="post" action="complete-appointment" class="complete-form" style="display:inline-block;">
                    <input type="hidden" name="id" value="<%= appt.getId() %>">
                    <label class="complete-checkbox" title="Mark as completed">
                        <input type="checkbox" onchange="markCompleted(this)">
                        <span class="checkmark"></span>
                    </label>
                </form>

                <a href="edit-appointment?id=<%= appt.getId() %>" class="btn-icon" title="Edit">
                    <i class="bi bi-pencil"></i>
                </a>
            <% } %>

            <form method="post" action="delete-appointment" style="display:inline-block;">
                <input type="hidden" name="id" value="<%= appt.getId() %>">
                <button type="submit" class="btn-icon danger" title="Delete">
                    <i class="bi bi-trash"></i>
                </button>
            </form>
        </div>
    </div>
</div>