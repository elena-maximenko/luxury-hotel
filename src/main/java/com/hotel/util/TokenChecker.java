package com.hotel.util;

import com.hotel.constants.NamesOfElements;
import com.hotel.entity.Room;
import com.hotel.entity.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class TokenChecker {
    private static ErrorProcessor errorProcessor;

    public TokenChecker(){
        errorProcessor = new ErrorProcessor();
    }

    public static void checkUserToken(HttpServletRequest request, HttpServletResponse response, String page) throws IOException, ServletException{
        HttpSession httpSession = request.getSession(false);

        if(httpSession.getAttribute("userToken") != null){
            String token = (String) httpSession.getAttribute("userToken");
            String login = (String) httpSession.getAttribute("login");

            HttpSession session = request.getSession(true);
            session.setAttribute("userToken", token);
            session.setAttribute("login", login);

            switch(page){
                case"RoomImagesPage.jsp":
                {
                    int numberRoomToWatch = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));
                    request.setAttribute("room", numberRoomToWatch);
                    break;
                }
                case "ReservationPage.jsp":{
                    int room = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));
                    session.setAttribute("room", room);
                }
            }
            RequestDispatcher requestDispatcher = request.getRequestDispatcher(page);
            requestDispatcher.forward(request, response);
        }
        else {
            errorProcessor.appearError(request, response);
        }
    }

    public static void checkToken(HttpServletRequest request, HttpServletResponse response, String page) throws IOException, ServletException {
        HttpSession session = request.getSession(false);

            if(session.getAttribute("token") != null){
                String token = (String) session.getAttribute("token");

                HttpSession httpSession = request.getSession(true);
                httpSession.setAttribute("token", token);

                DBProxy dbProxy = new DBProxy();
                switch(page) {
                   /* case "AdminPage.jsp": {
                        List<User> users = dbProxy.getUsers();
                        request.setAttribute("users", users);
                        break;
                    }*/
                    case "EditUserPage.jsp": {
                        String login = request.getParameter(NamesOfElements.LOGIN);//HIDDEN_LOGIN);
                        //System.out.println("login = "+ login);

                        User user = dbProxy.getUserByLogin(login);
                        //System.out.println("user = " + user);

                        request.setAttribute("userForEdition", user);
                        break;
                    }
                    case "EditRoomPage.jsp":
                    case "EditImagesPage.jsp": {
                        int numberRoomForEdit = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));
                        try {
                            Room room = dbProxy.getRoomByNumber(numberRoomForEdit);
                            request.setAttribute("room", room);
                            break;
                        } catch (SQLException sqle) {
                            sqle.fillInStackTrace();
                            errorProcessor.appearError(request, response);
                            break;
                        }
                    }
                }
                RequestDispatcher requestDispatcher = request.getRequestDispatcher(page);
                requestDispatcher.forward(request, response);
            }
            else {
                errorProcessor.appearError(request, response);
            }
    }
}
