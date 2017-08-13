<%@ page import="com.hotel.entity.Hotel" %>
<%@ page import="com.hotel.util.DBProxy" %>
<%@ page import="com.hotel.entity.Room" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account</title>
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
<link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>
</head>
<%
    HttpSession ses = request.getSession(false);
    String token = (String)ses.getAttribute("userToken");

    HttpSession httpSession = request.getSession(true);
    httpSession.setAttribute("userToken", token);
%>
<%  Hotel hotel = Hotel.getInstance();
    DBProxy dbProxy = new DBProxy();
    hotel.setRooms(dbProxy.getRooms());
    List<Room> rooms = hotel.getRooms();
%>
<body  onload="updateClock(); setInterval('updateClock()', 1000 )">

<div id="wrapper">
    <div id="functionBlock">
        <form method="post" action="luxury-hotel">
            <input type="submit" value="Log out">
        </form>
        <form> <!-- write action and request method there! -->
            <!--<button type="submit" style="background: transparent; border: none; width: 130px; position: fixed; top: 135px; left: 45px">
                <!--<span class="glyphicon glyphicon-envelope" style="text-align: center; background-color: rebeccapurple; border: 2px solid oldlace; color: oldlace; font: 20px MS Outlook, serif; font-weight: bold; border-radius: 10px"> Send request</span> -->
            <button type="submit" style="width:120px; height:50px; margin: auto; background-color: rebeccapurple; font: 20px MS Outlook, serif;
                                      font-weight: bold; color: oldlace; border-radius: 10px;  border: 2px solid;">
                <span>Reserved<br>earlier</span>
            </button>
        </form>
    </div>

    <div id="entityBlock">
        <table>
            <%for(int i = 0; i < rooms.size(); i++){%>
            <tr>
                <td>
                    <div class="entity-info-div" style="padding:10px"><!--style="width: 500px; position: inherit; color: white; height: 183px; font-size: 16px; left: 400px;"> -->
                        <p><span>Number: <%=rooms.get(i).getNumber()%></span></p>
                        <p><span>Price: <%=rooms.get(i).getPrice()%>$</span></p>
                        <p><span>Category: <%=rooms.get(i).getCategory().getValue()%></span></p>
                        <p><span>Capacity: <%=rooms.get(i).getCapacity().getValue()%></span></p>
                        <p><span>State: <%=rooms.get(i).getState().getValue()%></span></p>
                    </div>
                </td>
                <td>
                    <%String id = "glyphicon-reserve-room-"+i;%>
                    <form method="get" action="reserve" class="glyphicon-form">
                        <button type="submit" class="button-submit-with-icon" id="<%=id%>">
                            <!--!!!!!!!!!!!!!!!!!!! hide if room's reserved  !!!!!!!!!!!!!!!!!!! -->
                            <span class="glyphicon glyphicon-ok" style="padding: 10px; font-size: 22px; float: left; color: limegreen; background-color: white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                        <input type="hidden" value="<%=rooms.get(i).getNumber()%>" name="room">
                    </form>
                </td>
                <%if(rooms.get(i).getState().getValue().equals("Reserved")||rooms.get(i).getState().getValue().equals("Occupied")){%>
                <script>document.getElementById('<%=id%>').style.display='none';</script>
                <%}%>
                <td>
                    <form method="get" action="room-images" class="glyphicon-form" style="width: 100px">
                        <input type="hidden" value="<%=rooms.get(i).getNumber()%>" name="room">
                        <button type="submit" class="button-submit-with-icon">
                            <span class="glyphicon glyphicon-eye-open" style= "padding: 10px; text-align: center; color: rebeccapurple; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
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
</body>
</html>
