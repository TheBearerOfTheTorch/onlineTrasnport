<%-- 
    Document   : admin
    Created on : 20 Apr 2021, 1:28:19 PM
    Author     : Iithindi Andreas P
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Car Rental System</title>
            <link rel="stylesheet" href="assets/css/bootstrap.min.css">
            <link rel="stylesheet" href="assets/css/bootstrap.css">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">   

        </head>
        <style>
            .form-group label {width: 40%;}
            .form-horizontal {width: 50%; margin: 20px auto; text-align: center; border: 1px solid red; border-radius: 30px; padding: 20px 0;}
            .form-group .form-control {width: 40%; display: inline-block;}
            h1 {color:purple;}
            h2 {color:white;}
            label {color:red;}
            input {margin-bottom: 20px;}
            body {text-align: center; background-image: url("background.jpg");}

            ul li{}
            ul li a {color:black;}
            ul li a:hover {color:black; font-weight:bold;}
            ul li {list-style:none;}
            ul li a:hover{text-decoration:none;}
            #social-fb,#social-tw,#social-gp,#social-em{color:blue;}
            #social-fb:hover{color:#4267B2;}
            #social-tw:hover{color:#1DA1F2;}
            #social-gp:hover{color:#D0463B;}
            #social-em:hover{color:#D0463B;}
        </style>
        <body>
                <a class="nav-link" href="UserLogout">
                    <ul class="navbar-nav ml-auto">
                        <button class="btn btn-outline-primary">logout</button>
                    </ul>
                </a>
            
            <label style="color:green">${success}</label>
                <br><br>
                <center>
                    <div class="container">
                    <div class="card">
                         <div class="card-header">
                             <label>VIEW BOOKED TICKETS</label>
                         </div>
                         <div class="card-body">
                             <table cellpadding="20px">
                                <th>CUSTOMER NAMES</th>
                                <th>DESTINATION</th>
                                <th>APPROVAL STATUS</th>
                                <th>EMAIL</th>
                                <th>TIME</th>
                                
                                    <%
                                        String url = "jdbc:derby://localhost:1527/pearlBookingTransport";
                                        String user ="pearl";
                                        String pass = "pearl";
                                        
                                        try
                                        {
                                            String requ = "SELECT * FROM BOOKS";
                                            Connection co = DriverManager.getConnection(url,user,pass);
                                            PreparedStatement ps = co.prepareStatement(requ);


                                            //dealing with the query
                                            ResultSet set = ps.executeQuery();

                                            while (set.next()) 
                                            {
                                                //getting the results from the database and storing them in variables for later use
                                                String firstname = set.getString("NAMES");
                                                String  middlename = set.getString("DESTINATION");
                                                String lastname = set.getString("APPROVAL");
                                                String phonenumber = set.getString("EMAIL");
                                                String email = set.getString("TIME");
                                                
                                                %>
                                 <tr>
                                    <td style="width:150px; color: yellowgreen"><% out.print(firstname);%></td>
                                    <td style="width:150px; color: yellowgreen"><% out.print(middlename);%></td>
                                    <td style="width:150px; color: yellowgreen"><% out.print(lastname);%></td>
                                    <td style="width:150px; color: yellowgreen"><% out.print(phonenumber);%></td>
                                    <td style="width:150px; color: yellowgreen"><% out.print(email);%></td>
                                    
                                </tr>
                                    <%
                                            }
                                            
                                        }
                                        catch (SQLException ex) {
                                            out.print(ex);
                                        }
                                        
                                    %>
                                </table>
                         </div>
                      </div>
                                <br>
                    <div class="card">
                         <div class="card-header">
                             <label>VIEW REGISTERED BUSES</label>
                         </div>
                         <div class="card-body">
                             <table cellpadding="20px">
                                <th>VEHICLE REG NUMBER</th>
                                <th>DRIVER NAMES</th>
                                <th>DESTINATION</th>
                                
                                    <%
                                      
                                        
                                        try
                                        {
                                            String requ = "SELECT * FROM BUSES";
                                            Connection co = DriverManager.getConnection(url,user,pass);
                                            PreparedStatement ps = co.prepareStatement(requ);


                                            //dealing with the query
                                            ResultSet set = ps.executeQuery();

                                            while (set.next()) 
                                            {
                                                //getting the results from the database and storing them in variables for later use
                                                String regNumber = set.getString("REGNUMBER");
                                                String  driverName = set.getString("DRIVERNAME");
                                                String route = set.getString("ROUTE");
                                                
                                                %>
                                 <tr>
                                    <td style="width:150px; color: yellowgreen"><% out.print(regNumber);%></td>
                                    <td style="width:150px; color: yellowgreen"><% out.print(driverName);%></td>
                                    <td style="width:150px; color: yellowgreen"><% out.print(route);%></td>
                                    
                                </tr>
                                    <%
                                            }
                                            
                                        }
                                        catch (SQLException ex) {
                                            out.print(ex);
                                        }
                                        
                                    %>
                                </table>
                         </div>
                      </div>
                </div>
                </center>
                <br><br>
                <div class="container ">
                    <div class="row">
                        <!--BOOK TICKET-->
                        <div class="modal-content" style="width:30%; float:right;">
                            <center>
                                <div class="modal-header">
                                <h4 class="modal-title text-center" style="width: 80%;">BOOK TICKET</h4>
                            </div>
                            <div class="modal-body" style="width:70%">
                                <form role="form" action="Admin" method="post">
                                    <input type="text" class="form-control" id="food_name" value="" placeholder="ENTER YOUR FULL NAMES" name="names" required>
                                    <input type="email" class="form-control" id="food_name" value="" placeholder="ENTER EMAIL" name="idNumber" required>
                                    <input type="text" class="form-control" id="food_name" value="" placeholder="ENTER DESTINATION" name="destination" required>
                                    <button type="submit" name="adminButton" value="booking" class="btn btn-danger">book</button>
                                </form>
                            </div>
                            </center>
                        </div>
                        
                        <!--REGISTER TICKET HERE-->
                        <div class="modal-content" style="width:30%; float: right; margin-right: 60px;">
                            <center>
                                <div class="modal-header">
                                <h4 class="modal-title text-center" style="width: 80%;">REGISTER TICKETS</h4>
                            </div>
                            <div class="modal-body" style="width:70%">
                                <form role="form" action="Admin" method="post">
                                    <input type="text" class="form-control" id="food_name" value="" placeholder="ENTER TO AND FROM" name="destination" required>
                                    <input type="number" class="form-control" id="food_name" value="" placeholder="ENTER TICKET PRICE" name="price" required>
                                    <input type="time" class="form-control" id="food_name" value="" placeholder="ENTER DEPATCHER TIME" name="time" required>
                                    <button type="submit" name="adminButton" value="tickets" class="btn btn-danger">Create Ticket</button>
                                </form>
                            </div>
                            </center>
                        </div>
                        <!-- THIS IS FOR REGISTERING BUSES-->
                        <div class="modal-content" style="width:30%;">
                            <center>
                                <div class="modal-header">
                                    <h4 class="modal-title text-center" style="width: 80%;">REGISTER BUSES</h4>
                                </div>
                                <div class="modal-body" style="width:70%">
                                    <form role="form" action="Admin" method="post">
                                        <input type="text" class="form-control" id="food_name" name="regNumber" placeholder="ENTER REG NUMBER" required>
                                        <input type="text" class="form-control" id="food_name" name="driverName" placeholder="ENTER DRIVER NAME"required>
                                        <input type="text" class="form-control" id="food_name" name="destination" placeholder="ENTER DESTINATION" required>
                                        <button type="submit" name="adminButton" value="register" class="btn btn-danger">REGISTER BUSES</button>
                                    </form>
                                </div>
                            </center>
                        </div>
                        
                </div>
               </div>
                <center>
                    <div class="middle" style="margin-left:150px; padding:40px; width:50%;">
                    <!--tab heading-->
                    <ul class="nav nav-tabs nabbar_inverse" id="myTab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link" id="accountsettings-tab" data-toggle="tab" href="#accountsettings" role="tab" aria-controls="accountsettings" aria-selected="false">REMOVER TICKET</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="status-tab" data-toggle="tab" href="#status" role="tab" aria-controls="status" aria-selected="false">APPROVE TICKET</a>
                        </li>

                    </ul>
                    <br><br>
                    <span style="color:purple;"></span>

                    <!--tab 1 VIEW RENTAL REQUEST -->   
                    <div class="tab-content" id="myTabContent">
                          
                                
                     <!--start her-->
                     
                <!--tab 1 ends-->	   


                        <!--tab manage fleets starts-->
                        <div class="tab-pane fade" id="manageaccount" style="width:550px;margin-left:50px;" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="container">
                                <table bordercolor="#F0F0F0" cellpadding="20px">
                                    ADD NEW USERS
                                    <div class="card">
                                        <form  role="form" action="Admin" method="post"><br>
                                            <label style="color:red">${errorreg}</label>
                                            <div class="form-group">
                                                <label for="first">Name</label>
                                                <input type="text" class="form-control" name="firstname" placeholder="Enter first name?">
                                            </div>
                                            <div class="form-group">
                                                <label for="middle">Middle Name</label>
                                                <input type="text" class="form-control" name="middlename" placeholder="Enter middle name?">
                                            </div>
                                            <div class="form-group">
                                                <label for="last">Last Name</label>
                                                <input type="text" class="form-control" name="lastname" placeholder="Enter last name?">
                                            </div>
                                            <div class="form-group">
                                                <label for="phone">Phone Number</label>
                                                <input type="text" class="form-control" name="phonenumber" placeholder="Enter number?">
                                            </div>
                                            <div class="form-group">
                                                <label for="email">Email ID</label>
                                                <input type="email" class="form-control" name="email" placeholder=" email id?">
                                            </div>
                                            <div class="form-group">
                                                <label for="password">Password</label>
                                                <input type="password" class="form-control" name="password" placeholder=" password">
                                            </div>
                                            <div class="form-group">
                                                <label for="confirmpassword">Confirm Password</label>
                                                <input type="text" class="form-control" name="confirmpassword" placeholder="Re-type your password">
                                            </div><br>
                                            <button style="background-color:purple;color:white" type="submit" name="buttonManager" value="Register"><b>Register</b></button><br><br>
                                            <!--<button type="submit" class="btn btn-default newuser_btn"><b>Register</b></button><br><br>-->
                                        </form>
                                    </div>
                                </table>
                            </div>    	 
                        </div>
                        <div class="tab-pane fade" id="accountsettings" style="width:550px;margin-left:50px;" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="container">
                                <div class="card">
                                    <form action="Admin" method="post">
                                       <input type="email" class="form-control" placeholder="ENTER USER EMAIL" name="email" required>
                                       <br>
                                       <button class="btn btn-outline-success" 
                                       style="background-color: purple;color:white" type="submit" name="buttonManager" value="remove">Remove User</button>
                                    </form>
                                    <br>
                                </div>
                            </div>    	 
                        </div>
                                            
                        <div class="tab-pane fade" id="status" style="width:550px;margin-left:50px;" role="tabpanel" aria-labelledby="profile-tab">
                            <div class="container">
                                <div class="card">
                                    <button class="btn btn-outline-success" data-target="#modify" data-toggle="modal" 
                                                    style="background-color: purple;color:white" type="button">Approve ticket</button>
                                    <br>
                                </div>
                            </div>    	 
                        </div>
                    </div>
                </div>
                </center>
                <!-- a
                <!-- im here for approving ticket  -->
                <div class="modal fade" role="dialog" tabindex="-1" id="modify" style="margin-top: 70px;font-style:normal;">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title text-center" style="width: 100%;">Approve the user ticket</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                            </div>
                            <div class="modal-body">
                                <form action="Admin" method="post">
                                    <input type="email" class="form-control" id="food_name" value="" placeholder="ENTER THE USER EMAIL" name="email" required>
                                    <button type="submit" name="adminButton" value="approve" class="btn btn-danger">modify</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
             
                <!--the scripts for th project-->
            <script src="assets/js/bootstrap.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
        </body>
    </html>
