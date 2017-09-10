<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enter login</title>
    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>
</head>
<style type="text/css">
    a:link {color: white;}      /* unvisited link */
    a:visited {color: white;}   /* visited link */
    a:hover {color: white;}     /* mouse over link */
    a:active {color: white;}    /* selected link */
    #wrapper {margin-left: 10px; margin-right: 10px; margin-top: 10px; height: 610px}
    #dateBlock {font: 24px Kokila, serif;}
    #footer {font: 16px Kokila, serif;}
</style>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
    <%String incorrectLogin = "";
    if(request.getAttribute("incorrectLogin")!= null) {
        incorrectLogin = (String) request.getAttribute("incorrectLogin");
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
           <!-- <input type="submit" value="Send" style="top:95px; position: fixed"> -->
            <button type="submit" class="input-submit-with-icon" style="position: fixed; top:95px; width: 230px; left: 550px">
                Send <span class="glyphicon glyphicon-envelope" style="font-style: italic"></span>
            </button>
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
