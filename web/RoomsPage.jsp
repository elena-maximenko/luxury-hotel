<%@ page import="com.hotel.entity.Room" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hotel.entity.Hotel" %>
<%@ page import="com.hotel.util.DBProxy" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Rooms</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>
</head>

<style type="text/css">
    #wrapper {margin-left: 10px; margin-right: 10px; margin-top: 10px; height: 600px}
    #dateBlock {font: 24px Kokila, serif;}
    #footer {font: 16px Kokila, serif;}
</style>

<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<%
    HttpSession ses = request.getSession(false);
    String token = (String)ses.getAttribute("token");

    HttpSession httpSession = request.getSession(true);
    httpSession.setAttribute("token", token);

%>
<div id="wrapper">
    <div id="functionBlock">
        <form style="position: fixed; top: 90px;" method="get" action="add-room">
            <p>Add new room</p>
            <button type="submit" class="button-submit-with-icon">
                <span class="glyphicon glyphicon-plus-sign" style= "font-size: 46px; text-align: center; color: white; background-color: limegreen; border-radius: 30px; width: 45px; height: 45px"></span>
            </button>
            </p>
        </form>

        <!-- check -->
        <form style="top: 500px; position: fixed; left: 12px; width: 250px" method="get" action="admin">
            <button class="button-submit-with-icon" style="cursor: hand; width: 150px; height: 30px" type="submit">
                <span style="font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to users</span>
            </button>
        </form>
    </div>
    <div id="entityBlock">
        <%  Hotel hotel = Hotel.getInstance();
            DBProxy dbProxy = new DBProxy();
            hotel.setRooms(dbProxy.getRooms());
            List<Room> rooms = hotel.getRooms();
            for (Room r: rooms) {
                System.out.println(r.getNumber());
            }
            System.out.println(rooms);
        %>
        <table>
            <%for(int i = 0; i < rooms.size(); i++){%>
            <tr>
                <td>
                <div class="entity-info-div" style="padding:10px"><!--style="width: 500px; position: inherit; color: white; height: 183px; font-size: 16px; left: 400px;"> -->
                    <p>Number: <span>#<%=rooms.get(i).getNumber()%></span></p>
                    <p><span>Price: <%=rooms.get(i).getPrice()%>$</span></p>
                    <p><span>Category: <%=rooms.get(i).getCategory().getValue()%></span></p>
                    <p><span>Capacity: <%=rooms.get(i).getCapacity().getValue()%></span></p>
                    <p><span>State: <%=rooms.get(i).getState().getValue()%></span></p>
                </div>
                </td>
                <td>
                    <form method="get" action="edit-room" class="glyphicon-form">
                        <button type="submit" class="button-submit-with-icon">
                            <span class="glyphicon glyphicon-pencil" style="padding: 6px; text-align: center; color: darkorchid; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                        <input type="hidden" value="<%=rooms.get(i).getNumber()%>" name="room">
                    </form>
                    <!-- add eye to watch the rooms -->
                </td>
                <td>
                    <form method="post" action="all-rooms?" class="glyphicon-form" style="width: 100px">
                        <button type="submit" class="button-submit-with-icon"> <input type="hidden" value="<%=rooms.get(i).getNumber()%>" name="room">
                            <span class="glyphicon glyphicon-remove" style= "padding: 10px; text-align: center; color: red; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
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
