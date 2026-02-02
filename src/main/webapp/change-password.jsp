<%@ page session="true" %>
<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("pageTitle", "Change Password");
%>

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<link rel="stylesheet" href="assets/css/style.css">
<link rel="stylesheet" href="assets/css/modern-style.css">

<div class="page-container">
  <div class="content-wrapper">

    <div class="center-stack">

      <div class="gs-card settings-card">
        <h3>Change Password</h3>
        <p class="muted-text">
          For security reasons, you will be logged out after updating your password.
        </p>

        <form action="<%= request.getContextPath() %>/change-password"
              method="post"
              class="form-stack">

          <!-- CURRENT PASSWORD -->
          <div class="form-group password-field">
            <label>Current Password</label>
            <div class="password-input-wrapper">
              <input type="password"
                     name="currentPassword"
                     required
                     placeholder="Enter current password">
              <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)"></i>
            </div>
          </div>

          <!-- NEW PASSWORD -->
          <div class="form-group password-field">
            <label>New Password</label>
            <div class="password-input-wrapper">
              <input type="password"
                     name="newPassword"
                     required
                     placeholder="Create a new password"
                     oninput="checkStrength(this,'pwdStrength')">
              <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)"></i>
            </div>

            <!-- STRENGTH METER -->
            <div id="pwdStrength" class="strength-meter">
              <div class="strength-bar">
                <div class="strength-fill"></div>
              </div>
              <div class="strength-text"></div>
            </div>
          </div>

          <!-- CONFIRM PASSWORD (FIXED) -->
          <div class="form-group password-field">
            <label>Confirm New Password</label>
            <div class="password-input-wrapper">
              <input type="password"
                     name="confirmPassword"
                     required
                     placeholder="Re-enter new password">
              <i class="ri-eye-line toggle-eye" onclick="togglePassword(this)"></i>
            </div>
          </div>

          <!-- ✅ UPDATE PASSWORD BUTTON (RESTORED) -->
          <button type="submit" class="btn-primary">
            Update Password
          </button>

        </form>

        <% if (request.getParameter("error") != null) { %>
          <div class="alert alert-error">
            Password update failed. Please check your current password.
          </div>
        <% } %>

      </div>

    </div>

  </div>
</div>

<!-- ✅ ONLY THIS SCRIPT -->
<script src="assets/js/password-utils.js"></script>
