package com.hotel.servlets;

import com.hotel.util.ErrorProcessor;
import com.hotel.util.TokenChecker;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RoomImagesServlet extends HttpServlet {
    private ErrorProcessor errorProcessor = new ErrorProcessor();
    public void init(){
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
       try{
           TokenChecker.checkUserToken(request, response, "RoomImagesPage.jsp");
       }
       catch (NullPointerException e){
           e.fillInStackTrace();
           errorProcessor.appearError(request, response);
       }
    }
}
