<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.util.PregnancyUtil" %>
<%@ page session="true" %>

<%
    // ✅ AUTH CHECK
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ✅ PROFILE COMPLETION CHECK
    if (!user.isProfileComplete()) {
        response.sendRedirect("onboarding.jsp");
        return;
    }

    int pregWeek = 0;
    String babyFruit = null;
    int pregnancyPercent = 0;

    if (user.getDueDate() != null && !user.getDueDate().isBlank()) {
        pregWeek = PregnancyUtil.getPregnancyWeek(user.getDueDate());
        babyFruit = PregnancyUtil.getFruitForWeek(pregWeek);

        if (pregWeek > 0) {
            pregnancyPercent = (int) Math.round((pregWeek / 40.0) * 100);
            if (pregnancyPercent > 100) pregnancyPercent = 100;
        }
    }

    request.setAttribute("pageTitle", "Dashboard");
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/modern-style.css">
</head>

<body>

    <!-- Layout -->
    <jsp:include page="components/header.jsp" />
    <jsp:include page="components/sidebar.jsp" />
    <jsp:include page="components/bottom-nav.jsp" />
    <jsp:include page="components/fab-emergency.jsp" />

    <!-- ================= DASHBOARD ================= -->
    <div class="main-content">

        <div style="max-width:1100px;margin:0 auto;padding:24px;">

            <!-- ✅ WELCOME CARD WITH PREGNANCY PROGRESS -->
            <div class="welcome-card">

                <div class="welcome-text">
                    <h2>👋 Welcome, <%= user.getFullName() %></h2>

                    <p>
                        Age: <b><%= user.getAge() %></b><br>
                        Due Date: <b><%= user.getDueDate() %></b>
                    </p>

                    <% if (pregWeek > 0) { %>
                        <p>
                            Pregnancy Week: <b><%= pregWeek %> / 40</b><br>
                            Baby Size: <b><%= babyFruit %></b> 🍋
                        </p>
                    <% } %>
                </div>

                <!-- 🤰 PREGNANCY PROGRESS CIRCLE -->
                <% if (pregWeek > 0) { %>
                <div class="pregnancy-ring" style="--percent:<%= pregnancyPercent %>">
                    <svg width="96" height="96">
                        <circle cx="48" cy="48" r="42" class="ring-bg" />
                        <circle cx="48" cy="48" r="42" class="ring-progress" />
                    </svg>
                    <div class="ring-text">
                        <%= pregWeek %><span>/40</span>
                    </div>
                </div>
                <% } %>

            </div>

            <!-- OTHER DASHBOARD CARDS -->
            <div style="display:grid;grid-template-columns:repeat(2,1fr);gap:20px;">
                <div style="background:#fff;padding:20px;border-radius:14px;">💡 Health Tip</div>
                <div style="background:#fff;padding:20px;border-radius:14px;">📅 Next Appointment</div>
                <div style="background:#fff;padding:20px;border-radius:14px;">💊 Today’s Medicines</div>
                <div style="background:#fff;padding:20px;border-radius:14px;">🧪 Recent Lab Report</div>
            </div>

        </div>

    </div>

</body>
</html>
