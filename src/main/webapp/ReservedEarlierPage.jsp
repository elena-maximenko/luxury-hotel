<%@ page import="com.hotel.entity.Room" %>
<%@ page import="com.hotel.entity.Hotel" %>
<%@ page import="com.hotel.util.DBProxy" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reserved earlier rooms</title>
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

<%
    HttpSession ses = request.getSession(false);
    String token = (String)ses.getAttribute("userToken");
    String login = (String)ses.getAttribute("login");

    HttpSession httpSession = request.getSession(true);
    httpSession.setAttribute("userToken", token);
    httpSession.setAttribute("login", login);
    httpSession.setAttribute("isReservedEarlier", true);

    List<Room> reserved = (request.getAttribute("rooms") == null)?DBProxy.getInstance().getReservedByLogin(login):(List<Room>)request.getAttribute("rooms");

    Set<Room> set = new LinkedHashSet<>(reserved);/*new TreeSet<>/*(new Comparator<Room>(){
        public int compare(Room r1, Room r2) {
            if(r1.getNumber()> r2.getNumber()){
                return 1;
            }
            else if(r1.getNumber() < r2.getNumber()){
                return -1;
            }
            else return  0;
        }
    });*/

    //set.addAll(reserved); // eliminate duplicates
%>
<body onload="updateClock(); setInterval('updateClock()', 1000 )">
<div id="wrapper">
    <div id="functionBlock">
        <form method="post" action="luxury-hotel">
            <input type="submit" value="Log out">
        </form>
        <form style="top: 500px; position: fixed; left: 1px; width: 250px" method="get" action="account">
            <button class="button-submit-with-icon" style="cursor: hand; width: 300px; height: 30px" type="submit">
                <span style="font: bolder 20px Constantia, serif; color: white; text-decoration: underline">Back to the account</span>
            </button>
        </form>

        <form method="post" action="reserved-earlier">
            <button style="position:fixed; top: 130px; left: 87px; width:120px; height: 45px; text-align: center; background-color: rebeccapurple; border: 2px solid oldlace; color: oldlace; font: 20px MS Outlook, serif; font-weight: bold; border-radius: 10px" onclick="return getSortSelect();">
                <span>Sort</span>
            </button>
            <script src="Scripts.js"></script>

            <p>
                <select name="selectSort" id="selectSort" onchange="this.form.submit();" class="select-role" style="left:87px; position:fixed; top: 185px; display:none; width: 120px">
                    <option selected disabled>Sort by</option>
                    <option value="RoomNumber">Number</option>
                    <option value="Price">Price</option>
                    <option value="Capacity">Capacity</option>
                    <option value="Category">Category</option>
                    <option value="State">State</option>
                    <option value="MoveInDate">Move in date</option>
                    <option value="MoveOutDate">Move out date</option>
                </select>
            </p>
        </form>

        <form method="post" action="reserved-earlier" class="glyphicon-form" style="position: fixed; top: 60px; left: 200px">
            <button type="submit" id="orderButton" class="button-submit-with-icon">
                <span class="glyphicon glyphicon-sort" style= "position: fixed; top:63px; left: 260px; padding:7px; font-size: 27px; text-align: center; color: oldlace; border: solid 2px oldlace; background-color: rebeccapurple; border-radius: 30px; width: 45px; height: 45px"></span>
            </button>
        </form>
    </div>

    <div id="entityBlock" style="overflow: auto">
        <table>
            <%for(Room r: set){
                DBProxy.getInstance().setRoomsState(r.getNumber(), "MoveInDate", "Occupied");
                DBProxy.getInstance().setRoomsState(r.getNumber(), "MoveOutDate", "Available");
            %>
            <tr>
                <td>
                    <%List<Integer>jIds = DBProxy.getInstance().getJournalId(r.getNumber(), login);
                      int x = jIds.size();
                      for (Integer jId: jIds){
                          if(!DBProxy.getInstance().getDate(jId, "MoveOutDate").before(DBProxy.getInstance().getCurrentDate()) ||
                                  (!DBProxy.getInstance().getDate(jId, "MoveOutDate").after(DBProxy.getInstance().getCurrentDate())&&
                                          DBProxy.getInstance().getCurrentTime().before(DBProxy.getInstance().getExpireTime()))) {
                              x-- ;
                          }
                      }

                      int height = 230 + x*20;
                    %>
                    <!-- dynamically determine block size -->
                    <div class="entity-info-div" style="padding:10px; height: <%=height%>px"><!--style="width: 500px; position: inherit; color: white; height: 183px; font-size: 16px; left: 400px;"> -->
                        <p><span>Number: <%=r.getNumber()%></span></p>
                        <p><span>Price: <%=r.getPrice()%>$</span></p>
                        <p><span>Category: <%=r.getCategory().getValue()%></span></p>
                        <p><span>Capacity: <%=r.getCapacity().getValue()%></span></p>
                        <p><span>State: <%=r.getState().getValue()%></span></p>
                        <br>

                        <!-- the same user could reserve the same room few times! drug from Journal table by Id -->
                        <%for (Integer jId: jIds/*DBProxy.getInstance().getJournalId(r.getNumber(), login)*/) {
                            if(DBProxy.getInstance().getDate(jId, "MoveOutDate").before(DBProxy.getInstance().getCurrentDate()) ||
                            (!DBProxy.getInstance().getDate(jId, "MoveOutDate").after(DBProxy.getInstance().getCurrentDate())&&
                             DBProxy.getInstance().getCurrentTime().after(DBProxy.getInstance().getExpireTime()))){%>
                        <p style="font: bolder 20px Kokila, serif"> Reserved from <%=DBProxy.getInstance().getDate(jId, "MoveInDate").toString()%>
                            to <%=DBProxy.getInstance().getDate(jId, "MoveOutDate").toString()%></p>
                        <%}
                        }%>
                    </div>
                </td>
                <td>
                    <form method="get" action="room-images" class="glyphicon-form" style="width: 100px">
                        <input type="hidden" value="<%=r.getNumber()%>" name="room">
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
<div id="footer">Created by Elena Maximenko</div>
</div>
</body>
</html>
