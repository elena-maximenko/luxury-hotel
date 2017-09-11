package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.util.DBProxy;
import com.hotel.util.TokenChecker;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AccountServlet extends HttpServlet {
    private int counter = 0;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        //doesn't allow user get to account without registration or login
        try {
            TokenChecker.checkUserToken(request, response, "AccountPage.jsp");
        }
        catch (NullPointerException npe) {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/ErrorPage.html");
            requestDispatcher.forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String field;

        String order = (counter%2==0)?"DESC":"ASC";
        counter++;

        HttpSession session = request.getSession(false);
        if(request.getParameter(NamesOfElements.SORT) == null && session.getAttribute("sort") == null){
            field = "RoomNumber";
        }
        else if(request.getParameter(NamesOfElements.SORT) != null){ // changed in select
            field = request.getParameter(NamesOfElements.SORT);

            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("sort", field);
        }
        else {
            field = (String)session.getAttribute("sort");
        };

        request.setAttribute("rooms", DBProxy.getInstance().getRooms(field, order, false));
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("AccountPage.jsp");
        requestDispatcher.forward(request, response);
    }
}
