/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Iithindi Andreas P
 */
@WebServlet(urlPatterns = {"/Admin"})
public class Admin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession();
            
            //gettign the pressed button
            String button = request.getParameter("adminButton");
            
            String url = "jdbc:derby://localhost:1527/pearlBookingTransport";
            String user ="pearl";
            String pass = "pearl";
            
                                        
           switch(button){
               case "register":{
                   
                   try{
                        String regNumber = request.getParameter("regNumber");
                        String driverName = request.getParameter("driverName");
                        String route = request.getParameter("destination");
                        
                       if(regNumber.isEmpty())
                        {
                            request.setAttribute("errorreg", "The reg number field is empty");
                            request.getRequestDispatcher("admin.jsp")
                                    .forward(request, response);
                        }
                        else if(driverName.isEmpty())
                        {
                            request.setAttribute("errorreg", "The driver name field is empty");
                            request.getRequestDispatcher("admin.jsp")
                                    .forward(request, response);
                        }
                        else if(route.isEmpty())
                        {
                            request.setAttribute("errorreg", "The lastname field is empty");
                            request.getRequestDispatcher("admin.jsp")
                                    .forward(request, response);
                        }
                        else
                        {
                             //sending the user data to the model to check with the database
                                String sql="INSERT INTO BUSES(REGNUMBER,DRIVERNAME,ROUTE) VALUES(?,?,?)";
                                Connection conn = DriverManager.getConnection(url,user,pass);
                                PreparedStatement ps= conn.prepareStatement(sql);

                                ps.setString(1,regNumber);
                                ps.setString(2,driverName);
                                ps.setString(3,route);

                                int check = ps.executeUpdate();
                                if(check>0)
                                {
                                    request.setAttribute("success", "Bus registered successfully");
                                        request.getRequestDispatcher("admin.jsp")
                                                .forward(request, response);
                                }
                                
                                request.setAttribute("error", "That bus reg number already exist in our record");
                                request.getRequestDispatcher("admin.jsp")
                                            .forward(request, response);

                        }
                   }catch(SQLException ex) 
                   {
                        out.print(ex);
                   }
                   break;
               }
               case "booking":{
                   
                   try{
                        String names = request.getParameter("names");
                        String idNumber = request.getParameter("idNumber");
                        String destination = request.getParameter("destination");
                        
                       String sql="INSERT INTO BOOKS(NAMES,DESTINATION,APPROVAL,EMAIL,TIME,PRICE) VALUES(?,?,?,?,?,?)";
                       String checking="SELECT * FROM TICKETS WHERE DESTINATION=?";
                       
                       //checking if the buses going to destination is 
                       Connection co = DriverManager.getConnection(url,user,pass);
                       PreparedStatement ps = co.prepareStatement(checking);
                       ps.setString(1, destination);
                       
                       ResultSet rs= ps.executeQuery();
                       while(rs.next()){
                           String price = rs.getString("price");
                           String time = rs.getString("TIME");
                           
                        Connection coon = DriverManager.getConnection(url,user,pass);
                        PreparedStatement pst = coon.prepareStatement(sql);
                        pst.setString(1, names);
                        pst.setString(2,destination);
                        pst.setBoolean(3,false);
                        pst.setString(4,idNumber);
                        pst.setString(5,time);
                        pst.setString(6,price);

                        int v = pst.executeUpdate();
                        if(v>0){
                            request.setAttribute("success", "You have successfully booked");
                            request.getRequestDispatcher("admin.jsp")
                                        .forward(request, response);
                        }
                        request.setAttribute("error", "Failes to book for the ticket");
                           request.getRequestDispatcher("admin.jsp")
                                       .forward(request, response);
                       }
                       
                       request.setAttribute("error", "The ticket to your destinatons are currently not available");
                           request.getRequestDispatcher("admin.jsp")
                                       .forward(request, response);
                   }catch(SQLException ex) 
                   {
                        out.print(ex);
                   }
                   break;
               }
               case "tickets":{
                   
                   try{
                        String destination = request.getParameter("destination");
                        String price = request.getParameter("price");
                        String time = request.getParameter("time");
                       //String sql="UPDATE USERS SET PHONENUMBER='"+idd+"' WHERE EMAIL=?";
                       String sql= "INSERT INTO TICKETS(DESTINATION,PRICE,TIME) VALUES(?,?,?)";
                       Connection co = DriverManager.getConnection(url,user,pass);
                       PreparedStatement pst = co.prepareStatement(sql);
                       
                       pst.setString(1,destination);
                       pst.setString(2,price);
                       pst.setString(3,time);
                       
                       int v = pst.executeUpdate();
                       if(v>0){
                           request.setAttribute("success", "The ticket was created successfully");
                           request.getRequestDispatcher("admin.jsp")
                                       .forward(request, response);
                       }
                       request.setAttribute("error", "Unkown error while creating the ticket");
                           request.getRequestDispatcher("admin.jsp")
                                       .forward(request, response);
                       
                   }catch(SQLException ex) 
                   {
                        out.print(ex);
                   }
                   break;
               }
               case "approve":{
                   
                   try{
                        String email = request.getParameter("email");
                        boolean approve = true;
                       String sql="UPDATE BOOKS SET APPROVAL='"+approve+"' WHERE EMAIL=?";
                       Connection co = DriverManager.getConnection(url,user,pass);
                       
                       //checking if this email exists
                       String check = "SELECT * FROM BOOKS WHERE EMAIL=?";
                       PreparedStatement ps = co.prepareStatement(check);
                       ps.setString(1, check);
                       ResultSet rs= ps.executeQuery();
                       while(rs.next()){
                           
                           PreparedStatement pst = co.prepareStatement(sql);
                            pst.setString(1,email);
                            int v = pst.executeUpdate();
                            if(v>0){
                                request.setAttribute("success", "Customer booked ticket was approved success");
                                request.getRequestDispatcher("admin.jsp")
                                            .forward(request, response);
                            }
                            request.setAttribute("error", "Unable to update for approval");
                           request.getRequestDispatcher("admin.jsp")
                                       .forward(request, response);
                       }        
                               
                       
                       request.setAttribute("error", "Unkown error while updating books the ticket");
                           request.getRequestDispatcher("admin.jsp")
                                       .forward(request, response);
                       
                   }catch(SQLException ex) 
                   {
                        out.print(ex);
                   }
                   break;
               }
           }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
