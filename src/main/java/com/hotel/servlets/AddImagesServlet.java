package com.hotel.servlets;

import com.hotel.entity.Image;
import com.hotel.entity.Room;
import com.hotel.util.DBProxy;
import com.hotel.util.ErrorProcessor;
import com.hotel.util.FileHelper;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
import java.util.Arrays;
import java.util.List;

import static com.hotel.servlets.AddRoomServlet.MAX_FILE_SIZE;
import static com.hotel.servlets.AddRoomServlet.MAX_REQUEST_SIZE;
import static com.hotel.servlets.AddRoomServlet.MEMORY_THRESHOLD;

@MultipartConfig
public class AddImagesServlet extends HttpServlet {
    private ErrorProcessor errorProcessor = new ErrorProcessor();

    public void doGet(HttpServletRequest request, HttpServletResponse response){
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        HttpSession httpSession;
        int number = 0;
        String error = "";
        List<String> attributes = Arrays.asList("selectedFiles", "error", "message");
        List<String> images = new ArrayList<>();

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

        try{
            List<FileItem> formItems = upload.parseRequest(request);

            FileHelper fileHelper = new FileHelper();
            int countImages = fileHelper.calculateFiles(formItems);

            HttpSession session = request.getSession(false);
            number = (int)session.getAttribute("numberToAddImages");

            List<Image> roomImages = DBProxy.getInstance().getImagesByRoomNumber(number);

            if (countImages+roomImages.size() > 10){
                 httpSession = request.getSession(true);

                error = error.concat("Too many files. Acceptable count is 10.");
                httpSession.setAttribute("error", error);

                removeAttributes(httpSession, attributes, "error");

                response.sendRedirect("edit-images?room=" + number);
                return;
            }

            else if(countImages == 0){
                 httpSession = request.getSession(true);
                String selectedFiles = "No files are selected.";
                httpSession.setAttribute("selectedFiles", selectedFiles);

                removeAttributes(httpSession, attributes, "selectedFiles");
                response.sendRedirect("edit-images?room=" + number);
                return;
            }

            for (FileItem item : formItems) {
                // if file
                if (!item.isFormField()) {
                    String fileName = new File(item.getName()).getName();
                    if(fileName.equals("")){
                        continue;
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);

                    // add image for room
                    images.add(filePath);
                    // saves the file on disk
                    try{
                        item.write(storeFile);
                        //Files.createFile(Paths.get(filePath));
                    }
                    catch (Exception e){
                        e.fillInStackTrace();
                    }
                }
            }
        }
        catch (FileUploadException | NumberFormatException | SQLException e){
            e.fillInStackTrace();
            errorProcessor.appearError(request, response);
        }

        try{
            int roomId = DBProxy.getInstance().getId(number, DBProxy.getQuerySelectIdFromRooms());
            Room room = DBProxy.getInstance().getRoomByNumber(number);
            room.setImages(DBProxy.getInstance().getImagesByRoomNumber(number));

            for (String image: images) {
                Image picture =  DBProxy.getInstance().insertImage(image, roomId);
                room.getImages().add(picture);
            }

            httpSession = request.getSession(true);
            String message = "New images've been added successfully.";
            httpSession.setAttribute("message", message);

            removeAttributes(httpSession, attributes, "message");
        }
        catch (SQLException sqle){
            sqle.fillInStackTrace();
        }

       response.sendRedirect("edit-images?room="+number);
    }

    public void removeAttributes(HttpSession session, List<String> attributes, String unremovable){
        for (String attribute: attributes) {
            if(!attribute.equals(unremovable)){
                if(session.getAttribute(attribute) != null){
                    session.removeAttribute(attribute);
                }
            }
        }
    }
}
