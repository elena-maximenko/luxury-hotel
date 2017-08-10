<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enter the code</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
    </script>
    <script >
        $(document).ready(function() {
            $('#code').bind('cut copy paste ', function (e) {
                e.preventDefault(); //disable cut,copy,paste
                alert('Cut, copy and paste of code are disabled');
            });
        });
    </script>

    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />
    <link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>
</head>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
   <!-- <div class="InfoBlock" style="top: 10px; position: fixed; width: 100px">Login</div>
    <div class="InputBlock" style="left: 600px; position: fixed">
        <form action="code-from-email" method="post">
        <input type="text" name="loginForResetPassword">
        <input type="submit" value="Send" style="top:65px; position: fixed" onclick="">
        </form>
    </div>-->
    <div id="codeBlock" style="top: 125px; position: fixed;">
        <span style= "font-size: 16px">You will receive the code. Check Your email.</span>
    </div>

    <form method="post" style="width: 600px; height: 70px; position: fixed; top: 300px" action="code-from-email">
        <div id="inputBlock" style="top: 200px">Code from message</div>
        <div id="textBlock" style="top: 200px; position: fixed; left: 600px">
            <input type="text" name="code" id="code">
            <input type="submit" value="OK">
        </div>
    </form>
    <div id="errorBlock" style="height: 50px; width: 300px; top: 400px">
        <% String message = "";
        if(request.getAttribute("error") != null){
            message = (String)request.getAttribute("error");
        }
        %>
        <p><%=message%></p>
    </div>
</div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
<div id="footer">Created by Elena Maximenko</div>
</body>
</html>
