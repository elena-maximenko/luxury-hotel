<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add new room</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>
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
        <form>
            <p>Number</p>
            <p>Category</p>
            <p>Price</p>
            <p>Capacity</p>
            <p>Images</p>
        </form>
    </div>

    <div class="text-block">
        <form method="post" action="add-room" enctype='multipart/form-data'>
           <p><input type="text" name="room"></p>
            <p><select name="selectCategory" class="select-role">
                <option selected disabled>Choose category</option>
                <option>Junior Suite</option>
                <option>De Luxe</option>
                <option>Suite</option>
                <option>Business Room</option>
                <option>Family Studio</option>
                <option>King Suite</option>
                <option>President Suite</option>
            </select></p>
            <p><input type="text" name="roomPrice"></p>
            <p><select name="selectCapacity" class="select-role">
                <option selected disabled>Choose capacity</option>
                <option>Single</option>
                <option>Double</option>
                <option>Twin</option>
                <option>Triple</option>
                <option>Extra bed</option>
                <option>Quadriple</option>
                <option>Child</option>
            </select></p>
            <p><input name="roomImages" accept="image/jpeg,image/gif,image/png" type="file" id="file" multiple data-multiple-caption="{count} files selected" class="input-file"></p>
            <p><label for="file"><span class="glyphicon glyphicon-download-alt" style=" cursor: hand; padding:7px; font-size: 18px; text-align: center; color:white; background-color: rebeccapurple; border: 2px solid white; border-radius: 10px; width: 125px; height: 55px">
                Choose the files</span></label></p>

            <!--<input type="submit" value="OK"> -->
            <button type="submit" class="input-submit-with-icon" style="width:230px; position: fixed; left: 600px; top: 250px">
                OK <span class="glyphicon glyphicon-ok" style="font-style: italic"></span>
            </button>
        </form>
    </div>
    <div id="errorBlock" style="position: fixed; top:400px; height: 100px; width: 400px">
        <%String selectedFiles = "";
        String error = "";
        String message = "";
        if(request.getAttribute("selectedFiles") != null){
            selectedFiles = (String)request.getAttribute("selectedFiles");
        }
        if(request.getAttribute("error") != null){
            error = (String)request.getAttribute("error");
        }
        if(request.getAttribute("message") != null){
        message = (String)request.getAttribute("message");%>
        <script>
            document.getElementById("errorBlock").style.color = "aliceblue";
        </script><%
        }
        %>
        <p><span><%=selectedFiles%></span></p>
        <p><span><%=error%></span></p>
        <p><span><%=message%></span></p>
    </div>
    <%
        HttpSession ses = request.getSession(false);
        String token = (String)ses.getAttribute("token");

        HttpSession httpSession = request.getSession(true);
        httpSession.setAttribute("token", token);
    %>
    <form style="position:fixed; top: 500px; right: 75px; width: 250px" method="get" action="all-rooms?">
        <button class="button-submit-with-icon" style="cursor:hand; width: 250px; height: 30px" type="submit">
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
