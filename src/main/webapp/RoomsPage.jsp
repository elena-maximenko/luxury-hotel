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
       <!-- <form style="position: fixed; top: 40px;" method="get" action="add-room">
            <p>Add new room</p>
            <button type="submit" class="button-submit-with-icon">
                <span class="glyphicon glyphicon-plus-sign" style= "font-size: 46px; text-align: center; color: white; background-color: limegreen; border-radius: 30px; width: 45px; height: 45px"></span>
            </button>
            </p>
        </form> -->
        <form style="position: fixed; right: 1055px; top: 10px; width: 300px" method="get" action="add-room">
            <button type="submit" class="input-submit-with-icon" style="width: 200px">
                Аdd new room <span class="glyphicon glyphicon-plus"></span>
            </button>
        </form>

        <form>
            <button style="position:fixed; top: 135px; width:200px; height: 45px; text-align: center; background-color: rebeccapurple; border: 2px solid oldlace; color: oldlace; font: 20px MS Outlook, serif; font-weight: bold; border-radius: 10px" onclick="return getSortSelect();"><!--style="background: transparent; border: none; width: 130px; position: fixed; top: 135px; left: 45px" -->
                <span>Sort</span>
            </button>
            <script src="Scripts.js"></script>

            <form method="post" action="admin" class="glyphicon-form">
                <button type="submit" id="orderButton" class="button-submit-with-icon" style="position: fixed; top: 60px; left: 280px">
                    <span class="glyphicon glyphicon-sort" style= "padding:7px; font-size: 27px; text-align: center; color: oldlace; border: solid 2px oldlace; background-color: rebeccapurple; border-radius: 30px; width: 45px; height: 45px"></span>
                </button>
            </form>

            <p>
                <select id="selectSort" class="select-role" style="position:fixed; left: 50px; top: 170px; display:none; width: 120px">
                    <option disabled selected>Sort by </option>
                    <option value="RoomNumber">Number</option>
                    <option value="Price">Price</option>
                    <option value="Capacity">Capacity</option>
                    <option value="Category">Category</option>
                    <option value="State">State</option>
                </select>
            </p>
        </form>

        <form style="top: 500px; position: fixed; left: 12px; width: 250px" method="get" action="admin">
            <button class="button-submit-with-icon" style="cursor: hand; width: 150px; height: 30px" type="submit">
                <span style="font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to users</span>
            </button>
        </form>
    </div>
    <div id="entityBlock">
        <%  List<Room>rooms;
            if(request.getAttribute("rooms") == null){
                Hotel hotel = Hotel.getInstance();
                hotel.setRooms(DBProxy.getInstance().getRooms("Id", "ASC", false));
                rooms = hotel.getRooms();
        }
        else {
                rooms = (List<Room>)request.getAttribute("rooms");
            }
             %>
        <table>
            <%for(int i = 0; i < rooms.size(); i++){
                DBProxy.getInstance().setRoomsState(rooms.get(i).getNumber(), "MoveInDate", "Occupied");
                DBProxy.getInstance().setRoomsState(rooms.get(i).getNumber(), "MoveOutDate", "Available");
            %>
            <tr>
                <td>
                <div class="entity-info-div" style="padding:10px">
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
