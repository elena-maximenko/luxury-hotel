<%@ page import="com.hotel.entity.User" %>
<%@ page import="com.hotel.enums.Role" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit user</title>
    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style type="text/css">
    #wrapper {margin-left: 10px; margin-right: 10px; margin-top: 10px; height: 600px}
    #dateBlock {font: 24px Kokila, serif;}
    #footer {font: 16px Kokila, serif;}
</style>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<%User user = (User)request.getAttribute("userForEdition");
request.setAttribute("editedUser", user);%>
<div id="wrapper">
    <div class="input-block">
        <form>
            <p>First name</p>
            <p>Last name</p>
            <p>Login</p>
            <p>Role</p>
        </form>
    </div>
    <div class="text-block">
        <form action="edit-user" method="post">
        <p><input type="text"  value="<%=user.getFirstName()%>" name="editedFirstName" readonly></p>
        <p><input type="text"  value="<%=user.getLastName()%>" name="editedLastName" readonly></p>
        <p><input type="text" value="<%=user.getLogin()%>" name="editedLogin" readonly></p>
        <p>
            <select class="select-role" name="selectRole">
                <%
                    for (Role role: Role.values()) {
                        if(role.getValue().equals(user.getRole().getValue())){ %>
                            <option selected><%=user.getRole().getValue()%></option>
                       <% }
                       else { %>
                <option><%=role.getValue()%></option>
                      <% }
                    }%>
            </select>
        </p>
            <!-- <input type="submit" value="OK"> -->
            <button type="submit" class="input-submit-with-icon" style="width:230px; position: fixed; left: 550px; top: 230px">
                OK <span class="glyphicon glyphicon-ok" style="font-style: italic"></span>
            </button>
        </form>
        </div>

    <%
        HttpSession httpSession = request.getSession(false);

        String change = "";
        if(httpSession.getAttribute("change") != null){
            change = (String)httpSession.getAttribute("change");
        }%>
    <div id="changeBlock" class="change-block">
        <span><%=change%></span>
    </div>

    <%
        String token = (String) httpSession.getAttribute("token");

        HttpSession ses = request.getSession(true);
        ses.setAttribute("token", token);
    %>
    <form style="top: 450px; position: fixed; right: 75px; width: 250px" method="get" action="admin">
        <button class="button-submit-with-icon" style="cursor: hand; width: 150px; height: 30px" type="submit">
         <span style="font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to users</span>
        </button>
    </form>
</div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
<div id="footer">Created by Elena Maximenko</div>
</body>
</html>
