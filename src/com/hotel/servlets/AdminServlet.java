package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.entity.User;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.TokenChecker;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminServlet extends HttpServlet{
    public void init(){
        System.out.println(this + ".init()");
    }
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        System.out.println(this + ".doGet()");

        try{
            TokenChecker.checkToken(request, response, "AdminPage.jsp");
        }
        catch (NullPointerException npe){
            npe.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        DBProxy dbProxy = new DBProxy();

        System.out.println(this + ".doPost()");
        String login = request.getParameter(NamesOfElements.HIDDEN_LOGIN);

        try{
            dbProxy.delete(login, dbProxy.getQueryDeleteUser());
        }
        catch (SQLException e){
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }

        doGet(request, response);
    }
}
