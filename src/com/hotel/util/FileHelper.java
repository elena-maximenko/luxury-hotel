package com.hotel.util;

import org.apache.commons.fileupload.FileItem;

import java.util.List;

public class FileHelper {

     public int calculateFiles(List<FileItem> fileItems){
         int countFiles = 0;
         for (FileItem fileItem: fileItems) {
             // check on empty files
             if(!fileItem.isFormField() && (fileItem.getName() != null && fileItem.getName()!="")){
                 System.out.println(fileItem.getName());
                 countFiles++;
             }
         }
         return countFiles;
     }
}
