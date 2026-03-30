<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.garbhsakhi.model.Medicine" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.dao.MedicineDAO" %>

<%
request.setAttribute("pageTitle","Medicines");
List<Medicine> medicines = (List<Medicine>) request.getAttribute("medicines");

// Fallback logic to ensure medicines are loaded if not passed via servlet
if (medicines == null) {
    User user = (User) session.getAttribute("user");
    if (user != null) {
        medicines = new MedicineDAO().getMedicinesByUser(user.getId());
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/modern-style.css">
</head>
<body>

<!-- GLOBAL LAYOUT -->
<jsp:include page="components/header.jsp"/>
<jsp:include page="components/sidebar.jsp"/>
<jsp:include page="components/bottom-nav.jsp"/>
<jsp:include page="components/fab-emergency.jsp"/>

<div class="main-content">
<div class="content-wrapper">

<!-- ================= PAGE HEADER ================= -->
<div class="page-header">
    <h2><i class="bi bi-capsule-pill"></i> Medicines</h2>
    <p class="text-muted">Track your daily supplements and prescriptions.</p>
</div>

<!-- ================= ADD MEDICINE FORM ================= -->
<div class="gs-card add-medicine-card">
    <h4><i class="bi bi-plus-circle-dotted"></i> Add a New Medicine</h4>
    <form method="post" action="medicines">
        <div class="row-2">
            <div class="field">
                <label>Medicine Name</label>
                <input type="text" name="medicineName" placeholder="e.g., Iron Tablet" required class="input-field">
            </div>
            <div class="field">
                <label>Dosage</label>
                <input type="text" name="dosage" placeholder="e.g., 1 tablet" class="input-field">
            </div>
        </div>
        <div class="row-2">
            <div class="field">
                <label>Frequency</label>
                <select name="frequency" class="input-field">
                    <option>Daily</option>
                    <option>Weekly</option>
                    <option>As Needed</option>
                </select>
            </div>
            <div class="field">
                <label>Time of Day</label>
                <select name="timeOfDay" class="input-field">
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
                <input type="date" name="startDate" class="input-field">
            </div>
            <div class="field">
                <label>End Date</label>
                <input type="date" name="endDate" class="input-field">
            </div>
        </div>
        <div class="field">
            <label>Notes (Optional)</label>
            <textarea name="notes" rows="3" placeholder="e.g., Take with food" class="input-field"></textarea>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn-primary">
                <i class="bi bi-plus-lg"></i> Add Medicine
            </button>
        </div>
    </form>
</div>

<!-- ================= MEDICINE LIST ================= -->
<div class="medicine-list-container">
    <h4 class="section-title">Your Active Prescriptions</h4>
    <% if (medicines == null || medicines.isEmpty()) { %>
        <p class="text-muted">You haven't added any medicines yet.</p>
    <% } else { for (Medicine m : medicines) {
        String status = m.getComputedStatus();
        String timeOfDay = m.getTimeOfDay();
    %>

    <!-- ENTIRELY NEW MEDICINE CARD STRUCTURE -->
    <div class="medicine-item gs-card status-<%= status.toLowerCase() %>">
        <div class="med-header">
            <h5 class="med-name"><%= m.getMedicineName() %></h5>
            <span class="status-badge <%= status.toLowerCase() %>">
                <i class="bi <%= "ACTIVE".equalsIgnoreCase(status) ? "bi-arrow-repeat" : ("COMPLETED".equalsIgnoreCase(status) ? "bi-check2-circle" : "bi-slash-circle") %>"></i>
                <%= status %>
            </span>
        </div>

        <div class="med-details">
            <div class="detail-item"><i class="bi bi-clipboard2-plus"></i><span><%= m.getDosage() %></span></div>
            <div class="detail-item"><i class="bi bi-clock-history"></i><span><%= m.getFrequency() %></span></div>
            <div class="detail-item"><i class="bi bi-calendar-range"></i><span><%= m.getStartDate() %> to <%= m.getEndDate() %></span></div>
        </div>

        <!-- NEW INTERACTIVE DOSE TRACKER -->
        <div class="dose-tracker">
        <%
            int total = 0, done = 0;
            if ("Morning".equalsIgnoreCase(timeOfDay) || "3 Times".equalsIgnoreCase(timeOfDay)) total++;
            if (m.isTakenMorning()) done++;
            if ("Afternoon".equalsIgnoreCase(timeOfDay) || "3 Times".equalsIgnoreCase(timeOfDay)) total++;
            if (m.isTakenAfternoon()) done++;
            if ("Night".equalsIgnoreCase(timeOfDay) || "3 Times".equalsIgnoreCase(timeOfDay)) total++;
            if (m.isTakenNight()) done++;
            int percent = (total == 0) ? 0 : (done * 100 / total);
        %>
            <div class="progress-info">
                <span>Today's Progress</span>
                <span><%= done %>/<%= total %> Taken</span>
            </div>
            <div class="progress-bar"><div class="progress-fill" style="width: <%= percent %>%"></div></div>

            <div class="dose-buttons">
                <% if ("Morning".equalsIgnoreCase(timeOfDay) || "3 Times".equalsIgnoreCase(timeOfDay)) { %>
                    <a href="medicines?action=take&id=<%=m.getId()%>&time=morning" class="dose-button <%= m.isTakenMorning() ? "taken" : "" %>">
                        <i class="bi bi-sunrise"></i> Morning
                    </a>
                <% } %>
                <% if ("Afternoon".equalsIgnoreCase(timeOfDay) || "3 Times".equalsIgnoreCase(timeOfDay)) { %>
                     <a href="medicines?action=take&id=<%=m.getId()%>&time=afternoon" class="dose-button <%= m.isTakenAfternoon() ? "taken" : "" %>">
                        <i class="bi bi-sun"></i> Afternoon
                    </a>
                <% } %>
                <% if ("Night".equalsIgnoreCase(timeOfDay) || "3 Times".equalsIgnoreCase(timeOfDay)) { %>
                    <a href="medicines?action=take&id=<%=m.getId()%>&time=night" class="dose-button <%= m.isTakenNight() ? "taken" : "" %>">
                        <i class="bi bi-moon-stars"></i> Night
                    </a>
                <% } %>
            </div>
        </div>

        <div class="med-actions">
            <a href="edit-medicine?id=<%=m.getId()%>" class="btn-icon-text"><i class="bi bi-pencil"></i> Edit</a>
            <a href="delete-medicine?id=<%=m.getId()%>" onclick="return confirm('Are you sure you want to delete this medicine?');" class="btn-icon-text danger"><i class="bi bi-trash"></i> Delete</a>
            <% if ("ACTIVE".equalsIgnoreCase(status)) { %>
                <a href="medicines?action=stop&id=<%=m.getId()%>" class="btn-icon-text danger"><i class="bi bi-slash-circle"></i> Stop</a>
            <% } %>
        </div>
    </div>
    <% }} %>
</div>

</div>
</div>

</body>
</html>