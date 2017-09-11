package com.hotel.constants;

import java.io.File;
import java.net.URISyntaxException;
import java.nio.file.Paths;

public class FileXmlConfigPath {
    private String fileXmlConfigPath;

    public String getFileXmlConfigPath() {
        fileXmlConfigPath = new com.hotel.servlets.AddRoomServlet().getImagesDir();
        fileXmlConfigPath = fileXmlConfigPath.substring(0, fileXmlConfigPath.lastIndexOf("\\Images")).concat("\\log4j.xml");;
        return fileXmlConfigPath;
    }
}
