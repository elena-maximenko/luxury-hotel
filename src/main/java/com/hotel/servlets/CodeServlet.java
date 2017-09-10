package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.mail.MailSender;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.StringGenerator;
import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import org.apache.commons.mail.EmailException;
import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;

public class CodeServlet extends HttpServlet {
    private MailSender mailSender = new MailSender();
    private boolean isSent;
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    Logger logger = Logger.getLogger(CodeServlet.class);

    public void init() {
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isRegistration;
        System.out.println(this + ".doGet()");

        HttpSession se = request.getSession(false);
        try {
            if (se.getAttribute("isRegistration") != null) {
                isRegistration = (Boolean) se.getAttribute("isRegistration");

            } else {
                isRegistration = false;
            }
        } catch (NullPointerException ne) {
            isRegistration = false;
        }

        try {
            String userLogin = (String) se.getAttribute("userLogin");
            try {
                if(!isSent){
                    mailSender.send(userLogin, isRegistration);
                    isSent = true;
                }
                //logger.info("Message has been sent.");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("CodePage.jsp");
                requestDispatcher.forward(request, response);
            } catch (EmailException | Base64DecodingException | SQLException e) {
                e.fillInStackTrace();
                errorProcessor.appearError(request, response);
            }
        } catch (NullPointerException npe) {
            npe.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        System.out.println(this + "doPost()");

        String code = request.getParameter(NamesOfElements.CODE);

        if (!code.equals(mailSender.getLastSentCode())) {
            request.setAttribute("error", "Code is not correct.");
            doGet(request, response);
        } else {
            //logger.info("Registration has been successful");

            HttpSession session = request.getSession(false);
            try{
                if(session.getAttribute("isRegistration") != null){
                    if ((Boolean) session.getAttribute("isRegistration")) {
                        HttpSession httpSession = request.getSession(false);
                        String userLogin = (String) httpSession.getAttribute("userLogin");
                        String userFirstName = (String) httpSession.getAttribute("userFirstName");
                        String userLastName = (String) httpSession.getAttribute("userLastName");
                        String userPassword = (String) httpSession.getAttribute("userPassword");

                        StringGenerator tokenGenerator = new StringGenerator(16);
                        String token = tokenGenerator.next();

                        byte[] password = userPassword.getBytes(StandardCharsets.UTF_8);
                        userPassword = com.sun.org.apache.xml.internal.security.utils.Base64.encode(password);

                        try {
                            DBProxy.getInstance().insertUser(userFirstName, userLastName, userLogin, userPassword);
                            DBProxy.getInstance().insertToken(token);
                            DBProxy.getInstance().insertUserToken(userLogin, token);

                            HttpSession ses = request.getSession(true);
                            ses.setAttribute("userToken", token);
                        } catch (SQLException e) {
                            errorProcessor.appearError(request, response);
                            return;
                        }
                        //logger.info("New user " + NamesOfElements.LOGIN + " has registered.");*/

                        response.sendRedirect("account");
                    }
                }
                else {
                    response.sendRedirect("reset-password");
                }
            }
           catch (NullPointerException e){
               response.sendRedirect("reset-password");
           }
        }
    }
}
