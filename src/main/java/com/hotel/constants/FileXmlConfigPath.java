package com.hotel.constants;

import java.io.File;
import java.net.URISyntaxException;
import java.nio.file.Paths;

public class FileXmlConfigPath {
    private String fileXmlConfigPath;

    public String getFileXmlConfigPath() {
        try {
            fileXmlConfigPath = Paths.get(
                    getClass().getProtectionDomain().getCodeSource().getLocation().toURI()) + File.separator + "log4j.xml";
        } catch (URISyntaxException e) {
            e.printStackTrace();
        };
        return fileXmlConfigPath;
    }
}
