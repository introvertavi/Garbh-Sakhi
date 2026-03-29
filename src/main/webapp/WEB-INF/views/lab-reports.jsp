<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.garbhsakhi.model.LabReport" %>

<%
request.setAttribute("pageTitle","Lab Reports");
List<LabReport> reports = (List<LabReport>) request.getAttribute("reports");
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">

</head>

<body>

<jsp:include page="/components/header.jsp" />
<jsp:include page="/components/sidebar.jsp" />
<jsp:include page="/components/bottom-nav.jsp" />
<jsp:include page="/components/fab-emergency.jsp" />

<div class="main-content">

<div style="max-width:1100px;margin:0 auto;padding:24px;">

<h2 style="margin-bottom:20px;">📄 Lab Reports</h2>
<%
String errorMessage = (String) request.getAttribute("errorMessage");
if (errorMessage != null) {
%>
    <div class="alert-card danger">
        <span>⚠️</span> <%= errorMessage %>
    </div>
<%
}
%>

<!-- ===== UPLOAD CARD ===== -->
<div class="gs-card card-accent accent-reminder" style="padding:20px; margin-bottom:20px;">

    <h4>⬆️ Upload Report</h4>

    <form action="<%= request.getContextPath() %>/lab-reports" 
          method="post" 
          enctype="multipart/form-data"
          style="margin-top:15px; display:flex; flex-direction:column; gap:10px;">

        <input type="text" name="title" placeholder="Report Title" required class="input-field"/>
        <input type="file" name="file" required class="input-field"/>

        <button type="submit" class="btn-primary">Upload</button>
    </form>

</div>

<!-- ===== REPORT LIST ===== -->
<div class="gs-card card-accent accent-appointment" style="padding:20px;">

    <h4 style="margin-bottom:15px;">📋 Your Reports</h4>

    <%
    if (reports != null && !reports.isEmpty()) {
        for (LabReport r : reports) {

        String file = r.getFilePath() != null ? r.getFilePath() : "";
        boolean isPdf = file.toLowerCase().endsWith(".pdf");
    %>

    <div class="report-card">

        <div class="report-left">
            <div class="report-icon">
                <%= isPdf ? "📄" : "🖼️" %>
            </div>

            <div class="report-text">
                <h5><%= r.getTitle() %></h5>
                <p class="text-muted">
                    Uploaded: <%= r.getUploadDate() %>
                </p>
            </div>
        </div>

        <div class="report-actions">

    <a class="btn-view"
       href="<%= request.getContextPath() %>/view-report?file=<%= r.getFilePath() %>"
       target="_blank">
       View
    </a>

    <a class="btn-download"
       href="<%= request.getContextPath() %>/view-report?file=<%= r.getFilePath() %>"
       download>
       Download
    </a>

    <button type="button" class="btn-delete"onclick="openDeleteModal(<%= r.getId() %>)">
        Delete
    </button>

</div>

    </div>

    <%
        }
    } else {
    %>
        <p class="text-muted">No reports uploaded yet.</p>
    <%
    }
    %>

</div>

</div>
</div>

<!-- DELETE FORM -->
<form id="deleteForm" method="post" action="<%=request.getContextPath()%>/delete-report">
    <input type="hidden" name="reportId" id="deleteReportId">
</form>

<!-- MODAL -->
<div id="deleteModal" class="modal-overlay">
    <div class="modal-card">

        <div class="modal-icon">🗑️</div>

        <h3>Delete Lab Report?</h3>

        <p>This action cannot be undone.  
        The report will be permanently removed.</p>

        <div class="modal-actions">
            <button class="btn cancel-btn" onclick="closeModal()">Cancel</button>
            <button class="btn delete-btn" onclick="confirmDelete()">Delete</button>
        </div>

    </div>
</div>

<script src="assets/js/main.js"></script>

<script>
let selectedReportId = null;

function openDeleteModal(id) {
    selectedReportId = id;
    document.getElementById("deleteModal").style.display = "flex";
}

function closeModal() {
    document.getElementById("deleteModal").style.display = "none";
}

function confirmDelete() {
    document.getElementById("deleteReportId").value = selectedReportId;
    document.getElementById("deleteForm").submit();
}

window.onclick = function(e) {
    const modal = document.getElementById("deleteModal");
    if (e.target === modal) {
        closeModal();
    }
}
</script>

</body>
</html>