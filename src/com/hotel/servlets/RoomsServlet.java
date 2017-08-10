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
import javax.sql.rowset.serial.SerialException;
import java.io.IOException;
import java.sql.SQLException;

public class RoomsServlet extends HttpServlet{
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
        int roomNumber;
        DBProxy dbProxy = new DBProxy();

        System.out.println(this + ".doPost()");

        roomNumber = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));

        try{
            dbProxy.delete(roomNumber, dbProxy.getQueryDeleteRoom());
            doGet(request, response);
        }
        catch (SQLException sqle){
            errorProcessor.appearError(request, response);
        }
    }
}
