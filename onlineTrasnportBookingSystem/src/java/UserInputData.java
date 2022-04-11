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
@WebServlet(name = "UserInputData", urlPatterns = {"/UserInputData"})
public class UserInputData extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            
            String url = "jdbc:derby://localhost:1527/pearlBookingTransport";
            String user ="pearl";
            String pass = "pearl";
            //login details
            String email = request.getParameter("useremail");
            String password = request.getParameter("password");
            
            //register details
            String firstname = request.getParameter("firstname");
            String middlename = request.getParameter("middlename");
            String lastname = request.getParameter("lastname");
            String phonenumber = request.getParameter("phonenumber");
            String emailreg = request.getParameter("email");
            String passwordreg = request.getParameter("password");
            String confirmpassword = request.getParameter("confirmpassword");
            
            //getting buttons
            String buttonClicked = request.getParameter("button");
            
            //varieable
            
            //checking which button is clicked
            switch (buttonClicked) {
                case "Login":
                    //validate the login details
                    if(email.isEmpty())
                    {
                        request.setAttribute("error", "The email field is empty");
                        request.getRequestDispatcher("index.jsp")
                            .forward(request, response);
                    }
                    else if(password.isEmpty())
                    {
                        request.setAttribute("error", "The password field is empty");
                        request.getRequestDispatcher("index.jsp")
                            .forward(request, response);
                    }
                    else
                    {
                        //checking for the admin and the manager
                        if(email.equals("admin@transport.com") && password.equals("admin"))
                        {
                            session.setAttribute("authAdmin", "admin@transport.com");
                            response.sendRedirect("admin.jsp");
                        }
                        else
                        {
                            //sending the user data to the model to check with the database
                            String sql = "SELECT * FROM USERS WHERE EMAIL=?";
                            Connection conn = DriverManager.getConnection(url,user,pass);
                            PreparedStatement pst=conn.prepareStatement(sql);
                            
                            pst.setString(1,email);
                            ResultSet resultSet = pst.executeQuery();

                            while (resultSet.next()) 
                            {
                                String dbuser = resultSet.getString("PASSWORD");
                                
                                if(dbuser.equals(password))
                                {
                                    session.setAttribute("authUser", email);
                                    request.getRequestDispatcher("user.jsp")
                                            .forward(request, response);
                                }
                                
                            }
                        }
                    }
                    break;
                case "Register":
                    //validate the register details
                    if(firstname.isEmpty())
                    {
                        request.setAttribute("errorreg", "The firstname field is empty");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    }
                    else if(middlename.isEmpty())
                    {
                        request.setAttribute("errorreg", "The middle name field is empty");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    }
                    else if(lastname.isEmpty())
                    {
                        request.setAttribute("errorreg", "The lastname field is empty");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    }
                    else if(phonenumber.isEmpty())
                    {
                        request.setAttribute("errorreg", "The phone number field is empty");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    }
                    else if(emailreg.isEmpty())
                    {
                        request.setAttribute("errorreg", "The email field is empty");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    }
                    else if(passwordreg.isEmpty())
                    {
                        request.setAttribute("errorreg", "The password field is empty");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    }
                    else if(confirmpassword.isEmpty())
                    {
                        request.setAttribute("errorreg", "The password confirmation field is empty");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    }
                    else
                    {
                        //check if the passwords are the same
                        if(passwordreg.equals(confirmpassword))
                        {
                            //sending the user data to the model to check with the database
                            String sql="INSERT INTO USERS(FIRSTNAME,MIDDLENAME,LASTNAME,PHONENUMBER,EMAIL,PASSWORD) VALUES(?,?,?,?,?,?)";
                            Connection conn = DriverManager.getConnection(url,user,pass);
                            PreparedStatement ps= conn.prepareStatement(sql);
                            
                            ps.setString(1,firstname);
                            ps.setString(2,middlename);
                            ps.setString(3,lastname);
                            ps.setString(4,phonenumber);
                            ps.setString(5,emailreg);
                            ps.setString(6,passwordreg);
                            
                            int check = ps.executeUpdate();
                            if(check>0)
                            {
                                request.setAttribute("created", "you have created an account successfulluy");
                                session.setAttribute("authUser", emailreg);
                                    request.getRequestDispatcher("user.jsp")
                                            .forward(request, response);
                            }
                            
                        }
                        else
                        {
                            request.setAttribute("errorreg", "The two passwords do not match");
                            request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                        }
                        
                    }
                    break;
                default:
                    request.setAttribute("unknownError", "An unknown error has occurred please try again");
                        request.getRequestDispatcher("index.jsp")
                                .forward(request, response);
                    break;
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UserInputData.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(UserInputData.class.getName()).log(Level.SEVERE, null, ex);
        }
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
