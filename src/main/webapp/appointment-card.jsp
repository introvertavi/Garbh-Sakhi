<%@ page import="com.garbhsakhi.model.Appointment" %>

<%
    Appointment appt = a;   // local reference (cleaner + safer)
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
                        .toString().substring(0,3)
                    : "" %>
        </span>
    </div>

    <!-- INFO -->
    <div class="appt-info">

        <strong><%= appt.getTitle() %></strong>

        <p class="muted">
            <%= appt.getDoctorName() %> &bull; <%= appt.getAppointmentTime() %>
        </p>

        <p class="muted small">
            <%= appt.getHospitalName() %>
        </p>

        <span class="status-badge <%= appt.getStatus().toLowerCase() %>">
            <%= appt.getStatus() %>
        </span>

    </div>

    <!-- ACTIONS -->
    <div class="appt-actions">

        <%
        if (!"COMPLETED".equalsIgnoreCase(appt.getStatus())
            && !"MISSED".equalsIgnoreCase(appt.getStatus())) {
        %>

        <form method="post" action="complete-appointment" style="display:inline;">
            <input type="hidden" name="id" value="<%= appt.getId() %>">
            <input type="checkbox" onchange="this.form.submit()">
        </form>

        <%
        }
        %>

        <!-- EDIT -->
        <a href="edit-appointment?id=<%= appt.getId() %>" class="btn-icon">
            <i class="bi bi-pencil"></i>
        </a>

        <!-- DELETE -->
        <form method="post" action="delete-appointment" style="display:inline;">
            <input type="hidden" name="id" value="<%= appt.getId() %>">
            <button type="submit" class="btn-icon danger">
                <i class="bi bi-trash"></i>
            </button>
        </form>

    </div>

</div>