<%@ page import="com.hotel.entity.Room" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hotel.entity.Image" %>
<%@ page import="com.hotel.util.DBProxy" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Edit images</title>

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

    <style type="text/css">
        a:link {color: white;}      /* unvisited link */
        a:visited {color: white;}   /* visited link */
        a:hover {color: white;}     /* mouse over link */
        a:active {color: white;}    /* selected link */
    </style>

</head>
<body  onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
    <%
        Room room = null;
        List<Image> images = null;
        if (request.getAttribute("room") != null){
            room = (Room)request.getAttribute("room");
            images = DBProxy.getInstance().getImagesByRoomNumber(room.getNumber());

            HttpSession httpSession = request.getSession(true);
            httpSession.setAttribute("room", room);
        }

    %>
    <div id="functionBlock">
        <form method="post" action="luxury-hotel">
            <input type="submit" value="Log out" style="width: 150px">
        </form>

        <form method="post" action="add-images" enctype='multipart/form-data' style="position: fixed; left: 50px">
            <p><input name="addImages" accept="image/jpeg,image/gif,image/png" multiple type="file" id="file" class="input-file"></p>
            <p><label for="file" style="text-decoration: underline"><span class="glyphicon glyphicon-download-alt" style="cursor:hand; top: 140px; padding:7px; font-size: 18px; text-align: center; width: 150px; color: white; background-color: rebeccapurple; border: 2px solid white; border-radius: 10px; position: fixed; height: 55px">Pick some new files</span></label></p>
            <input type="submit" value="Load" style="width: 150px; position: fixed; top:170px; left: 50px">
            <%
                // pass attribute to the AddImagesServlet
                HttpSession httpSession = request.getSession(true);
                httpSession.setAttribute("numberToAddImages", room.getNumber());
            %>
        </form>

        <form style="top: 500px; position: fixed; left: 1px; width: 250px" method="get" action="<%="edit-room?room="+room.getNumber()%>">
            <button class="button-submit-with-icon" style="cursor:hand; width: 250px; height: 30px" type="submit">
                <span style="font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to editing</span>
            </button>
            <input type="hidden" value="<%=room.getNumber()%>" name="room">
        </form>

        <div id="errorBlock" style="width: 300px; height: 30px; position: fixed; left: 30px; top:350px">

            <%String selectedFiles = "";
                String error = "";
                String message = "";

                HttpSession requestSession = request.getSession(false);

                if(requestSession.getAttribute("selectedFiles") != null){
                    selectedFiles = (String)requestSession.getAttribute("selectedFiles");
                }
                if(requestSession.getAttribute("error") != null){
                    error = (String)requestSession.getAttribute("error");
                }
                if(requestSession.getAttribute("message") != null){
                    message = (String)requestSession.getAttribute("message");%>
            <script>
                document.getElementById("errorBlock").style.color = "aliceblue";
            </script>  <%
}
       %>
            <p><span><%=selectedFiles%></span></p>
            <p><span><%=error%></span></p>
            <p><span><%=message%></span></p>
        </div>
    </div>
    <div id="entityBlock">
        <%
            String alt;
            String src;
        %>
        <table>
            <%for(int i = 0; i < images.size(); i++) {%>
            <tr>
                <td>
                        <div class="entity-info-div" style="height: 250px">
                            <%
                                alt = "Sorry, image hasn't \nloaded yet.";//"Room" +room.getNumber() + "image" + (i+1);
                                src = images.get(i).getUrl().substring(images.get(i).getUrl().indexOf("\\Images")+1).replace('\\','/');
                                System.out.println(src);
                            %>
                            <img src="<%=src%>" alt="<%=alt%>" style="width:200px;height:200px; background-color: lightgray; color: dimgray; font-size: 14px; font-style: normal">
                    </div>
                </td>
                <td>
                    <form method="post" action="edit-images" class="glyphicon-form" style="width: 100px">
                        <input type="hidden" value="<%=images.get(i).getUId()%>" name="hiddenImageUId">
                        <input type="hidden" value="<%=room.getNumber()%>" name="room">
                        <input type="hidden" value="<%=images.get(i).getUrl()%>" name="hiddenImageUrl">
                        <button type="submit" class="button-submit-with-icon">
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
