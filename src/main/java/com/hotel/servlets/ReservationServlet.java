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

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            TokenChecker.checkUserToken(request, response, "ReservationPage.jsp");
        } catch (NullPointerException e) {
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int room = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));

        String endDate = request.getParameter(NamesOfElements.END_DATE);
        String beginDate = request.getParameter(NamesOfElements.BEGIN_DATE);

        String login = (String) request.getSession(false).getAttribute("login");

        HttpSession session = request.getSession(true);
        session.setAttribute("begin", beginDate);
        session.setAttribute("end", endDate);

        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date lastMoveOutDate = DBProxy.getInstance().getLastDateByLogin(login, "MoveOutDate");
            Date lastMoveInDate = DBProxy.getInstance().getLastDateByLogin(login, "MoveInDate");

            if (endDate.equals(beginDate)) {
                request.setAttribute("error", "Reservation is possible for at least 1 day.");
                response.sendRedirect("reserve?room=" + room);
                return;
            } else if (!dateFormat.parse(endDate).after(lastMoveOutDate) ||
                    !dateFormat.parse(beginDate).after(lastMoveInDate) ||
                    !dateFormat.parse(beginDate).after(lastMoveOutDate)) {
                session.setAttribute("error", "At this time You've reserved room # " + DBProxy.getInstance().getRoomNumberByMoveOutDateAndLogin(login, lastMoveOutDate.toString()));
                response.sendRedirect("reserve?room=" + room);
                return;
            }

            Date dateBegin = dateFormat.parse(beginDate);
            Date dateEnd = dateFormat.parse(endDate);

            if (dateEnd.before(dateBegin)) {
                session.setAttribute("error", "Wrong dates.");
            } else {
                session.setAttribute("message", "Reservation's been succeed.");

                DBProxy.getInstance().insertInJournal(login, room, new java.sql.Date(dateBegin.getTime()), new java.sql.Date(dateEnd.getTime()));
                Room reservedRoom = DBProxy.getInstance().changeState("Reserved", room);
                Hotel.getInstance().setRoom(room, reservedRoom);
            }
        } catch (ParseException | SQLException e) {
            e.printStackTrace();
            errorProcessor.appearError(request, response);
        }

        response.sendRedirect("reserve?room=" + room);
        return;
    }
}
