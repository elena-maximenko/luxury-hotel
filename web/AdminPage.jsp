<%@ page import="com.hotel.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- jstl - in global library> -->
<html>
<head>
    <title>Admin</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>

    <style type="text/css">
        a:link {color: white;}      /* unvisited link */
        a:visited {color: white;}   /* visited link */
        a:hover {color: white;}     /* mouse over link */
        a:active {color: white;}    /* selected link */
    </style>

    <style type="text/css">
        #wrapper {margin-left: 10px; margin-right: 10px; margin-top: 10px; height: 600px}
        #dateBlock {font: 24px Kokila, serif;}
        #footer {font: 16px Kokila, serif;}
    </style>

</head>
<body  onload="updateClock(); setInterval('updateClock()', 1000 )">
<%
    HttpSession ses = request.getSession(false);
    String token = (String)ses.getAttribute("token");

    HttpSession httpSession = request.getSession(true);
    httpSession.setAttribute("token", token);
%>
<div id="wrapper">
    <div id="functionBlock">
        <form method="post" action="luxury-hotel">
            <input type="submit" value="Log out">
        </form>

        <form method="get" action="all-rooms">
            <input type="submit" style="position: fixed; top: 90px; left: 50px" value="Rooms"/>
        </form>
    </div>
    <div id="entityBlock">
        <table>
         <% List<User> users = (List<User>)request.getAttribute("users");
             for(int i = 0; i < users.size(); i++) {%>
            <tr>
                <td>
                   <!--  <div class="entity-div"> -->
                        <div class="entity-info-div" style="padding: 10px; height: 100px; font-size: 18px">
                            <span style="padding: 10px"><%=users.get(i).getLogin()%></span>
                    <!--    </div> -->
                    </div>
                </td>
                <td>
                    <form method="get" action="edit-user" class="glyphicon-form">
                       <!-- <a href="<%/*="edit-user?login=" + users.get(i).getLogin() */%> ">
                            <span class="glyphicon glyphicon-pencil" style="padding: 6px; text-align: center; color: darkorchid; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </a> -->
                        <button type="submit" class="button-submit-with-icon">
                            <span class="glyphicon glyphicon-pencil" style="padding: 6px; text-align: center; color: darkorchid; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                        <input type="hidden" value="<%=users.get(i).getLogin()%>" name="login">

                    </form>
                </td>
                <td>
                    <form method="post" action="admin" class="glyphicon-form" style="width: 100px">
                        <button type="submit" class="button-submit-with-icon"> <input type="hidden" value="<%=users.get(i).getLogin()%>" name="hiddenLogin">
                            <span class="glyphicon glyphicon-remove" style= "padding: 10px; text-align: center; color: red; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                        <input type="hidden" value="<%=users.get(i).getLogin()%>" name="login">
                    </form>
                </td>
            </tr>
        <%}%>
        </table>
    </div>
</div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
<div id="footer">Created by Elena Maximenko</div>
</body>
</html>
