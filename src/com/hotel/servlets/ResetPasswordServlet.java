package com.hotel.servlets;

import com.hotel.constants.Errors;
import com.hotel.constants.NamesOfElements;
import com.hotel.mail.MailSender;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.StringGenerator;
import com.hotel.util.Validator;
import com.sun.org.apache.xml.internal.security.utils.Base64;
import org.apache.commons.mail.EmailException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

public class ResetPasswordServlet extends HttpServlet {
    private Validator validator = new Validator();
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public void init() {
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(this + ".doGet()");

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("ResetPasswordPage.jsp");
        requestDispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String[] errors;
        String errorMessages = "";

        System.out.println(this + ".doPost()");

        String resetPassword = request.getParameter(NamesOfElements.RESET_PASSWORD);
        System.out.println("reset password = " + resetPassword);
        String confirmedResetPassword = request.getParameter(NamesOfElements.CONFIRMED_RESET_PASSWORD);
        String [] regexes = new String[] {Validator.REGEX_DIGITS, Validator.REGEX_PASSWORD, Validator.REGEX_UPPERCASE};

        for (String regex: regexes) {
            if (!validator.isCorrectParameter(resetPassword, regex, true)){
                switch (regex){
                    case Validator.REGEX_DIGITS: {
                        errorMessages = errorMessages.concat(Errors.containDigit);
                        break;
                    }
                    case Validator.REGEX_PASSWORD: {
                        errorMessages = errorMessages.concat(Errors.containEightCharacters);
                        break;
                    }
                    case Validator.REGEX_UPPERCASE: {
                        errorMessages = errorMessages.concat(Errors.containUppercase);
                        break;
                    }
                }
            }
        }

        if (!resetPassword.equals(confirmedResetPassword)) {
            errorMessages = errorMessages.concat(Errors.confirmCorrectly);
        }

            if (!errorMessages.equals("")) {
                errors = errorMessages.split("\\n\\r");
                request.setAttribute("message", errors);
                doGet(request, response);
            }
            else{
                DBProxy dbProxy = new DBProxy();

                HttpSession httpSession = request.getSession(false);
                String userLogin = (String) httpSession.getAttribute("userLogin");
                System.out.println("userLogin = " + userLogin);

                System.out.println("resetPassword = " + resetPassword);

                try{
                    // delete tokens we've generated in LogInServlet
                    dbProxy.delete(userLogin, dbProxy.getQueryDeleteTokenByUserLogin());

                    StringGenerator generator = new StringGenerator(16);
                    String token = generator.next();

                    HttpSession session = request.getSession(true);
                    session.setAttribute("token", token);

                    try{
                        //insert new token
                        dbProxy.insertToken(token);
                        dbProxy.insertUserToken(userLogin, token);
                    }
                    catch (SQLException e){
                        e.fillInStackTrace();
                        errorProcessor.appearError(request, response);
                        return;
                    }
                    byte [] resetPasswordBytes = resetPassword.getBytes();
                    resetPassword = Base64.encode(resetPasswordBytes);

                    dbProxy.changePassword(userLogin, resetPassword);
                }
                catch (SQLException e){
                    e.fillInStackTrace();
                    errorProcessor.appearError(request, response);
                    return;
                }

                // depends on role
                try{
                    if(httpSession.getAttribute("userToken") != null){
                        response.sendRedirect("account");
                    }
                    else {
                        if(httpSession.getAttribute("token") != null){
                            response.sendRedirect("admin");
                        }
                    }
                }
                catch (NullPointerException e){
                    try {
                        if(httpSession.getAttribute("token") != null){
                            response.sendRedirect("admin");
                        }
                    }
                    catch (NullPointerException npe){
                        npe.fillInStackTrace();
                        errorProcessor.appearError(request, response);
                        // and  do here for manager
                    }
                }
            }
        }
}