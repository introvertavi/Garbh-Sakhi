package com.garbhsakhi.servlets;

import com.garbhsakhi.dao.UserDAO;
import com.garbhsakhi.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/auth/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name"); // stored later in onboarding
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
            email.isBlank() || password.isBlank()) {

            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=empty");
            return;
        }

        String hashedPassword = PasswordUtil.hash(password);

        Integer userId = UserDAO.register(email, hashedPassword);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/signup.jsp?error=db");
            return;
        }

        // create session
        HttpSession session = request.getSession(true);
        session.setAttribute("userId", userId);
        session.setAttribute("email", email);

        // name will be saved in onboarding (user_profile)
        session.setAttribute("tempName", name);

        System.out.println("✅ Signup success: " + email);

        response.sendRedirect(request.getContextPath() + "/onboarding.jsp");
    }
}
