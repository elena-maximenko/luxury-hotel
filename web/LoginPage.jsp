<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>
    <script type="text/javascript">
        function changeColor() {
            document.getElementById('idCheckedLogin').style.color = 'darkslateblue';
        }
    </script>

    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />
</head>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
    <div class="input-block">
        <form >
            <p>Login</p>
            <p>Password</p>
        </form>
    </div>
    <form method="post" action="log-in">
        <div class="text-block">
            <p><input type="text" name="checkedLogin" id="idCheckedLogin" onkeypress="changeColor();" onfocus="if(this.value=='This login does not exist.') this.value='';"></p>
            <p><input type="password" name="checkedPassword"></p>
            <input type="submit" name="buttonOk" value="OK">
        </div>
    </form>
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
