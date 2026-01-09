/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Database.dbconfig;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author darsh
 */
@WebServlet(urlPatterns = {"/changepass"})
public class dchangepass extends HttpServlet {

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
       PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(false); // false: do not create new session

        String dname = null;
        String daswd = null;

        try {
            dname = session.getAttribute("dname").toString();
            daswd = session.getAttribute("dpass").toString();

            if (dname == null || daswd == null || dname.trim().isEmpty() || daswd.trim().isEmpty()) {
                response.sendRedirect("dlogout");
                return;
            }

        } catch (Exception e) {
            response.sendRedirect("dlogout");
            return;
        }

        String oldpass = request.getParameter("oldpass");
        String newpass = request.getParameter("newpass");
        String confirmpass = request.getParameter("confirmpass");

        try {
            Class.forName("com.mysql.jdbc.Driver"); // Use com.mysql.cj.jdbc.Driver if using newer MySQL
            Connection con = new dbconfig().getConnection();

            PreparedStatement ps = con.prepareStatement("SELECT * FROM doctor WHERE username=? AND password=?");
            ps.setString(1, dname);
            ps.setString(2, oldpass);

            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                out.println("<script>alert('Old password is incorrect.'); window.location='changepass.jsp';</script>");
            } else if (!newpass.equals(confirmpass)) {
                out.println("<script>alert('New password and confirm password do not match.'); window.location='changepass.jsp';</script>");
            } else {
                PreparedStatement ps2 = con.prepareStatement("UPDATE doctor SET password=? WHERE username=?");
                ps2.setString(1, newpass);
                ps2.setString(2, dname);

                int updated = ps2.executeUpdate();

                if (updated > 0) {
                     out.print("<script>alert('update successful')</script>");
            out.print("<meta http-equiv='Refresh' content='0; URL=doctor/changepass.jsp'>");
                 
                } else {
                    out.println("<script>alert('Password update failed.'); window.location='changepass.jsp';</script>");
                }

                ps2.close();
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.location='changepass.jsp';</script>");
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
