<%-- 
    Document   : user
    Created on : 20 Apr 2021, 7:23:41 PM
    Author     : Iithindi Andreas P
--%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%
    String url = "jdbc:derby://localhost:1527/pearlBookingTransport";
    String user = "pearl";
    String pass = "pearl";
    String lookup = (String) session.getAttribute("authUser");
    //int id = (int) session.getAttribute("authIdNumber");

    if (!lookup.isEmpty()) {
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>USER PAGE</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.css">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">   

        <style>
            .form-group label {width: 40%;}
            .form-horizontal {width: 50%; margin: 20px auto; text-align: center; border: 1px solid purple; border-radius: 30px; padding: 20px 0;}
            .form-group .form-control {width: 40%; display: inline-block;}
            p {color:red; font-size:200%;}
            h1 {color:green;}
            h2 {color:black;}
            body {text-align: center; background-image: url("background.jpg");}
            #nav{
                width: 30px;
            }
        </style></head>
    <body>
        <a style="float:left" class="btn btn-outline-success" href="UserLogout">Logout</a>
        <div >
            <div class="container" style="color:purple;text-align: center;">
                <h1 style="color:green;">
                    <b>
                        <label>${cartype}</label>
                        <label style="color:green">${created}</label>
                        <a id="director_rejobs_link" href="#" data-target="#order" data-toggle="modal" style="margin-left:10px; font-size: 30px;color:yellowgreen">
                            ${request}
                        </a>
                    </b>
                </h1>

                <label style="color:red">${error}</label>
                <h2>
                    <b>CHECK IF A BUS IS AVAILABLE</b>
                </h2>
            </div>
            <br>
            <!--this will show after booking-->
            <%
                String approve = "SELECT * FROM BOOKS WHERE EMAIL=?";
                try {
                    Connection conn = DriverManager.getConnection(url, user, pass);
                    PreparedStatement pst = conn.prepareStatement(approve);
                    pst.setString(1, lookup);

                    ResultSet set = pst.executeQuery();

                    while (set.next()) {
                        boolean approv = set.getBoolean("APPROVAL");
                        String name = set.getString("NAMES");
                        String destination = set.getString("DESTINATION");
                        String email = set.getString("EMAIL");
                        String time = set.getString("TIME");
                        String price = set.getString("PRICE");
                        if (approv) {
                            //checking if the booking is sone
            %>

            <center>
                <label style="color: green">Your ticket is ready</label>
                <div class="modal-content" style="width:20%;background-color: orange">
                    <div class="modal-header">
                        <h4 class="modal-title text-center" style="width: 100%;">TICKET <% out.print(time);%></h4>
                    </div>

                    <div class="modal-body">
                        <label for="pickupdate">Passenger : <% out.print(name);%></label>
                        <label for="pickupdate">Destination : <% out.print(destination);%></label>
                        <label for="pickupdate">Email : <% out.print(email);%></label>
                        <label for="pickupdate">Bus leaves at : <% out.print(time);%></label>
                        <label for="pickupdate">Ticket price: P<% out.print(price);%></label>
                    </div>
                </div>
            </center>   
            <%

            } else {
            %>

            <center>
                <label style="color: green">You ticket is not approved yet</label>
                <div class="modal-content" style="width:20%;background-color: orange">

                </div>
            </center>   
            <%
                        }

                    }
                } catch (SQLException ex) {
                    out.print(ex);
                }


            %>
            <br>
            <center>
                <div class="modal-content" style="width:30%;">
                    <form class="card-body" role="form" action="LookUp" method="post"><br>
                        <div class="form-group">
                            <label for="pickupdate">Enter time:</label>
                            <input type="TIME" class="form-control" name="time">
                        </div>
                        <div class="form-group">
                            <label for="pickupdate">Enter destination:</label>
                            <input type="text" class="form-control" name="destination" required="">
                        </div>
                        <button class="btn btn-info" name="button" value="Lookup" type="submit"><b>Look Up</b></button><br><br>
                    </form>       
                </div>
            </center>               
            <br>
        </div><br>

        <!--checking if you have checked for buses-->
        <%                String book = "SELECT * FROM CHECKUP WHERE EMAIL=?";
            String checkBooked = "SELECT * FROM BOOKS WHERE EMAIL=?";
            try {
                Connection conn = DriverManager.getConnection(url, user, pass);
                PreparedStatement pst = conn.prepareStatement(book);
                pst.setString(1, lookup);

                ResultSet set = pst.executeQuery();

                while (set.next()) {
                    boolean approv = set.getBoolean("CHECKED");

                    if (approv) {
                        //checking if the booking is sone
        %>

    <center>
        <label style="color: green">lOOKUP WAS SUCCESS YOU CAN BOOK NOW</label>
        <div class="modal-content" style="width:50%;background-color: orange">
            <form class="card-body" role="form" action="LookUp" method="post"><br>
                <div class="form-group">
                    <label for="pickupdate">Enter Full names:</label>
                    <input type="text" class="form-control" name="names">
                </div>
                <div class="form-group">
                    <label for="pickupdate">Enter email address:</label>
                    <input type="email" class="form-control" name="idNumber" required="">
                </div>
                <div class="form-group">
                    <label for="pickupdate">Enter destination:</label>
                    <input type="text" class="form-control" name="destination" required="">
                </div>
                <button class="btn btn-success" name="button" value="book" type="submit"><b>Book Now</b></button><br><br>
            </form>       
        </div>
    </center>   
    <%
                }

            }
        } catch (SQLException ex) {
            out.print(ex);
        }


    %>






    <!-- request -->

    <div class="modal fade" role="dialog" tabindex="-1" id="order_list" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center" style="width: 100%;">BOOK FOR THE AVAILABLE VEHICLE</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span></button>
                    </div>

                    <div class="modal-body">
                        <form action="REQUEST" method="post">
                            <input type="text" class="form-control" id="food_name" value="" placeholder="Enter email" name="email" required><br>
                            <input type="text" class="form-control" id="food_name" value="" placeholder="Enter vehicletype" name="type" required><br>
                            <input type="number" class="form-control" id="food_name" value="" placeholder="Enter period" name="period" required><br>
                            <input type="date" class="form-control" id="food_name" value="" placeholder="Enter Book date" name="book" required><br>
                            <input type="date" class="form-control" id="food_name" value="" placeholder="Enter pick up date" name="pick" required>
                            <button type="submit" value="requesting_vehicle" name="button" class="btn btn-danger">Book</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- checking progress -->
    <div class="modal fade" role="dialog" tabindex="-1" id="order" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center" style="width: 100%;">Checking for request progress</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span></button>
                    </div>

                    <div class="modal-body">
                        <%                                String sql = "SELECT * FROM REQUEST WHERE EMAIL=?";
                            try {
                                Connection conn = DriverManager.getConnection(url, user, pass);
                                PreparedStatement pst = conn.prepareStatement(sql);
                                pst.setString(1, lookup);

                                ResultSet set = pst.executeQuery();

                                while (set.next()) {
                                    String fees = set.getString("FEE");
                                    String pick = set.getString("BOOKDATE");
                                    String approv = set.getString("APPROVED");
                                    String period = set.getString("PERIOD");

                                    if (approv.equals("false")) {
                        %>
                        <button style="background-color:red;color:white" type="submit"><b><%out.print(pick + " not approved");%></b></button>

                        <%

                            } else {%>
                        <a id="director_rejobs_link" href="#" data-target="#approved" data-toggle="modal" style="margin-left:10px; font-size: 30px">
                            <button style="background-color:blue;color:white" type="submit"><b><%out.print(pick + " approved");%></b></button>
                        </a>


                        <%
                                    }

                                }
                            } catch (SQLException ex) {
                                out.print(ex);
                            }


                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--                  approved booking    -->
    <div class="modal fade" role="dialog" tabindex="-1" id="approved" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title text-center" style="width: 100%;">Proceed to payment</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span></button>
                    </div>

                    <div class="modal-body">
                        <form action="REQUEST" method="post">
                            <input type="checkbox" class="form-control" id="food_name" value="fsfsfsafasdf" placeholder="Enter pick up date" name="pick" required>
                            <button type="submit" name="book" class="btn btn-danger">Pay </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="assets/js/bootstrap.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
</body>
</html>
<%    } else {
        request.setAttribute("errorreg", "You are not authorised to login here please");
        response.sendRedirect("index.jsp");
    }
%>