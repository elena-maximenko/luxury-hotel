<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enter login</title>
    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />
    <link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>

</head>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
    <%String incorrectLogin = "";
    if(request.getAttribute("incorrectLogin")!= null) {
        incorrectLogin = (String) request.getAttribute("incorrectLogin");
        System.out.println("incorrect login attribute = " + incorrectLogin);
    }
    if (incorrectLogin != "") {%>
    <div id="errorBlock"><%=incorrectLogin%></div>
    <%}%>
    <script type="text/javascript">
        function change(name) {
            document.getElementById(name).style.color = "darkslateblue";
        }
    </script>
    <div class="InfoBlock" style ="top: 60px; position: fixed; width: 100px">
        <label>Login</label>
    </div>
    <div class="input-block" style="left: 600px; position: fixed">
        <form action="send-email" method="post">
            <input type="text" name="email" id="idEmail">
            <input type="submit" value="Send" style="top:95px; position: fixed">
        </form>
    </div>
</div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
<div id="footer">Created by Elena Maximenko</div>
</body>
</html>
