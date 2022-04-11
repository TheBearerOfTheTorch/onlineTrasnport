<%-- 
    Document   : index
    Created on : 20 Apr 2021, 12:59:27 PM
    Author     : Iithindi Andreas P
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book transport online</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>
        <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>-->
        <style>
            .form-group label {width: 200px;}
            .form-horizontal {width: 50%; margin: 20px auto; text-align: center; border: 1px solid purple; border-radius: 30px; padding: 20px 0;}
            .form-group .form-control {width: auto; display: inline-block;}
            p {color:red; font-size:200%;}
            h1 {color:black;}
            h2 {color:black;}
            label {color:black;}
            body {text-align: center;
                  
            }
        </style>
    </head>
    <body>
        <h1><b> Online Transport Booking System</b></h1><br>
        <div class="container" >
            <h2><b>Login here</b></h2>
        
            <label style="color:red"><b>${unknownError}</b></label>
            <div class="container">
                <div class="card">
                    <form  role="form" action="UserInputData" method="post"><br>
                    <label style="color:red">${error}</label>
                    <div class="form-group">
                        <label for="useremail">Email ID</label>
                        <input type="email" class="form-control" name="useremail" placeholder="Enter your Email ID ">
                    </div>
                    <div class="form-group">
                        <label for="userpassword">Password</label>
                        <input type="password" class="form-control" name="password" placeholder="Enter Password ">
                    </div><br>
                    <button class="btn btn-primary" style="background-color:blue;color:white;" type="submit" name="button" value="Login"><b>Log In</b></button><br><br>
                    <!--<button type="submit" class="btn btn-default user_btn"><b>Log In</b></button><br><br>-->
                </form>
                </div>
            </div><br>
        
            <h2><b>Register here</b></h2>
            <div class="card" style="">
                <form class="card" role="form" action="UserInputData" method="post"><br>
                <label style="color:red">${errorreg}</label>
                <div class="form-group">
                    <label for="first">Name</label>
                    <input type="text" class="form-control" name="firstname" placeholder="firstname?">
                </div>
                <div class="form-group">
                    <label for="middle">Middle Name</label>
                    <input type="text" class="form-control" name="middlename" placeholder="middlename?">
                </div>
                <div class="form-group">
                    <label for="last">Last Name</label>
                    <input type="text" class="form-control" name="lastname" placeholder="lastname?">
                </div>
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" class="form-control" name="phonenumber" placeholder="phone number?">
                </div>
                <div class="form-group">
                    <label for="email">Email ID</label>
                    <input type="email" class="form-control" name="email" placeholder="email id?">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" name="password" placeholder="Enter password">
                </div>
                <div class="form-group">
                    <label for="confirmpassword">Confirm Password</label>
                    <input type="text" class="form-control" name="confirmpassword" placeholder="Re-type your password">
                </div><br>
                <button class="btn btn-warning" style="background-color:orange;color:white" type="submit" name="button" value="Register"><b>Register</b></button><br><br>
                <!--<button type="submit" class="btn btn-default newuser_btn"><b>Register</b></button><br><br>-->
            </form>
            </div>
                
        </div><br>
        
        <script src="assets/js/bootstrap.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>
