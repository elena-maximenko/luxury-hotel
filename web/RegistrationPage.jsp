<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration</title>
    <script type="text/javascript" src="../Scripts.js"></script>
    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>

    <!--  <script type="text/javascript">
          function hasNumber(myString) {
              return /\d/.test(myString);
          }

          function showPasswordInfo() {
              var containsUpper = false;
              document.getElementById("passwordInfoBlock").style.display = "block";
              var textValue = document.getElementById("password").value;

              for(var i = 0; i < textValue.length; i++){
                  if (textValue.charAt(i) == textValue.charAt(i).toUpperCase()
                      && textValue.charAt(i) != textValue.charAt(i).toLowerCase()) {
                      console.log('uppercase:',textValue.charAt(i));
                      containsUpper = true;
                  }
              }

              if(containsUpper){
                  document.getElementById("uppercase").style.display = "block";
              }
              else{
                  document.getElementById("uppercase").style.display = "none";
              }

              if(hasNumber(textValue)){
                  document.getElementById("digit").style.display = "block";
              }
              else {
                  document.getElementById("digit").style.display = "none";
              }

              if (textValue.length >= 7) {
                  document.getElementById("eightChars").style.display = "block";
              }
              else {
                  document.getElementById("eightChars").style.display = "none";
              }
          }
      </script> -->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
    </script>
    <script >
        $(document).ready(function() {
            $('#password').bind('cut copy paste ',function(e) {
                e.preventDefault(); //disable cut,copy,paste
                alert('Cut, copy and paste of password are disabled');
            });
            $('#confirmedPassword').bind('copy paste cut',function(e) {
                e.preventDefault(); //disable cut,copy,paste
                alert('Cut, copy and paste of password are disabled.');
            });
        });
    </script>

    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />

</head>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
    <div id="passwordInfoBlock" style="display: none;">
        <span>Password must consist of at least
           <br>8 characters.
           <br>Also at least one uppercase letter
            <br>and one digit are required</span>
        <label id="eightChars" class="passwordInfoLabel" style="font: bold 16px Constantia, serif;display: none">8 characters</label>
        <label id="uppercase" class="passwordInfoLabel" style="font: bold 16px Constantia, serif; display: none">1 uppercase letter</label>
        <label id="digit" class="passwordInfoLabel" style="font: bold 16px Constantia, serif; display: none">1 digit</label>
    </div>
    <div class="input-block">
        <form>
            <p> First name </p>
            <p> Last name </p>
            <p> Login </p>
            <p> Password </p>
            <p> Confirm your password </p>
        </form>
    </div>
    <div class="text-block">

        <form method="post" action="registration">
            <p><input type="text" name="firstName" placeholder="Ivan">  </p>
            <p><input type="text" name="lastName" id="textBoxLastName" placeholder="Ivanov"></p>
            <p><input type="text" name="login" placeholder="ivan.ivanov@gmail.com"></p>
            <p><input type="password" name="password" id="password" onkeypress="showPasswordInfo()"></p>
            <script src="../Scripts.js">
            </script>
            <p><input type="password" name="confirmedPassword" id="confirmedPassword"></p>
                <input type="submit" value="OK" name="buttonOk">
        </form>

    </div>
    <div id="errorBlock" style="position: fixed; top: 440px; height: 100px; width: 600px; font-size: 16px">
        <% String errors;
        if(request.getAttribute("message") != null) {
            errors = (String) request.getAttribute("message");
                %><span><p><%=errors%></p></span><%
        }
    %>
    </div>
</div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
<div id="footer">Created by Elena Maximenko</div>
</body>
</html>
