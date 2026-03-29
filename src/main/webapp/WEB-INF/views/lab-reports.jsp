<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.garbhsakhi.model.LabReport" %>

<%
List<LabReport> reports = (List<LabReport>) request.getAttribute("reports");
%>

<div class="container">

    <h2>Lab Reports</h2>

    <%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
    %>
        <div class="alert error-alert">
            <%= errorMessage %>
        </div>
    <%
    }
    %>

    <!-- Upload Form -->
    <form action="<%= request.getContextPath() %>/lab-reports" method="post" enctype="multipart/form-data" class="card">
        <input type="text" name="title" placeholder="Report Title" required />
        <input type="file" name="file" required />
        <button type="submit">Upload</button>
    </form>

    <!-- Reports List -->
    <div class="card">
        <h3>Your Reports</h3>

        <%
        if (reports != null && !reports.isEmpty()) {
            for (LabReport r : reports) {
        %>

        <div class="report-item">
            <p><strong><%= r.getTitle() %></strong></p>

            <a href="view-report?file=<%= r.getFilePath().substring(r.getFilePath().lastIndexOf("/") + 1) %>" target="_blank">View</a>
            <a href="view-report?file=<%= r.getFilePath().substring(r.getFilePath().lastIndexOf("/") + 1) %>" download>Download</a>

            <!-- ✅ FIXED: removed quotes -->
            <button type="button" class="btn-delete" onclick="openDeleteModal('<%= r.getId() %>')">
                Delete
            </button>
        </div>

        <%
            }
        } else {
        %>
        <p>No reports uploaded yet</p>
        <%
        }
        %>

    </div>

</div>

<!-- ✅ DELETE FORM (HIDDEN) -->
<form id="deleteForm" method="post" action="delete-report">
    <input type="hidden" name="reportId" id="deleteReportId">
</form>

<!-- ✅ DELETE MODAL (IMPORTANT FIX: hidden initially) -->
<div id="deleteModal" class="modal-overlay" style="display:none;">
    <div class="modal-box">
        <h3>Delete Report</h3>
        <p>Are you sure you want to delete this report?</p>

        <div class="modal-actions">
            <button type="button" class="btn-cancel" onclick="closeDeleteModal()">Cancel</button>
            <button type="button" class="btn-confirm" onclick="confirmDelete()">Delete</button>
        </div>
    </div>
</div>

<!-- ✅ SCRIPT -->
<script>
let selectedReportId = null;

function openDeleteModal(reportId) {
    selectedReportId = reportId;
    document.getElementById("deleteModal").style.display = "flex";
}

function closeDeleteModal() {
    document.getElementById("deleteModal").style.display = "none";
    selectedReportId = null;
}

function confirmDelete() {
    document.getElementById("deleteReportId").value = selectedReportId;
    document.getElementById("deleteForm").submit();
}
</script>