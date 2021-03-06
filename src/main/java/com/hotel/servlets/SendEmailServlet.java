package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.util.DBProxy;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class SendEmailServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("SendEmailPage.jsp");
        requestDispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String email = request.getParameter(NamesOfElements.EMAIL);

        if(DBProxy.getInstance().findUser(email)){
            HttpSession session = request.getSession(true);
            session.setAttribute("userLogin", email);
            response.sendRedirect("code-from-email");
        }
        else {
            String error = "This login does not exist.";
            request.setAttribute("incorrectLogin", error);
            doGet(request, response);
        }
    }
}
