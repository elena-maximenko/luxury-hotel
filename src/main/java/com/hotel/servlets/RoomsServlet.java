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
import javax.sql.rowset.serial.SerialException;
import java.io.IOException;
import java.sql.SQLException;

public class RoomsServlet extends HttpServlet{
    private int counter;
    ErrorProcessor errorProcessor = new ErrorProcessor();
    public void init(){
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        System.out.println(this + ".doGet()");
        try{
            TokenChecker.checkToken(request, response, "RoomsPage.jsp");
        }
        catch (NullPointerException npe){
            npe.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws  IOException, ServletException{
        System.out.println(this + ".doPost()");

        if(request.getParameter(NamesOfElements.ROOM_NUMBER)!= null){
            try{
                int roomNumber = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));
                DBProxy.getInstance().delete(roomNumber, DBProxy.getQueryDeleteRoom());
                doGet(request, response);
            }
            catch (SQLException sqle){
                errorProcessor.appearError(request, response);
            }
        }
        else {
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
           // counter = sortRooms(request, counter);
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("RoomsPage.jsp");
            requestDispatcher.forward(request, response);
        }
    }

    /*public int sortRooms(HttpServletRequest request, int counter){
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

        request.setAttribute("rooms", DBProxy.getInstance().getRooms(field, order));
        return counter;
    }*/
}
