<%@ page import="com.hotel.util.DBProxy" %>
<%@ page import="com.hotel.entity.Room" %>
<%@ page import="com.hotel.entity.User" %>
<%@ page import="com.hotel.enums.Category" %>
<%@ page import="com.hotel.enums.Capacity" %>
<%@ page import="com.hotel.enums.State" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit room</title>
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

    <%
        Room room = null;
        if(request.getAttribute("room")!= null){
            room = (Room)request.getAttribute("room");

            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("room", room);
        }
    %>

    <script type="text/javascript">
        function setDefaultValues() {
            document.getElementById("editedRoomNumberId").defaultValue = "<%=room.getNumber()%>";
            document.getElementById("editedRoomPriceId").defaultValue = "<%=room.getPrice()%>";
        }
    </script>

</head>
<body onload="updateClock(); setInterval('updateClock()', 1000 ); setDefaultValues()">
<div id="wrapper">

    <div class="input-block">
        <form>
            <p>Number</p>
            <p>Category</p>
            <p>Price</p>
            <p>Capacity</p>
            <p>State</p>
            <p>Images</p>
        </form>
    </div>
    <div class="text-block">
        <form method="post" action="edit-room" enctype='multipart/form-data'>
            <p><input type="text" name="editedRoomNumber" id="editedRoomNumberId"></p><!-- placeholder="<%/*=room.getNumber()*/%>" -->
            <p><select name="editedSelectCategory" class="select-role">
                <%for (Category category: Category.values()) {
                        if(category.equals(room.getCategory())){%>
                <option selected><%=category.getValue()%></option>
                <%}
                        else {%>
                <option><%=category.getValue()%></option>
                <%}
                    }%>
            </select></p>
            <p><input type="text" name="editedRoomPrice" id="editedRoomPriceId"></p> <!-- placeholder="<%/*=room.getPrice()*/%>"></p> -->
            <p><select name="editedSelectCapacity" class="select-role">\
                <%for (Capacity capacity: Capacity.values()) {
                        if(capacity.equals(room.getCapacity())) {%>
                <option selected><%=capacity.getValue()%></option>
                <%}
                     else { %>
                <option><%=capacity.getValue()%></option>
                <%}
                }%>
            </select></p>
            <p><select name="editedRoomState" class="select-role">
                <%
                    for (State state: State.values()) {
                        if(state.equals(room.getState())){ %>
                <option selected><%=state.getValue()%></option>
                        <%}
                        else { %>
                <option><%=state.getValue()%></option>
                <% }
                }%>
            </select></p>

            <a href=<%="edit-images?room=" + room.getNumber()%>> Change </a>
           <!-- <div id="buttonFormBlock" style="width: 400px">
                <%
                    HttpSession httpSession = request.getSession(false);
                    String token = (String) httpSession.getAttribute("token");

                    HttpSession ses = request.getSession(true);
                    ses.setAttribute("token", token);
                %>
               <!-- do "Back to rooms thing!"  <p><a href="rooms-in-hotel?">Back to rooms</a></p>
                 submit is necessary 'cos of token! -->
                <p><input type="submit" value="OK"></p>
          <!--  </div> -->
        </form>
    </div>
    <div id="errorBlock" style="position: fixed; top:400px; height: 100px; width: 400px">
        <%
            String warning = "";
            String change = "";

            HttpSession requestSession = request.getSession(false);

            if(requestSession.getAttribute("warning") != null){
                warning = (String)requestSession.getAttribute("warning");
            }
            if(requestSession.getAttribute("change") != null){
                change = (String)requestSession.getAttribute("change");%>
        <script>
            document.getElementById("errorBlock").style.color = "aliceblue";
        </script>
        <%}%>
        <p><span><%=warning%></span></p>
        <p><span><%=change%></span></p>
    </div>
    <form style="top: 500px; right: 75px; position: fixed; width: 250px" method="get" action="all-rooms?">
        <button class="button-submit-with-icon" style="cursor:hand; width: 150px; height: 30px" type="submit">
            <span style="font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to rooms</span>
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
