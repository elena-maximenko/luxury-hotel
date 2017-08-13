<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reserve the room</title>
    <link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>

    <script type="text/javascript">
        function setDefaultDate() {
            var d = new Date();
            var curr_date = d.getDate();
            var curr_month = d.getMonth() + 1;
            var curr_year = d.getFullYear();

            if(curr_month < 10){
                document.getElementById("dateFrom").min = curr_year+"-0"+curr_month+"-"+curr_date;
                document.getElementById("dateFrom").max = curr_year+"-0"+(curr_month+1)+"-"+curr_date;

                document.getElementById("dateTo").min = curr_year+"-0"+curr_month+"-"+(curr_date+1);
                document.getElementById("dateTo").max = curr_year+"-0"+(curr_month+1)+"-"+curr_date;

                document.getElementById("dateTo").defaultValue = curr_year+"-0"+curr_month+"-"+(curr_date+1);
                document.getElementById("dateFrom").defaultValue = curr_year+"-0"+curr_month+"-"+curr_date;
            }
            else {
                document.getElementById("dateFrom").min = curr_year+"-"+curr_month+"-"+curr_date;
                document.getElementById("dateFrom").max = curr_year+"-"+(curr_month+1)+"-"+curr_date;

                document.getElementById("dateTo").min = curr_year+"-"+curr_month+"-"+(curr_date+1);
                document.getElementById("dateTo").max = curr_year+"-"+(curr_month+1)+"-"+curr_date;

                document.getElementById("dateTo").defaultValue = curr_year+"-"+curr_month+"-"+(curr_date+1);
                document.getElementById("dateFrom").defaultValue = curr_year+"-"+curr_month+"-"+curr_date;
            }
        }
    </script>
    <script>
        function setInput() {
            <% HttpSession requestSession = request.getSession(false);
            if(requestSession.getAttribute("begin") != null && requestSession.getAttribute("end")!= null){%>
            document.getElementById("dateTo").defaultValue = "<%=requestSession.getAttribute("end")%>";
            document.getElementById("dateFrom").defaultValue = "<%=requestSession.getAttribute("begin")%>";
        <%}%>
        }

        function getMessage() {
            <%if(requestSession.getAttribute("message")!=null){ %>
            document.getElementById('errorBlock').style.color = "aliceblue";
            document.getElementById('errorBlock').innerHTML = "<%=requestSession.getAttribute("message")%>";
        <%}%>
        }
    </script>
</head>
<body onload="updateClock(); setInterval('updateClock()', 1000 );setDefaultDate(); setInput(); getMessage()">
<%
    HttpSession ses = request.getSession(false);
    String token = (String)ses.getAttribute("userToken");
    int room = (int)ses.getAttribute("room");
    ses.setAttribute("room", room);

    HttpSession httpSession = request.getSession(true);
    httpSession.setAttribute("userToken", token);%>
<div id="wrapper">
    <label style="position: fixed; top: 15px; left: 550px">Reserve the room # <%=room%></label>
    <form action="reserve" method="post">
        <div class="input-block" style="height: 150px">
            <p><label>From</label></p>
            <p><label>To</label></p>
        </div>
        <div class="text-block" style="height: 150px">
            <p ><input type="date" name="BeginDate" id="dateFrom"></p>
            <p ><input type="date" id="dateTo" name="EndDate"></p>
        </div>
        <input type="hidden" value="<%=room%>" name="room">
        <center><input type="submit" value="Reserve" style="position: fixed; top: 120px"></center>
    </form>
    <div id="errorBlock" style="height: 100px;font-size:16px; top:400px"><%=(httpSession.getAttribute("error")==null)?"":(String)httpSession.getAttribute("error")%></div>
    <form style="top: 450px; position: fixed; right: 75px; width: 250px" method="get" action="account?">
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
</body>
</html>
