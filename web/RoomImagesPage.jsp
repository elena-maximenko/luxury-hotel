<%@ page import="com.hotel.entity.Image" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hotel.util.DBProxy" %>
<%@ page import="com.hotel.entity.Hotel" %>
<%@ page import="com.hotel.entity.Room" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Images of room</title>
    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>
</head>
<body>
<div id="wrapper">
    <%
        //Room room = null;
        DBProxy dbProxy = new DBProxy();
        List<Image> images = null;
        int room = 0;

        if (request.getAttribute("room") != null){
            room = (Integer)(request.getAttribute("room"));
            images = dbProxy.getImagesByRoomNumber(room);
        }
    %>
    <label style="position: fixed;left: 550px; top: 5px">Room # <%=room%></label>
    <div id="entityBlock" style="position: fixed; top: 30px; height: 550px">
        <%
            String alt;
            String src;
        %>
        <table>
            <%for(int i = 0; i < images.size(); i++) {%>
            <tr>
                <td>
                   <div class="entity-info-div" style="height: 400px; padding: 10px">
                        <%
                            alt = "Sorry, image hasn't \nloaded yet.";
                           // System.out.println("url = " + images.get(i).getUrl());
                           // System.out.println("index of = " + images.get(i).getUrl().indexOf("\\Images"));
                            src = images.get(i).getUrl().substring(images.get(i).getUrl().indexOf("\\Images")+1).replace("\\","/");
                            System.out.println(src);
                        %>
                        <img src="<%=src%>" alt="<%=alt%>" style="width:450px;height:400px; background-color: lightgray; color: dimgray; font-size: 14px; font-style: normal">
                    </div>
                </td>
            </tr>
            <%}%>
        </table>
        <%
            HttpSession httpSession = request.getSession(false);
            String token = (String) httpSession.getAttribute("userToken");

            HttpSession ses = request.getSession(true);
            ses.setAttribute("userToken", token);
        %>
        <form style="top: 450px; position: fixed; right: 75px; width: 250px" method="get" action="account">
            <button class="button-submit-with-icon" style="cursor: hand; width: 300px; height: 30px" type="submit">
                <span style="font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to the account</span>
            </button>
        </form>
    </div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
<div id="footer">Created by Elena Maximenko</div>
</div>
</body>
</html>
