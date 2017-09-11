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
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class AdminServlet extends HttpServlet{
    private int counter = 0;

    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        try{
            TokenChecker.checkToken(request, response, "AdminPage.jsp");
        }
        catch (NullPointerException npe){
            npe.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String login = request.getParameter(NamesOfElements.LOGIN);//.HIDDEN_LOGIN);

        if(login == null){
            String order = (counter%2==0)?"DESC":"ASC";
            counter++;

            String field = "";
            HttpSession session = request.getSession(false);
            if(request.getParameter(NamesOfElements.SORT)!= null){
                field = request.getParameter(NamesOfElements.SORT);
                session.setAttribute("field", field);
            }
            else if(session.getAttribute("field")!= null){
                field = (String)session.getAttribute("field");
            }
            else {
                field = "Id";
            }

            List<User> users = DBProxy.getInstance().getUsers(field, order);
            request.setAttribute("users", users);
        }
        else {
            try{
                DBProxy.getInstance().delete(login, DBProxy.getQueryDeleteUser());
            }
            catch (SQLException e){
                e.fillInStackTrace();
                errorProcessor.appearError(request, response);
            }
        }

        doGet(request, response);
    }
}
