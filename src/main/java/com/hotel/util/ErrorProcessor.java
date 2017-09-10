package com.hotel.util;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class ErrorProcessor {
    public void appearError(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/ErrorPage.html");
        requestDispatcher.forward(request, response);
    }
}
