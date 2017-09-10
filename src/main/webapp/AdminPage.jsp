<%@ page import="com.hotel.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hotel.util.DBProxy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <input type="submit" style="position: fixed; top: 78px; left: 50px" value="Rooms"/>
        </form>

        <form method="post" action="admin" style="position: fixed; left: 50px">
            <!-- left:100-->
            <button style="position:fixed; top: 200px; width:120px; height: 45px; text-align: center; background-color: rebeccapurple; border: 2px solid oldlace; color: oldlace; font: 20px MS Outlook, serif; font-weight: bold; border-radius: 10px" onclick="return getSortSelect();">
                <span>Sort</span>
            </button>
            <script src="Scripts.js"></script>

            <p>
                <!--left: 180px; -->
                <select name="selectSort" id="selectSort" onchange="this.form.submit();" class="select-role" style="position:fixed; top: 255px; display:none; width: 120px">
                    <option selected disabled>Sort by</option>
                    <option value="Id">Id</option>
                    <option value="FirstName">First name</option>
                    <option value="LastName">Last name</option>
                    <option value="Login">Login</option>
                    <option value="Role">Role</option>
                </select>
            </p>
        </form>

        <form method="post" action="admin" class="glyphicon-form" style="position: fixed; top: 60px; left: 220px">
            <button type="submit" id="orderButton" class="button-submit-with-icon">
                <span class="glyphicon glyphicon-sort" style= "padding:7px; font-size: 27px; text-align: center; color: oldlace; border: solid 2px oldlace; background-color: rebeccapurple; border-radius: 30px; width: 45px; height: 45px"></span>
            </button>
        </form>
    </div>
    <div id="entityBlock">
        <table>
         <% List<User> users = (request.getAttribute("users")==null)?DBProxy.getInstance().getUsers("Id", "ASC"):(List<User>)request.getAttribute("users");//(List<User>)request.getAttribute("users");
             for(User user: users){%>
            <tr>
                <td>
                        <div class="entity-info-div" style="padding: 10px; height: 100px; font-size: 18px">
                            <span><%=user.getFirstName()+ " " + user.getLastName()%></span>
                            <p><span style="padding: 10px"><%="Login: "+ user.getLogin()%></span></p>
                            <p><span style="padding: 10px"><%="Role: "+ user.getRole().getValue()%></span></p>
                    </div>
                </td>
                <td>
                    <form method="get" action="edit-user" class="glyphicon-form">
                        <button type="submit" class="button-submit-with-icon">
                            <span class="glyphicon glyphicon-pencil" style="padding: 6px; text-align: center; color: darkorchid; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                        <input type="hidden" value="<%=user.getLogin()%>" name="login">
                    </form>
                </td>
                <td>
                    <form method="post" action="admin" class="glyphicon-form" style="width: 100px">
                        <button type="submit" class="button-submit-with-icon"> <!-- <input type="hidden" value="<%/*=user.getLogin()*/%>" name="hiddenLogin"> -->
                            <span class="glyphicon glyphicon-remove" style= "padding: 10px; text-align: center; color: red; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                        <input type="hidden" value="<%=user.getLogin()%>" name="login">
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
