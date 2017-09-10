package com.hotel.servlets;

import com.hotel.constants.Errors;
import com.hotel.constants.FileXmlConfigPath;
import com.hotel.entity.Hotel;
import com.hotel.entity.Room;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.Validator;
import com.hotel.constants.NamesOfElements;
import org.apache.log4j.xml.DOMConfigurator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

public class SignUpServlet extends HttpServlet {
    private ErrorProcessor errorProcessor = new ErrorProcessor();
    private Validator validator = new Validator();

    //put jars for log4j in CATALINA_HOME\lib!
    public static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(SignUpServlet.class);

    public void init(){
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        FileXmlConfigPath xmlConfigPath = new FileXmlConfigPath();
        System.out.println(this + ".doGet()");

        DOMConfigurator.configure(xmlConfigPath.getFileXmlConfigPath());

        //logger.info("Registration");
        try {
            DBProxy.getInstance().initialize();

            if (Hotel.getInstance().getRooms() == null || Hotel.getInstance().getRooms().isEmpty()) {
                Hotel.getInstance().setRooms(
                        DBProxy.getInstance().getRooms("Id", "ASC", false)
                );

                for (Room r : Hotel.getInstance().getRooms()) {
                    if (r.getImages() == null || r.getImages().isEmpty()) {
                        r.setImages(DBProxy.getInstance().getImagesByRoomNumber(r.getNumber()));
                    }
                }
            }
        } catch (SQLException | NullPointerException e) {
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
            return;
        }

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("RegistrationPage.jsp");
        requestDispatcher.forward(request, response);
    }

    /* validation for all fields:
    1) name & surname must match to one regex
    2) password: 8 symbols at least one in upper case and one digit
    3) password = confirmedPassword
    (use js to show what password must be)
    */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String errorMessages = "";
        Map<String, List<String>> attributes = new HashMap<>();

        System.out.println(this + ".doPost()");

        // in map of attributes name of element in html page and regex are put
        attributes.put(NamesOfElements.FIRST_NAME, new ArrayList<String>() { {
            add(Validator.REGEX_NAME);
        }});

        attributes.put(NamesOfElements.LAST_NAME, new ArrayList<String>() { {
            add(Validator.REGEX_NAME);
        }});

        attributes.put(NamesOfElements.LOGIN, new ArrayList<String>(){{
            add(Validator.REGEX_LOGIN);
        }});

        // keys must be unique
        attributes.put(NamesOfElements.PASSWORD, new ArrayList<String>(){{
            add(Validator.REGEX_PASSWORD);
            add(Validator.REGEX_DIGITS);
            add(Validator.REGEX_UPPERCASE);
        }} );

        if(!request.getParameter(NamesOfElements.PASSWORD).equals(request.getParameter(NamesOfElements.CONFIRMED_PASSWORD))){
            errorMessages = errorMessages.concat(Errors.confirmCorrectly);
        }

        for (Map.Entry<String, List<String>> entry : attributes.entrySet())
        {
            for (String value: entry.getValue()) {
                //System.out.println(entry.getKey() + "/" + value);

                String parameter = request.getParameter(entry.getKey());
              //  System.out.println("parameter = " + parameter);

                if(!validator.isCorrectParameter(parameter, value, (entry.getKey().equals(NamesOfElements.PASSWORD))?true:false)){

                    if(!entry.getKey().equals(NamesOfElements.PASSWORD)){
                        String nameInMessage = "";
                        String elementName = entry.getKey();
                        if(Validator.indexOfUpperCase(elementName) != -1){ // if name of element in html page is multiple
                            // search the first letter in upper case and split the word at position of letter in upper case
                            String secondPart = elementName.substring(Validator.indexOfUpperCase(elementName));

                            // and make second part to start from letter in lower case via replacement first character in upper case
                            // with in lower case one
                            nameInMessage = elementName.substring(0, Validator.indexOfUpperCase(elementName)) + " " +
                                    secondPart.replace(secondPart.charAt(0), Character.toLowerCase(secondPart.charAt(0)));
                        }
                        else {
                            nameInMessage = elementName;
                        }

                        errorMessages = errorMessages.concat(Errors.wrongInput + nameInMessage).concat(".\n\r");
                    }
                    else {
                        switch (value){
                            case Validator.REGEX_DIGITS:{
                                errorMessages = errorMessages.concat(Errors.containDigit);
                                break;
                            }
                            case Validator.REGEX_UPPERCASE:{
                                errorMessages = errorMessages.concat(Errors.containUppercase);
                                break;
                            }
                            case Validator.REGEX_PASSWORD:{
                                errorMessages = errorMessages.concat(Errors.containEightCharacters);
                                break;
                            }
                        }
                    }

                }
            }
        }
        // System.out.println("errorMessages = " + errorMessages);
        request.setAttribute("errorMessages", errorMessages);

        if(!errorMessages.equals("")){
            request.setAttribute("message", errorMessages);
           // logger.error(logError);*/
            doGet(request, response);
        }
        else {
            HttpSession ses = request.getSession(true);
            ses.setAttribute("userFirstName", request.getParameter(NamesOfElements.FIRST_NAME));
            ses.setAttribute("userLastName", request.getParameter(NamesOfElements.LAST_NAME));
            ses.setAttribute("userLogin", request.getParameter(NamesOfElements.LOGIN));
            ses.setAttribute("userPassword", request.getParameter(NamesOfElements.PASSWORD));
            ses.setAttribute("isRegistration", true);

            response.sendRedirect("code-from-email");
        }
    }
}
