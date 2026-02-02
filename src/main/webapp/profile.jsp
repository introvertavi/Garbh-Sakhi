<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.util.PregnancyUtil" %>
<%@ page session="true" %>

<%
    // ✅ AUTH CHECK (SESSION-BASED)
    Integer userId = (Integer) session.getAttribute("userId");
    User user = (User) session.getAttribute("user");

    if (userId == null || user == null) {
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
                trimester = (t <= 3) ? ("Trimester " + t) : "Late";
                babyFruit = PregnancyUtil.getFruitForWeek(pregWeek);
            }
        } catch (Exception ignore) {}
    }

    request.setAttribute("pageTitle", "Profile");
%>

<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/style.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/modern-style.css">

<jsp:include page="components/header.jsp" />
<jsp:include page="components/sidebar.jsp" />
<jsp:include page="components/bottom-nav.jsp" />
<jsp:include page="components/fab-emergency.jsp" />

<!-- ================= PROFILE ================= -->
<div class="content-wrapper">

  <div class="profile-container">

    <section class="profile-grid">

      <!-- LEFT : PROFILE SUMMARY -->
      <div class="gs-card profile-left">

        <div class="avatar-wrap">
          <img
            id="avatarPreview"
            class="avatar"
            src="<%= (user.getAvatarPath()!=null && !user.getAvatarPath().isEmpty())
                  ? user.getAvatarPath()
                  : (request.getContextPath()+"/assets/garbh_sakhi_logo.png") %>"
            alt="Profile Avatar">

          <div class="avatar-actions">
            <button type="button" class="btn-ghost" id="changeAvatarBtn">Change</button>
            <button type="button" class="btn-ghost" id="removeAvatarBtn">Remove</button>
            <input type="file" id="avatarInput" accept="image/*" hidden>
          </div>
        </div>

        <ul class="profile-summary">
          <li class="name"><strong><%= user.getFullName() %></strong></li>
          <li>Age: <%= user.getAge() %></li>
          <li>Phone: <%= user.getPhone() %></li>
          <li>Pregnancy: Week <%= pregWeek %></li>
          <li>Trimester: <%= trimester %></li>
          <% if (babyFruit != null) { %>
            <li>Baby size: <%= babyFruit %></li>
          <% } %>
        </ul>

      </div>

      <!-- RIGHT : PROFILE FORM -->
      <div class="gs-card profile-form">

        <h2>Your Profile</h2>

        <form action="profile" method="post" enctype="multipart/form-data">

          <div class="field">
            <label>Full name</label>
            <input name="full_name" value="<%= user.getFullName() %>" required>
          </div>

          <div class="row-2">
            <div class="field">
              <label>Username</label>
              <input name="username" value="<%= user.getName() %>">
            </div>
            <div class="field">
              <label>Age</label>
              <input type="number" name="age" value="<%= user.getAge() %>">
            </div>
          </div>

          <div class="row-2">
            <div class="field">
              <label>Phone</label>
              <input name="phone" value="<%= user.getPhone() %>">
            </div>
            <div class="field">
              <label>Due date</label>
              <input type="date" name="due_date" value="<%= user.getDueDate() %>">
            </div>
          </div>

          <div class="row-2">
            <div class="field">
              <label>Doctor Name</label>
              <input name="doctor_name" value="<%= user.getDoctorName() %>">
            </div>
            <div class="field">
              <label>Hospital / Clinic</label>
              <input name="hospital_name" value="<%= user.getHospitalName() %>">
            </div>
          </div>

          <div class="field">
            <label>Complications</label>
            <textarea name="complications"><%= user.getComplications() %></textarea>
          </div>

          <div class="actions">
            <button type="submit" class="btn-save">Save Profile</button>
            <a href="dashboard.jsp" class="btn-ghost">Back</a>
          </div>

        </form>

      </div>

    </section>

  </div>
</div>

<!-- ================= PROFILE PAGE CSS ================= -->
<style>
.profile-container{
  max-width:1100px;
  margin:0 auto;
  padding:24px;
  box-sizing:border-box;
}

.profile-grid{
  display:grid;
  grid-template-columns:340px 1fr;
  gap:24px;
}

@media (max-width:900px){
  .profile-grid{
    grid-template-columns:1fr;
  }
}
</style>

<script>
const avatarInput = document.getElementById('avatarInput');
document.getElementById('changeAvatarBtn')
  ?.addEventListener('click', () => avatarInput.click());
</script>

<form action="<%= request.getContextPath() %>/logout" method="get">
    <button type="submit">Logout</button>
</form>
