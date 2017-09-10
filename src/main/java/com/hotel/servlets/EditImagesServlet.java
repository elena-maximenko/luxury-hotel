package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.entity.Room;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.TokenChecker;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

@MultipartConfig()
public class EditImagesServlet extends HttpServlet {
    private ErrorProcessor errorProcessor = new ErrorProcessor();
    public void init(){
        System.out.println(this + ".init()");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        System.out.println(this + ".doGet()");

        try {
            TokenChecker.checkToken(request, response, "EditImagesPage.jsp");
        }
        catch (NullPointerException npe){
            npe.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        String uId;
        String url;
        int number;

        System.out.println(this + ".doPost()");

         url = request.getParameter(NamesOfElements.HIDDEN_IMAGE_URL);
         uId = request.getParameter(NamesOfElements.HIDDEN_IMAGE_UID);
         number = Integer.parseInt(request.getParameter(NamesOfElements.ROOM_NUMBER));
            try{
                DBProxy.getInstance().delete(uId, DBProxy.getQueryDeleteImage());
                File image  = new File(url);
                //CHECK THIS Y "RESULT OF THIS METHOD IS IGNORED"?
                image.delete();
            }
            catch (SQLException sqle){
                sqle.fillInStackTrace();
                errorProcessor.appearError(request, response);
            }

            response.sendRedirect("edit-images?room="+number);
    }
}
