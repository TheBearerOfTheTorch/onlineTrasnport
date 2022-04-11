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
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(name = "LookUp", urlPatterns = {"/LookUp"})
public class LookUp extends HttpServlet {

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
            HttpSession session = request.getSession();
            
            
            String buttonClicked = request.getParameter("button");
            
            //database connection for checking if the
            String url = "jdbc:derby://localhost:1527/pearlBookingTransport";
            String user ="pearl";
            String pass = "pearl";
            
            try 
            {
                switch(buttonClicked){
                    case "Lookup":{
                        String time = request.getParameter("time");
                        String destination = request.getParameter("destination");
                        
                        if(time.isEmpty())
                        {
                            request.setAttribute("error", "The lookup time field is empty");
                                    request.getRequestDispatcher("user.jsp")
                                        .forward(request, response);
                        }
                        else if(destination.isEmpty())
                        {
                            request.setAttribute("error", "The lookup destination field is empty");
                                    request.getRequestDispatcher("user.jsp")
                                        .forward(request, response);
                        }
                        else
                        {
                            //querying the db
                            String sql = "INSERT INTO CHECKUP(TIME, CHECKED,EMAIL) VALUES(?,?,?)";
                            String select ="SELECT * FROM TICKETS WHERE DESTINATION=? AND TIME=?";
                            Connection co = DriverManager.getConnection(url, user, pass);
                            PreparedStatement ps = co.prepareStatement(select);
                            ps.setString(1, destination);
                            ps.setString(2, time);
                            ResultSet set = ps.executeQuery();
                            while(set.next()){
                                PreparedStatement pst = co.prepareStatement(sql);
                                
                                String authUser = (String) session.getAttribute("authUser");
                                
                                pst.setString(1,time);
                                pst.setBoolean(2,true);
                                pst.setString(3, authUser);

                                int checking = pst.executeUpdate();

                                if(checking>0)
                                {
                                    request.getRequestDispatcher("user.jsp")
                                            .forward(request, response);
                                }
                                request.setAttribute("error", "You have a pendint lookup you submited earlier");
                                request.getRequestDispatcher("user.jsp")
                                    .forward(request, response);
                            }
                            request.setAttribute("error", "There are no tickets for buses around that time and to that place");
                                request.getRequestDispatcher("user.jsp")
                                    .forward(request, response);
                        }
                        break;
                    }
                    case "book":{
                        String names = request.getParameter("names");
                        String idNumber = request.getParameter("idNumber");
                        String destination = request.getParameter("destination");
                        
                        if(names.isEmpty())
                        {
                            request.setAttribute("error", "The names field is empty");
                                    request.getRequestDispatcher("user.jsp")
                                        .forward(request, response);
                        }
                        else if(idNumber.isEmpty())
                        {
                            request.setAttribute("error", "The id Number field is empty");
                                    request.getRequestDispatcher("user.jsp")
                                        .forward(request, response);
                        }
                        else if(destination.isEmpty())
                        {
                            request.setAttribute("error", "The destination field is empty");
                                    request.getRequestDispatcher("user.jsp")
                                        .forward(request, response);
                        }
                        else
                        {
                            //querying the db
                            String sql = "INSERT INTO BOOKS(NAMES,DESTINATION,APPROVAL,EMAIL,TIME,PRICE) VALUES(?,?,?,?,?,?)";
                            String select ="SELECT * FROM TICKETS WHERE DESTINATION=?";
                            Connection co = DriverManager.getConnection(url, user, pass);
                            PreparedStatement ps = co.prepareStatement(select);
                            ps.setString(1, destination);
                            ResultSet set = ps.executeQuery();
                       
                            while(set.next()){
                                String time = set.getString("TIME");
                                String price = set.getString("price");
                                PreparedStatement pst = co.prepareStatement(sql);
                                
                                pst.setString(1, names);
                                pst.setString(2,destination);
                                pst.setBoolean(3,false);
                                pst.setString(4,idNumber);
                                pst.setString(5,time);
                                pst.setString(6,price);
                                
                                out.print("is it gettign here");
                                int checking = pst.executeUpdate();

                                if(checking>0)
                                {
                                    String delete = "DELETE FROM CHECKUP WHERE EMAIL=?";
                                    PreparedStatement p = co.prepareStatement(delete);
                                    p.setString(1, idNumber);
                                    int check = p.executeUpdate();
                                    if(check>0){
                                        request.getRequestDispatcher("user.jsp")
                                        .forward(request, response);
                                    }
                                }
                            }
                            request.setAttribute("error", "There are no tickets for buses around that time and to that place");
                                request.getRequestDispatcher("user.jsp")
                                    .forward(request, response);
                        }
                        break;
                    }
                }

            } catch (SQLException ex) 
            {
                Logger.getLogger(LookUp.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            
            //checking if the fields are empty
            
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
