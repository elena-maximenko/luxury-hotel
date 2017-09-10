function updateClock() {
    var currentTime = new Date ( );
    var currentHours = currentTime.getHours ( );
    var currentMinutes = currentTime.getMinutes ( );
    var currentSeconds = currentTime.getSeconds ( );

    // Pad the minutes and seconds with leading zeros, if required
    currentMinutes = ( currentMinutes < 10 ? "0" : "" ) + currentMinutes;
    currentSeconds = ( currentSeconds < 10 ? "0" : "" ) + currentSeconds;

    // Choose either "AM" or "PM" as appropriate
    var timeOfDay = ( currentHours < 12 ) ? "AM" : "PM";

    // Convert the hours component to 12-hour format if needed
    currentHours = ( currentHours > 12 ) ? currentHours - 12 : currentHours;

    // Convert an hours component of "0" to "12"
    currentHours = ( currentHours == 0 ) ? 12 : currentHours;

    // Compose the string for display
    var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;

    // Update the time display
    document.getElementById("clock").firstChild.nodeValue = currentTimeString;
}

function show(id, text) {
    document.getElementById(id).style.visibility = 'visible';
    document.getElementById(id).innerHTML = text;
}

function getSortSelect() {
    document.getElementById("selectSort").style.display="block";
    return false;
}

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
        document.getElementById("uppercaseResetPassword").style.color = "rebeccapurple";
    }
    else {
        document.getElementById("uppercaseResetPassword").style.color = "white";
    }

    if(hasNumber(text)){
        document.getElementById("digitResetPassword").style.color = "rebeccapurple";
    }
    else {
        document.getElementById("digitResetPassword").style.color = "white";
    }

    if (text.length >= 7) {
        document.getElementById("eightCharsResetPassword").style.color = "rebeccapurple";
    }
    else {
        document.getElementById("eightCharsResetPassword").style.color = "white";
    }
}
