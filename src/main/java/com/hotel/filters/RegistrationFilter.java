package com.hotel.filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

public class RegistrationFilter implements Filter {
    private FilterConfig config;

    public void init(FilterConfig config) throws ServletException {
        this.config = config;
    }

    public void destroy() {
        this.config = null;
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
                        throws ServletException, IOException {

        long startTime = System.currentTimeMillis();
        chain.doFilter(request, response);
        long elapsed = System.currentTimeMillis() - startTime;
        String name = "servlet";
        if (request instanceof HttpServletRequest) {
            name = ((HttpServletRequest) request).getRequestURI();
        }

        System.out.println(name + " took " + elapsed + " ms");
    }
}
