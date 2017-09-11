package com.hotel.servlets;

import com.hotel.constants.NamesOfElements;
import com.hotel.entity.Hotel;
import com.hotel.entity.Room;
import com.hotel.enums.Capacity;
import com.hotel.enums.Category;
import com.hotel.enums.State;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.TokenChecker;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.hotel.servlets.AddRoomServlet.MAX_FILE_SIZE;
import static com.hotel.servlets.AddRoomServlet.MAX_REQUEST_SIZE;
import static com.hotel.servlets.AddRoomServlet.MEMORY_THRESHOLD;

@MultipartConfig()
public class EditRoomServlet extends HttpServlet{
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        try {
            TokenChecker.checkToken(request, response, "EditRoomPage.jsp");
        }
        catch (NullPointerException npe){
            npe.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        int number = 0;
        String error = "";
        double price = 0.0;
        String capacity = "";
        String category = "";
        String state = "";

        HttpSession session = request.getSession(false);
        Room room = (Room)session.getAttribute("room");

        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        String uploadPath = new AddRoomServlet().getImagesDir();

        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        HttpSession httpSession = request.getSession(true);

        try {
            List<FileItem> formItems = upload.parseRequest(request);

            for (FileItem item : formItems) {
                String fieldName = item.getFieldName();

                if (item.isFormField()) {
                    // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                    String fieldValue = item.getString();

                    switch (fieldName) {
                        case NamesOfElements.EDITED_ROOM_CAPACITY: {
                            capacity = fieldValue;
                            break;
                        }
                        case NamesOfElements.EDITED_ROOM_CATEGORY: {
                            category = fieldValue;
                            break;
                        }
                        case NamesOfElements.EDITED_ROOM_NUMBER: {
                            try{
                                number = Integer.parseInt(fieldValue);

                                if (number == 0){
                                    error = error.concat("Number of room must be bigger then zero.");
                                    httpSession.setAttribute("warning", error);
                                    response.sendRedirect("edit-room?room="+(room.getNumber()));
                                    return;
                                }
                            }
                            catch (Exception e){
                                e.fillInStackTrace();
                                errorProcessor.appearError(request, response);
                            }
                            break;
                        }
                        case NamesOfElements.EDITED_ROOM_PRICE: {
                            try{
                                price = Double.parseDouble(fieldValue);

                                if(price == 0){
                                    error = error.concat("Price of room must be bigger then zero.");
                                    httpSession.setAttribute("warning", error);
                                    response.sendRedirect("edit-room?room="+(room.getNumber()));
                                    return;
                                }
                            }
                            catch (Exception e){
                                e.fillInStackTrace();
                                errorProcessor.appearError(request, response);
                            }
                            break;
                        }
                        case NamesOfElements.EDITED_ROOM_STATE:{
                            state = fieldValue;
                            break;
                        }
                    }
                }
            }
        }
        catch (FileUploadException | NullPointerException | NumberFormatException e){
            errorProcessor.appearError(request, response);
            e.fillInStackTrace();
        }

        Category roomCategory = Category.valueOf(category.contains(" ")?category.replace(' ', '_').toUpperCase():category.toUpperCase());
        Capacity roomCapacity = Capacity.valueOf(capacity.contains(" ")?capacity.replace(' ','_').toUpperCase():capacity.toUpperCase());
        State roomState = State.valueOf(state.toUpperCase());

        if(number < 0 || price < 0){
            error = error.concat("Check Your numbers, we've used absolute values.");
            httpSession.setAttribute("warning", error);
        }
            try{
                Room scope = DBProxy.getInstance().getRoomByNumber(room.getNumber());

                scope.setNumber((number<0)?Math.abs(number):number);
                scope.setCategory(roomCategory);
                scope.setPrice(price);
                scope.setCapacity(roomCapacity);
                scope.setState(roomState);

                DBProxy.getInstance().updateRoomByNumber(number, category, price, capacity, state, room.getNumber());
                httpSession.setAttribute("change", "Room's been changed successfully!");
            }
            catch (SQLException sqle){
                sqle.fillInStackTrace();
                errorProcessor.appearError(request, response);
            }
        response.sendRedirect("edit-room?room="+((number<0)?Math.abs(number):number));
    }
}
