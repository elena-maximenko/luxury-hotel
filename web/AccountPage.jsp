<%@ page import="com.hotel.util.DBProxy" %>
<%@ page import="com.hotel.entity.Room" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel='stylesheet' type="text/css" href='ElementsStyle.css'>
</head>
<style type="text/css">
    #wrapper {margin-left: 10px; margin-right: 10px; margin-top: 10px; height: 600px}
    #dateBlock {font: 24px Kokila, serif;}
    #footer {font: 16px Kokila, serif;}
</style>
<link rel='stylesheet' type="text/css" href='../ElementsStyle.css'>

<!--<script>
    function getSortSelect() {
        document.getElementById("selectSort").style.display="block";
        return false;
    }

    function predicateBy(prop){
        return function(a,b){
            if( a[prop] > b[prop]){
                return 1;
            }else if( a[prop] < b[prop] ){
                return -1;
            }
            return 0;
        }
    }

    function compareBy(thing) {
        var r = $('#sortInputId').val();
        console.log(r);
        var arr = $.parseJSON(r);
        for(var i = 0; i < arr.length; i++){
            console.log(arr[i]);
        }
        arr.sort( predicateBy(thing) );
        for(var i = 0; i < arr.length; i++){
            console.log(arr[i]);
        }
        return r;//r.sort( predicateBy(thing) );
    }
</script>  -->

<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<%
    HttpSession ses = request.getSession(false);
    String token = (String)ses.getAttribute("userToken");
    String login = (String)ses.getAttribute("login");

    HttpSession httpSession = request.getSession(true);
    httpSession.setAttribute("userToken", token);
    httpSession.setAttribute("login", login);
    httpSession.setAttribute("isReservedEarlier", false);

    List<Room> rooms = (request.getAttribute("rooms")==null?DBProxy.getInstance().getRooms("RoomNumber", "ASC", false):(List<Room>)request.getAttribute("rooms"));
  /*  Hotel.getInstance().setRooms(DBProxy.getRooms());
    List<Room> rooms = Hotel.getInstance().getRooms();

    // pass from jsp to js-function
    JSONArray jsRooms = new JSONArray();

    JSONObject tmp;

    for (int i = 0; i < rooms.size(); i++) {
        tmp = new JSONObject();
        tmp.put("Number", rooms.get(i).getNumber());
        tmp.put("Price", rooms.get(i).getPrice());
        tmp.put("Capacity", rooms.get(i).getCapacity());
        tmp.put("Category", rooms.get(i).getCategory());
        tmp.put("State", rooms.get(i).getState());

        jsRooms.put(tmp);
    }
    //System.out.println(jsRooms);*/
%>
<script>
    function sortRooms() {
        var el = document.getElementById("selectSort");
        var selectedValue = el.options[el.selectedIndex].value;

        if(selectedValue === "Price"){
            document.getElementById("wrapper").style.backgroundColor  = "red";
            var arr = compareBy("Price");

            document.getElementById("sortInputId").value = arr;

           /* $('myForm').submit();

            /*$.ajax({
                type: "POST",
                url: "account",
                data: { 'param': arr }
            })*/
        }
    }
</script>
<div id="wrapper">
    <div id="functionBlock">
        <form method="post" action="luxury-hotel" style="position: fixed; right: 1193px">
            <input type="submit" value="Log out">
        </form>

        <form method="get" action="reserved-earlier">
            <button type="submit" style="position:fixed; top:127px; width:120px; height:50px; margin: auto; background-color: rebeccapurple; font: 20px MS Outlook, serif;
                                      font-weight: bold; color: oldlace; border-radius: 10px;  border: 2px solid;">
                <span>Reserved<br>earlier</span>
            </button>
        </form>

        <form method="post" action="account">
            <button style="position:fixed; top: 200px;width:120px; height: 45px; text-align: center; background-color: rebeccapurple; border: 2px solid oldlace; color: oldlace; font: 20px MS Outlook, serif; font-weight: bold; border-radius: 10px" onclick="return getSortSelect();">
                <span>Sort</span>
            </button>
            <script src="Scripts.js"></script>

            <p>
                <select name="selectSort" id="selectSort" onchange="this.form.submit();" class="select-role" style="position:fixed; top: 255px; display:none; width: 120px">
                    <option selected disabled>Sort by</option>
                    <option value="RoomNumber">Number</option>
                    <option value="Price">Price</option>
                    <option value="Capacity">Capacity</option>
                    <option value="Category">Category</option>
                    <option value="State">State</option>
                </select>
            </p>
        </form>

        <form method="post" action="account" class="glyphicon-form" style="position: fixed; top: 60px; left: 200px">
            <button type="submit" id="orderButton" class="button-submit-with-icon">
                <span class="glyphicon glyphicon-sort" style= "padding:7px; font-size: 27px; text-align: center; color: oldlace; border: solid 2px oldlace; background-color: rebeccapurple; border-radius: 30px; width: 45px; height: 45px"></span>
            </button>
        </form>
    </div>

    <div id="entityBlock">
        <table>
            <%for(int i = 0; i < rooms.size(); i++){
                DBProxy.getInstance().setRoomsState(rooms.get(i).getNumber(), "MoveInDate", "Occupied");
                DBProxy.getInstance().setRoomsState(rooms.get(i).getNumber(), "MoveOutDate", "Available");
            %>
            <tr>
                <td>
                    <div class="entity-info-div" style="padding:10px"><!--style="width: 500px; position: inherit; color: white; height: 183px; font-size: 16px; left: 400px;"> -->
                        <p><span>Number: <%=rooms.get(i).getNumber()%></span></p>
                        <p><span>Price: <%=rooms.get(i).getPrice()%>$</span></p>
                        <p><span>Category: <%=rooms.get(i).getCategory().getValue()%></span></p>
                        <p><span>Capacity: <%=rooms.get(i).getCapacity().getValue()%></span></p>
                        <p><span>State: <%=rooms.get(i).getState().getValue()%></span></p>
                    </div>
                </td>
                <td>
                    <%String id = "glyphicon-reserve-room-"+i;%>
                    <form method="get" action="reserve" class="glyphicon-form">
                        <button type="submit" class="button-submit-with-icon" id="<%=id%>">
                            <span class="glyphicon glyphicon-ok" style="padding: 10px; font-size: 22px; float: left; color: limegreen; background-color: white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                        <input type="hidden" value="<%=rooms.get(i).getNumber()%>" name="room">
                    </form>
                </td>
                <%if(rooms.get(i).getState().getValue().equals("Reserved")||rooms.get(i).getState().getValue().equals("Occupied")){%>
                <script>document.getElementById('<%=id%>').style.display='none';</script>
                <%}%>
                <td>
                    <form method="get" action="room-images" class="glyphicon-form" style="width: 100px">
                        <input type="hidden" value="<%=rooms.get(i).getNumber()%>" name="room">
                        <button type="submit" class="button-submit-with-icon">
                            <span class="glyphicon glyphicon-eye-open" style= "padding: 10px; text-align: center; color: rebeccapurple; background-color: white; border: 2px solid white; border-radius: 30px; width: 45px; height: 45px"></span>
                        </button>
                    </form>
                </td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
<div id="dateBlock"> <span id="clock">&nbsp;</span>
    <script src="../Scripts.js">
    </script>
</div>
</body>
</html>
