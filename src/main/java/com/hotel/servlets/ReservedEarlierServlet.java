package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.TokenChecker;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ReservedEarlierServlet extends HttpServlet{
    private int counter;
    private ErrorProcessor errorProcessor = new ErrorProcessor();
    public void init(){
        System.out.println(this+".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        System.out.println(this + ".doGet()");
        try{
            TokenChecker.checkUserToken(request, response, "ReservedEarlierPage.jsp");
        }
        catch (Exception e){
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String field;

        System.out.println(this + ".doPost()");

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

        request.setAttribute("rooms", DBProxy.getInstance().getRooms(field, order, true));
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("ReservedEarlierPage.jsp");
        requestDispatcher.forward(request, response);
    }
}
