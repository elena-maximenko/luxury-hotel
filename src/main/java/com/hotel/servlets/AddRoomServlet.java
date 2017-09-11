package com.hotel.servlets;

import com.hotel.entity.Hotel;
import com.hotel.entity.Image;
import com.hotel.entity.Room;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.*;
import java.util.List;

import com.hotel.constants.NamesOfElements;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.FileHelper;
import com.hotel.util.TokenChecker;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@MultipartConfig()
public class AddRoomServlet extends HttpServlet {
    public static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    public static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    public static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    private String imagesDir;
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public String getImagesDir() {
        try {
            imagesDir = Paths.get(
                    getClass().getProtectionDomain().getCodeSource().getLocation().toURI()).toString();
            imagesDir =  imagesDir.substring(0, imagesDir.indexOf("\\SummaryTask4\\")+"\\SummaryTask4".length()).concat("\\webapp\\Images");

        } catch (URISyntaxException e) {
            e.printStackTrace();
        };
        return imagesDir;
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try{
            TokenChecker.checkToken(request, response, "AddRoomPage.jsp");
        }
        catch (NullPointerException npe){
            npe.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int roomNumber = 0;
        double price = 0.0;

        String category = "";
        String capacity = "";
        String error = "";
        List<String> images = new ArrayList<>();

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

        String uploadPath = getImagesDir();

        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        try{
            List<FileItem> formItems = upload.parseRequest(request);

            FileHelper fileHelper = new FileHelper();
            int countFiles = fileHelper.calculateFiles(formItems);

            if (countFiles > 10){
                error = error.concat("Too many files. Acceptable count is 10.");
                request.setAttribute("error", error);
                doGet(request, response);
                return;
            }

            else if(countFiles == 0){
                String selectedFiles = "No files are selected.";
                request.setAttribute("selectedFiles", selectedFiles);
                doGet(request, response);
                return;
            }

            for (FileItem item : formItems) {
                String fieldName = item.getFieldName();

                if (item.isFormField()) {
                    // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
                    String fieldValue = item.getString();

                    switch(fieldName){
                        case NamesOfElements.ROOM_NUMBER: {
                            try{
                                roomNumber = Integer.parseInt(fieldValue);
                                if (roomNumber == 0){
                                    error = error.concat("Number of room must be bigger then zero.");
                                    request.setAttribute("error", error);
                                    doGet(request, response);
                                    return;
                                }
                            }
                            catch (Exception e){
                                e.fillInStackTrace();
                                errorProcessor.appearError(request, response);
                                return;
                            }
                            break;
                        }
                        case NamesOfElements.ROOM_PRICE: {
                            try{
                                price = Double.parseDouble(fieldValue);
                                if(price == 0){
                                    error = error.concat("Price of room must be bigger then zero.");
                                    request.setAttribute("error", error);
                                    doGet(request, response);
                                    return;
                                }
                            }
                            catch (Exception e){
                                e.fillInStackTrace();
                                errorProcessor.appearError(request, response);
                                return;
                            }
                            break;
                        }
                        case NamesOfElements.ROOM_CAPACITY: {
                            capacity = fieldValue;
                            break;
                        }
                        case NamesOfElements.ROOM_CATEGORY: {
                            category = fieldValue;
                            break;
                        }
                    }
                }
                else{ //if it's file
                    String fileName = new File(item.getName()).getName();
                    if(fileName == ""){
                        continue;
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);

                    // add image for room
                    images.add(filePath);
                    // saves the file on disk
                    try{
                      //  Files.createFile(Paths.get(filePath)); - not loaded

                        item.write(storeFile);
                    }
                    catch (Exception e){
                        e.fillInStackTrace();
                    }
                }
            }
        }
        catch (FileUploadException | NumberFormatException e){
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }

        //do if they are equal to zero
            if(roomNumber < 0 || price < 0){
                error = error.concat("Check Your numbers, we'll use absolute values.");
                request.setAttribute("error", error);
            }

            try{
                Room room = DBProxy.getInstance().insertRoom(roomNumber, category, price, capacity, "Available");
                int roomId = DBProxy.getInstance().getId(roomNumber, DBProxy.getQuerySelectIdFromRooms());

                for (String image: images) {
                    Image picture =  DBProxy.getInstance().insertImage(image, roomId);
                    room.getImages().add(picture);
                }

                Hotel.getInstance().getRooms().add(room);
                String message = "Room's been created successfully.";
                request.setAttribute("message", message);

                doGet(request, response);
            }
            catch (SQLException sqle){
                sqle.fillInStackTrace();
                errorProcessor.appearError(request, response);
            }
    }
}
