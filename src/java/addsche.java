/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Database.dbconfig;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author darsh
 */
@WebServlet(urlPatterns = {"/addsche"})
public class addsche extends HttpServlet {

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
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = new dbconfig().getConnection();

            for (String day : days) {
                // Sunday is always treated as holiday — skip
                if (day.equals("Sunday")) {
                    continue;
                }

                // Check if the checkbox for this day was ticked
                boolean isChecked = false;
                String[] selectedDays = request.getParameterValues("week");
                if (selectedDays != null) {
                    for (String selected : selectedDays) {
                        if (selected.equals(day)) {
                            isChecked = true;
                            break;
                        }
                    }
                }

                String m_start = request.getParameter("m_start_" + day);
                String m_end = request.getParameter("m_end_" + day);
                String e_start = request.getParameter("e_start_" + day);
                String e_end = request.getParameter("e_end_" + day);
                String slotStr = request.getParameter("slot_" + day);
                int slot = (slotStr != null && !slotStr.equals("")) ? Integer.parseInt(slotStr) : 0;

                // If day not selected (checkbox not ticked)
                if (!isChecked) {
                    m_start = "absent";
                    m_end = "absent";
                    e_start = "absent";
                    e_end = "absent";
                    slot = 0;
                } else {
                    // For selected day, check if any individual field is missing
                    if (m_start == null || m_start.isEmpty()) m_start = "absent";
                    if (m_end == null || m_end.isEmpty()) m_end = "absent";
                    if (e_start == null || e_start.isEmpty()) e_start = "absent";
                    if (e_end == null || e_end.isEmpty()) e_end = "absent";
                }

                Statement stat = con.createStatement();
                stat.executeUpdate("INSERT INTO doctor_schedule (doctorname, week, m_start, m_end, e_start, e_end, slot) VALUES ('"
                        + doctorname + "','" + day + "','" + m_start + "','" + m_end + "','" + e_start + "','" + e_end + "','" + slot + "')");
            }

            out.print("<script>alert('Schedule added successfully');</script>");
            out.print("<meta http-equiv='refresh' content='0; URL=admin/addschedule.jsp'>");

        } catch (Exception e) {
            out.print("<script>alert('Error: " + e.getMessage() + "');</script>");
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
