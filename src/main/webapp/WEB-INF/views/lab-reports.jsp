<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.garbhsakhi.model.LabReport" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
request.setAttribute("pageTitle","Lab Reports");
List<LabReport> reports = (List<LabReport>) request.getAttribute("reports");
// Define a formatter for the date
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd MMMM, yyyy");
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">
</head>

<body>

<jsp:include page="/components/header.jsp" />
<jsp:include page="/components/sidebar.jsp" />
<jsp:include page="/components/bottom-nav.jsp" />
<jsp:include page="/components/fab-emergency.jsp" />

<div class="main-content">

<div class="content-wrapper">

<!-- MODIFIED: Added a page header -->
<div class="page-header">
    <h2>📄 Lab Reports</h2>
</div>

<%
String errorMessage = (String) request.getAttribute("errorMessage");
if (errorMessage != null) {
%>
    <div class="alert-card danger">
        <span><i class="bi bi-exclamation-triangle-fill"></i></span> <%= errorMessage %>
    </div>
<%
}
%>

<!-- ===== UPLOAD CARD ===== -->
<div class="gs-card lab-upload-card">
    <h4><i class="bi bi-cloud-arrow-up-fill"></i> Upload New Report</h4>
    <form action="<%= request.getContextPath() %>/lab-reports"
          method="post"
          enctype="multipart/form-data"
          class="upload-form">

        <input type="text" name="title" placeholder="e.g., Blood Test Q3" required class="input-field"/>
        <input type="file" name="file" required class="input-field file-input"/>

        <button type="submit" class="btn-primary">Upload</button>
    </form>
</div>

<!-- ===== REPORT LIST ===== -->
<div class="gs-card report-list-card">
    <h4><i class="bi bi-collection-fill"></i> Your Reports</h4>
    <div class="report-list">
    <%
    if (reports != null && !reports.isEmpty()) {
        for (LabReport r : reports) {
            String file = r.getFilePath() != null ? r.getFilePath() : "";
            boolean isPdf = file.toLowerCase().endsWith(".pdf");
    %>
    <!-- MODIFIED: Report item structure changed -->
    <div class="report-item">
        <div class="report-icon">
            <i class="bi <%= isPdf ? "bi-file-earmark-pdf" : "bi-image" %>"></i>
        </div>
        <div class="report-details">
            <h5 class="report-title"><%= r.getTitle() %></h5>
            <p class="report-date">
                <%-- THIS IS THE FIXED LINE --%>
                Uploaded: <%= r.getUploadDate() != null ? dtf.format(r.getUploadDate().toLocalDateTime()) : "N/A" %>
            </p>
        </div>
        <div class="report-actions">
            <a class="btn-icon-text view" href="<%= request.getContextPath() %>/view-report?file=<%= r.getFilePath() %>" target="_blank">
                <i class="bi bi-eye"></i> View
            </a>
            <a class="btn-icon-text download" href="<%= request.getContextPath() %>/view-report?file=<%= r.getFilePath() %>" download>
                <i class="bi bi-download"></i> Download
            </a>
            <button type="button" class="btn-icon-text danger" onclick="openDeleteModal(<%= r.getId() %>)">
                <i class="bi bi-trash"></i> Delete
            </button>
        </div>
    </div>
    <%
        }
    } else {
    %>
        <p class="text-muted" style="text-align:center; padding: 20px;">No reports uploaded yet.</p>
    <%
    }
    %>
    </div>
</div>

</div>
</div>

<!-- MODAL & DELETE FORM -->
<div id="deleteModal" class="modal-overlay">
    <!-- MODIFIED: Modal structure updated -->
    <div class="modal-content">
        <div class="modal-icon-wrapper">
            <i class="bi bi-trash"></i>
        </div>
        <h3>Delete Lab Report?</h3>
        <p>This action cannot be undone. The report file will be permanently removed from the system.</p>
        <div class="modal-actions">
            <button class="btn btn-secondary" onclick="closeModal()">Cancel</button>
            <button class="btn btn-danger" onclick="confirmDelete()">Delete</button>
        </div>
    </div>
</div>

<form id="deleteForm" method="post" action="<%=request.getContextPath()%>/delete-report">
    <input type="hidden" name="reportId" id="deleteReportId">
</form>

<script>
let selectedReportId = null;
const modal = document.getElementById("deleteModal");

function openDeleteModal(id) {
    selectedReportId = id;
    modal.classList.add("visible");
}

function closeModal() {
    modal.classList.remove("visible");
}

function confirmDelete() {
    document.getElementById("deleteReportId").value = selectedReportId;
    document.getElementById("deleteForm").submit();
}

window.onclick = function(e) {
    if (e.target === modal) {
        closeModal();
    }
}
</script>

</body>
</html>