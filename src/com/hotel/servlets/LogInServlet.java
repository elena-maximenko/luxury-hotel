package com.hotel.servlets;

import com.hotel.constants.DBConstants;
import com.hotel.constants.NamesOfElements;
import com.hotel.constants.FileXmlConfigPath;
import com.hotel.entity.User;
import com.hotel.enums.Role;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.StringGenerator;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import org.apache.log4j.Logger;
import org.apache.log4j.xml.DOMConfigurator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LogInServlet extends HttpServlet {
    private DBProxy dbProxy;
    Logger logger = Logger.getLogger(LogInServlet.class);
    ErrorProcessor errorProcessor = new ErrorProcessor();

    public void init(){
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        FileXmlConfigPath xmlConfigPath = new FileXmlConfigPath();

        System.out.println(this + ".doGet()");

        DOMConfigurator.configure(xmlConfigPath.getFileXmlConfigPath());
        //logger.info("Log in");
       try{
           DBProxy dbProxy = new DBProxy();
           dbProxy.initialize();
       }
       catch (SQLException | NullPointerException e){
           errorProcessor.appearError(request, response);
           return;
       }

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("LoginPage.jsp");
        requestDispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        dbProxy = new DBProxy();

        System.out.println(this + "doPost()");
        String checkedLogin = request.getParameter(NamesOfElements.CHECKED_LOGIN);

        if(dbProxy.findUser(checkedLogin)){
            String checkedPassword = request.getParameter(NamesOfElements.CHECKED_PASSWORD);

            String password = dbProxy.getUserPassword(checkedLogin, "Users");
            try{
                byte [] passwordBytes = Base64.decode(password);
                password = new String(passwordBytes);
            }
            catch (Base64DecodingException | NullPointerException e){
                e.fillInStackTrace();
                errorProcessor.appearError(request, response);
                return;
            }
            if(password.equals(checkedPassword)){
                StringGenerator generator = new StringGenerator(16);
                String token = generator.next();
                try{
                    HttpSession session = request.getSession(true);
                    session.setAttribute("login", checkedLogin);
                    dbProxy.insertToken(token);
                    dbProxy.insertUserToken(checkedLogin, token);

                    User user = dbProxy.getUserByLogin(checkedLogin);
                    Role role = user.getRole();
                    //System.out.println("role = " + role);
                    if(role.getValue().equals("Admin")){
                        session.setAttribute("token", token);
                        response.sendRedirect("admin");
                    }
                    else {
                        // logger.info("Login has been successful.");
                        session.setAttribute("userToken", token);
                        response.sendRedirect("account");
                    }
                }
                catch (SQLException e){
                    e.fillInStackTrace();
                    errorProcessor.appearError(request, response);
                    return;
                }
            }
            else {
              //  logger.error("Wrong password in login");
                request.setAttribute("error", "Wrong password for login.");

                doGet(request, response);
            }
        }
        else{
            request.setAttribute("error", "This login does not exist.");
            //logger.error("Wrong login.");
            doGet(request, response);
        }
    }
}
