package com.hotel.servlets;

import com.hotel.entity.Hotel;
import com.hotel.entity.Room;
import com.hotel.enums.Capacity;
import com.hotel.enums.Category;
import com.hotel.enums.State;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class StartServlet extends HttpServlet{
    ErrorProcessor errorProcessor = new ErrorProcessor();
    public void init(){
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        System.out.println(this + ".doGet()");

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/StartPage.html");
        requestDispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        System.out.println(this + "doPost()");
        String token = "";
        HttpSession httpSession = request.getSession(false);
        if(httpSession.getAttribute("token") != null){
             token = (String)httpSession.getAttribute("token");
        }
        else if(httpSession.getAttribute("userToken")!= null){
            token = (String)httpSession.getAttribute("userToken");
        }
        //System.out.println("token = " + token);

        try {
            DBProxy.getInstance().delete(token, DBProxy.getQueryDeleteToken());
            HttpSession session = request.getSession(true);
            session.setAttribute("token", null);
            doGet(request, response);
        }
        catch (SQLException e){
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }
}
