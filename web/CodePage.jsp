<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enter the code</title>

   <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
    </script>
    <script >
        $(document).ready(function() {
            $('#code').bind('cut copy paste ', function (e) {
                e.preventDefault(); //disable cut,copy,paste
                alert('Cut, copy and paste of code are disabled');
            });
        });
    </script> -->

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />
    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>
</head>
<style type="text/css">
    a:link {color: white;}      /* unvisited link */
    a:visited {color: white;}   /* visited link */
    a:hover {color: white;}     /* mouse over link */
    a:active {color: white;}    /* selected link */
    #wrapper {margin-left: 10px; margin-right: 10px; margin-top: 10px; height: 600px}
    #dateBlock {font: 24px Kokila, serif;}
    #footer {font: 16px Kokila, serif;}
</style>

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
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
    <div id="codeBlock" style="top: 125px; position: fixed;">
        <span style= "color: oldlace; font-size: 18px">You will receive the code. Check Your email.</span>
    </div>

    <form method="post" style="width: 600px; height: 70px; position: fixed; top: 300px" action="code-from-email">
        <div id="inputBlock" style="top: 200px">Code from message</div>
        <div id="textBlock" style="top: 200px; position: fixed; left: 600px">
            <input type="text" name="code" id="code">
        </div>
        <button type="submit" class="input-submit-with-icon" style="width:230px; position: fixed; left: 600px; top: 250px">
            OK <span class="glyphicon glyphicon-ok" style="font-style: italic"></span>
        </button>
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
