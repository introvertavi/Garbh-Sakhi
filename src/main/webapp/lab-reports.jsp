<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.garbhsakhi.model.LabReport" %>

<%
List<LabReport> reports = (List<LabReport>) request.getAttribute("reports");
%>

<div class="container">

    <h2>Lab Reports</h2>

    <!-- Upload Form -->
    <form action="lab-reports" method="post" enctype="multipart/form-data" class="card">
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

            <a href="<%= r.getFilePath() %>" target="_blank">View</a>
            <a href="<%= r.getFilePath() %>" download>Download</a>
            <a href="delete-report?id=<%= r.getId() %>">Delete</a>
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