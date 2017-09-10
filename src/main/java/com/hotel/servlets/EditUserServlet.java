package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.entity.User;
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

public class EditUserServlet extends HttpServlet
{
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public void init(){
        System.out.println(this+".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        System.out.println(this + ".doGet()");

        try{
            TokenChecker.checkToken(request, response, "EditUserPage.jsp");
        }
        catch (NullPointerException npe){
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        System.out.println(this + ".doPost()");

        String login = request.getParameter(NamesOfElements.EDITED_LOGIN);

        User user = DBProxy.getInstance().getUserByLogin(login);
        request.setAttribute("userForEdition", user);

        String role = request.getParameter(NamesOfElements.EDITED_ROLE);

        String change = "Role has been changed.";
        HttpSession session = request.getSession(true);
        try{
            DBProxy.getInstance().changeRoleByLogin(login, role);
            session.setAttribute("change", change);

            response.sendRedirect("edit-user?login="+user.getLogin().replace("@", "%40"));
        }
        catch (SQLException e){
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }

    }
}
