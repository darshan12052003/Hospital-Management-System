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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author darsh
 */
@WebServlet(urlPatterns = {"/updatesche"})
public class updatesche extends HttpServlet {

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
    String doctorname = request.getParameter("doctorname");
    String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};

    try {
        Connection con = new dbconfig().getConnection();
        for (String day : days) {
            String m_start = request.getParameter("m_start_" + day);
            String m_end = request.getParameter("m_end_" + day);
            String e_start = request.getParameter("e_start_" + day);
            String e_end = request.getParameter("e_end_" + day);
            String slotStr = request.getParameter("slot_" + day);

            if (m_start == null || m_start.isEmpty()) m_start = "absent";
            if (m_end == null || m_end.isEmpty()) m_end = "absent";
            if (e_start == null || e_start.isEmpty()) e_start = "absent";
            if (e_end == null || e_end.isEmpty()) e_end = "absent";
            int slot = (slotStr != null && !slotStr.isEmpty()) ? Integer.parseInt(slotStr) : 0;

            // Use update or replace
            PreparedStatement ps = con.prepareStatement(
                "UPDATE doctor_schedule SET m_start=?, m_end=?, e_start=?, e_end=?, slot=? WHERE doctorname=? AND week=?"
            );
            ps.setString(1, m_start);
            ps.setString(2, m_end);
            ps.setString(3, e_start);
            ps.setString(4, e_end);
            ps.setInt(5, slot);
            ps.setString(6, doctorname);
            ps.setString(7, day);
            int rows = ps.executeUpdate();

            // If not exists, insert
            if (rows == 0) {
                ps = con.prepareStatement("INSERT INTO doctor_schedule (doctorname, week, m_start, m_end, e_start, e_end, slot) VALUES (?, ?, ?, ?, ?, ?, ?)");
                ps.setString(1, doctorname);
                ps.setString(2, day);
                ps.setString(3, m_start);
                ps.setString(4, m_end);
                ps.setString(5, e_start);
                ps.setString(6, e_end);
                ps.setInt(7, slot);
                ps.executeUpdate();
            }
        }
        out.println("<script>alert('Schedule updated successfully');</script>");
        out.println("<meta http-equiv='refresh' content='0;URL=admin/addschedule.jsp'>");
    } catch (Exception e) {
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
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
