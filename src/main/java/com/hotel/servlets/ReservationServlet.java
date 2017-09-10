package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.entity.Hotel;
import com.hotel.entity.Room;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.TokenChecker;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

public class ReservationServlet extends HttpServlet {
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public void init() {
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println(this + ".doGet()");
        try {
            TokenChecker.checkUserToken(request, response, "ReservationPage.jsp");
        } catch (NullPointerException e) {
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println(this + "doPost()");

        //HttpSession session = request.getSession(false);
        int room = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));

        String endDate = request.getParameter(NamesOfElements.END_DATE);
        String beginDate = request.getParameter(NamesOfElements.BEGIN_DATE);

        HttpSession session = request.getSession(true);
        session.setAttribute("begin", beginDate);
        session.setAttribute("end", endDate);
        if (endDate.equals(beginDate)) {
            session.setAttribute("error", "Reservation is possible for at least 1 day.");
            response.sendRedirect("reserve?room=" + room);
            return;
        }

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");//"MM-dd-yyyy");
       try{
           Date dateBegin = dateFormat.parse(beginDate);
           Date dateEnd = dateFormat.parse(endDate);

           if(dateEnd.before(dateBegin)){
               session.setAttribute("error", "Wrong dates.");
           }
            else{
               session.setAttribute("message", "Reservation's been succeed.");
               new AddImagesServlet().removeAttributes(session, Arrays.asList("error", "message"), "message");

               String login = (String)request.getSession(true).getAttribute("login");
               DBProxy.getInstance().insertInJournal(login, room, new java.sql.Date(dateBegin.getTime()), new java.sql.Date(dateEnd.getTime()));
               Room reservedRoom = DBProxy.getInstance().changeState("Reserved", room);
               Hotel.getInstance().setRoom(room, reservedRoom);
           }
       }
       catch (ParseException | SQLException e){
           e.printStackTrace();
           errorProcessor.appearError(request, response);
       }

        response.sendRedirect("reserve?room=" + room);
        return;
    }
}
