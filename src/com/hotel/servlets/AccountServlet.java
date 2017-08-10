package com.hotel.servlets;

import com.hotel.util.TokenChecker;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

//log4j.xml put in artifact directory (although is's been already there)
public class AccountServlet extends HttpServlet {
    public void init(){
        System.out.println(this + "init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        System.out.println(this + "doGet()");
        //doesn't allow user get to account without registration or login
        try {
            TokenChecker.checkUserToken(request, response, "AccountPage.jsp");
        }
        catch (NullPointerException npe) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/ErrorPage.html");
            requestDispatcher.forward(request, response);
        }
    }
}
