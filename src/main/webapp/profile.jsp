<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.util.PregnancyUtil" %>
<%@ page session="true" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int pregWeek = 0;
    String trimester = "N/A";
    String babyFruit = null;
    if (user.getDueDate() != null && !user.getDueDate().isEmpty()) {
        try {
            pregWeek = PregnancyUtil.getPregnancyWeek(user.getDueDate());
            if (pregWeek > 0) {
                int t = (pregWeek - 1) / 13 + 1;
                trimester = (t <= 3) ? ("Trimester " + t) : "Post-term";
                babyFruit = PregnancyUtil.getFruitForWeek(pregWeek);
            }
        } catch (Exception ignore) {}
    }
    request.setAttribute("pageTitle", "Profile");

    String avatarUrl = request.getContextPath() + "/assets/garbh_sakhi_logo.png";
    if (user.getAvatarPath() != null && !user.getAvatarPath().isBlank()) {
        String storedAvatarPath = user.getAvatarPath().trim();
        if (storedAvatarPath.startsWith("http://")
                || storedAvatarPath.startsWith("https://")
                || storedAvatarPath.startsWith(request.getContextPath() + "/")) {
            avatarUrl = storedAvatarPath;
        } else if (storedAvatarPath.startsWith("/")) {
            avatarUrl = request.getContextPath() + storedAvatarPath;
        } else {
            avatarUrl = request.getContextPath() + "/" + storedAvatarPath;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/modern-style.css">
</head>
<body>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<div class="main-content">
<div class="content-wrapper">

<!-- ================= PROFILE ================= -->
<div class="profile-container">
    <div class="page-header">
        <h2><i class="bi bi-person-circle"></i> Your Profile</h2>
    </div>

    <section class="profile-grid">
        <!-- LEFT : PROFILE SUMMARY -->
        <div class="gs-card profile-summary-card">
            <div class="avatar-wrapper">
                <img id="avatarPreview" class="avatar"
                     src="<%= avatarUrl %>"
                     onerror="this.onerror=null;this.src='<%= request.getContextPath() %>/assets/garbh_sakhi_logo.png';"
                     alt="Profile Avatar">
                <button type="button" class="change-avatar-btn" id="changeAvatarBtn" title="Change profile picture">
                    <i class="bi bi-camera-fill"></i>
                </button>
            </div>

            <h3 class="profile-name"><%= user.getFullName() != null ? user.getFullName() : "User" %></h3>
            <p class="profile-username">@<%= (user.getName() != null && !user.getName().isBlank()) ? user.getName() : "-" %></p>

            <div class="profile-info">
                <div class="info-item">
                    <i class="bi bi-cake2"></i>
                    <span>Age: <%= user.getAge() > 0 ? user.getAge() : "-" %></span>
                </div>
                <div class="info-item">
                    <i class="bi bi-telephone"></i>
                    <span><%= (user.getPhone() != null && !user.getPhone().isBlank()) ? user.getPhone() : "-" %></span>
                </div>
                <div class="info-item">
                    <i class="bi bi-calendar-heart"></i>
                    <span>Pregnancy: Week <%= pregWeek %></span>
                </div>
                <div class="info-item">
                    <i class="bi bi-pie-chart"></i>
                    <span>Trimester: <%= trimester %></span>
                </div>
                <% if (babyFruit != null) { %>
                <div class="info-item">
                    <i class="bi bi-apple"></i>
                    <span>Baby is the size of a <%= babyFruit %></span>
                </div>
                <% } %>
            </div>

            <!-- MODIFIED: Logout button is now a styled link here -->
            <a href="<%= request.getContextPath() %>/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>

        <!-- RIGHT : PROFILE FORM -->
        <div class="gs-card profile-form-card">
            <h4>Edit your details</h4>
            <form action="profile" method="post" enctype="multipart/form-data">
                <!-- MODIFIED: Avatar file input is now inside the form -->
                <input type="file" id="avatarInput" name="avatar" accept="image/*" hidden>

                <div class="field">
                    <label>Full name</label>
                    <input name="full_name" class="input-field" value="<%= user.getFullName() != null ? user.getFullName() : "" %>" required>
                </div>
                <div class="row-2">
                    <div class="field">
                        <label>Username</label>
                        <input name="username" class="input-field" value="<%= user.getName() != null ? user.getName() : "" %>">
                    </div>
                    <div class="field">
                        <label>Age</label>
                        <input type="number" name="age" class="input-field" value="<%= user.getAge() > 0 ? user.getAge() : "" %>">
                    </div>
                </div>
                <div class="row-2">
                    <div class="field">
                        <label>Phone</label>
                        <input name="phone" class="input-field" value="<%= user.getPhone() != null ? user.getPhone() : "" %>">
                    </div>
                    <div class="field">
                        <label>Due date</label>
                        <input type="date" name="due_date" class="input-field" value="<%= user.getDueDate() != null ? user.getDueDate() : "" %>">
                    </div>
                </div>
                <div class="row-2">
                    <div class="field">
                        <label>Doctor Name</label>
                        <input name="doctor_name" class="input-field" value="<%= user.getDoctorName() != null ? user.getDoctorName() : "" %>">
                    </div>
                    <div class="field">
                        <label>Hospital / Clinic</label>
                        <input name="hospital_name" class="input-field" value="<%= user.getHospitalName() != null ? user.getHospitalName() : "" %>">
                    </div>
                </div>
                <div class="field">
                    <label>Known Complications</label>
                    <textarea name="complications" class="input-field" rows="3"><%= user.getComplications() != null ? user.getComplications() : "" %></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-primary">Save Changes</button>
                    <a href="<%= request.getContextPath() %>/dashboard" class="btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </section>
</div>
</div>

<script>
const avatarInput = document.getElementById('avatarInput');
const avatarPreview = document.getElementById('avatarPreview');
const changeAvatarBtn = document.getElementById('changeAvatarBtn');

// When the 'Change' button is clicked, trigger the hidden file input
changeAvatarBtn?.addEventListener('click', () => avatarInput.click());

// When a new file is selected, update the preview
avatarInput?.addEventListener('change', () => {
    const file = avatarInput.files[0];
    if (file) {
        avatarPreview.src = URL.createObjectURL(file);
    }
});
</script>

</body>
</html>
