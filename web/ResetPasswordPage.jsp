<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ResetPassword</title>

    <!--    <script type="text/javascript">
            function hasNumber(myString) {
                return /\d/.test(myString);
            }

            function showResetPasswordInfo() {
                var containsUpper = false;
                document.getElementById("passwordInfoBlock").style.display = "block";
                var text = document.getElementById("resetPasswordId").value;

                for(var i = 0; i < text.length; i++){
                    if (text.charAt(i) == text.charAt(i).toUpperCase()
                        && text.charAt(i) != text.charAt(i).toLowerCase()) {
                        console.log('uppercase:',text.charAt(i));
                        containsUpper = true;
                    }
                }

                if(containsUpper){
                    document.getElementById("uppercaseResetPassword").style.color = "lightgreen";
                }
                else {
                    document.getElementById("uppercaseResetPassword").style.color = "white";
                }

                if(hasNumber(text)){
                    document.getElementById("digitResetPassword").style.color = "lightgreen";
                }
                else {
                    document.getElementById("digitResetPassword").style.color = "white";
                }

                if (text.length >= 7) {
                    document.getElementById("eightCharsResetPassword").style.color = "lightgreen";
                }
                else {
                    document.getElementById("eightCharsResetPassword").style.color = "white";
                }
            }
        </script> -->

    <link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
    </script>
    <script >
        $(document).ready(function() {
            $('#resetPasswordId').bind('cut copy paste ',function(e) {
                e.preventDefault(); //disable cut,copy,paste
                alert('Cut, copy and paste of password are disabled');
            });
            $('#confirmedResetPasswordId').bind('copy paste cut',function(e) {
                e.preventDefault(); //disable cut,copy,paste
                alert('Cut, copy and paste of password are disabled.');
            });
        });
    </script>
    <link rel="shortcut icon" type='image/x-icon' href="../titlePic.ico" />
</head>

<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<%String login = "";
HttpSession httpSession = request.getSession(false);
    System.out.println("httpSession attribute = " + httpSession.getAttribute("login"));

    if(httpSession.getAttribute("login")!= null){
    login = (String)httpSession.getAttribute("login");
}
%>
<div id="wrapper">
    <div id="passwordInfoBlock" style="display: none;">
        Password must consist of
        <br>at least 8 characters.
        <br>Also at least one uppercase letter
        <br> and one digit are required.
        <label id="eightCharsResetPassword" class="password-info-label" style="font: bold 16px Constantia, serif;display: block">8 characters</label>
        <label id="uppercaseResetPassword" class="password-info-label" style="font: bold 16px Constantia, serif;display: block">1 uppercase letter</label>
        <label id="digitResetPassword" class="password-info-label" style="font: bold 16px Constantia, serif;display: block">1 digit</label>
    </div>
    <div id="resetPasswordBlock">
        <label style="font: bold 18px Constantia, serif; color: rebeccapurple">Reset password</label>
    </div>
    <div id="inputBlock">
        <form>
            <p>Password</p>
            <p>Confirm password</p>
        </form>
    </div>
    <form method="post" action="reset-password">
        <div class="text-block">
            <p><input type="password" id="resetPasswordId" name="resetPassword" onkeypress="showResetPasswordInfo()"></p>
            <script src="../Scripts.js">
            </script>
            <p><input type="password" id="confirmedResetPasswordId" name="confirmedResetPassword"></p>
            <input type="submit" value="Reset">

        </div>
      <!--  <div id="buttonResetPasswordBlock">
        </div> -->
    </form>

    <div id="errorBlock" style="height: 50px">
        <% String [] errors;
            if(request.getAttribute("message") != null) {
                errors = (String[]) request.getAttribute("message");
                for (String error: errors){
        %><span><p><%=error%></p></span><%
            }
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
