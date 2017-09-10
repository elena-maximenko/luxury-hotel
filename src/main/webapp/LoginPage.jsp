<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>
    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />
    <script type="text/javascript">
        function changeColor() {
            document.getElementById('idCheckedLogin').style.color = 'darkslateblue';
        }
    </script>

    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />
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
    <div class="input-block">
        <form >
            <p>Login</p>
            <p>Password</p>
        </form>
    </div>
    <form method="post" action="sign-in">
        <div class="text-block">
            <p><input type="text" name="checkedLogin" id="idCheckedLogin" onkeypress="changeColor();" onfocus="if(this.value=='This login does not exist.') this.value='';"></p>
            <p><input type="password" name="checkedPassword"></p>
            <button type="submit" class="input-submit-with-icon" style="width:230px; position: fixed; left: 550px; top: 120px">
                OK <span class="glyphicon glyphicon-ok" style="font-style: italic"></span>
            </button>
        </div>
    </form>
    <a href="luxury-hotel"><span style="position:fixed; top:450px; right:75px; font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to start page</span> </a>
    <div id="errorBlock">
        <%String error;
            if(request.getAttribute("error")!= null){
                error = (String)request.getAttribute("error");
        %>
        <%if(error.equals("Wrong password for login.")){%>
        <span><%=error%></span>
        <form method="post" action="send-email" style="top:400px; left: 300px">
            <p><a href="send-email">Forgot your password?</a></p>
        </form>
         <%}
    else {%>
        <script>
            document.getElementById("idCheckedLogin").value = "<%=error%>";
            document.getElementById("idCheckedLogin").style.color = "red";
        </script><%
        }
            }%>
    </div>
</div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
<div id="footer">Created by Elena Maximenko</div>
</body>
</html>
