<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.garbhsakhi.model.User" %>
<%@ page import="com.garbhsakhi.dao.UserDAO" %>
<%@ page import="com.garbhsakhi.util.PregnancyUtil" %>
<%@ page session="true" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    User user = UserDAO.getUserById(userId);
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int pregWeek = 0;
    String babyFruit = null;

    if (user.getDueDate() != null && !user.getDueDate().isBlank()) {
        pregWeek = PregnancyUtil.getPregnancyWeek(user.getDueDate());
        babyFruit = PregnancyUtil.getFruitForWeek(pregWeek);
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

            <div style="
                background:#fff;
                padding:24px;
                border-radius:16px;
                box-shadow:0 6px 18px rgba(0,0,0,.06);
                margin-bottom:24px;
            ">
                <h2>👋 Welcome, <%= user.getFullName() %></h2>

                <p>
                    Age: <b><%= user.getAge() %></b><br>
                    Due Date: <b><%= user.getDueDate() %></b>
                </p>

                <% if (pregWeek > 0) { %>
                    <p>
                        Pregnancy Week: <b><%= pregWeek %></b><br>
                        Baby Size: <b><%= babyFruit %></b> 🍋
                    </p>
                <% } %>
            </div>

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


