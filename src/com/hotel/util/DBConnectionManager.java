package com.hotel.util;

import com.hotel.constants.DBConstants;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionManager {
    /*private String url;

  public DBConnectionManager() throws  ClassNotFoundException{
      Class.forName("com.mysql.jdbc.Driver");
  }

    public void setUrl(String url) {
        this.url = url;
    }

    public Connection getConnection(/*String dbURL, String user, String password) throws SQLException {
        Connection connection = DriverManager.getConnection(url);//, user, password);
        connection.setClientInfo("user", DBConstants.USER);
        connection.setClientInfo("password", DBConstants.PASSWORD);

        return connection;
    }*/
}
