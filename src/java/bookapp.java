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
@WebServlet(urlPatterns = {"/bookapp"})
public class bookapp extends HttpServlet {

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
    HttpSession session = request.getSession();

  
        String doctorname = request.getParameter("doctorname");
        String patientname = request.getParameter("patientname");
        String patientphone = request.getParameter("patientphone");
        String week = request.getParameter("week");
        String selectedDate = request.getParameter("selectedDate");
        String a_Time = request.getParameter("time");
        String reason = request.getParameter("reason");  // <-- new reason field

        if (doctorname == null || doctorname.trim().isEmpty() ||
            patientname == null || patientname.trim().isEmpty() ||
            patientphone == null || patientphone.trim().isEmpty() ||
            week == null || week.trim().isEmpty() ||
            selectedDate == null || selectedDate.trim().isEmpty() ||
            a_Time == null || a_Time.trim().isEmpty()) {

            session.setAttribute("errorMessage", "Please fill all required fields and select a slot.");
            response.sendRedirect("slot.jsp?doctorname=" + (doctorname != null ? doctorname : "") + "&selectedDate=" + (selectedDate != null ? selectedDate : ""));
            return;
        }

        try (Connection con = new dbconfig().getConnection()) {

            // ✅ Step 1: Check if patient is registered
            PreparedStatement pstCheckPatient = con.prepareStatement("SELECT * FROM patients WHERE phone = ?");
            pstCheckPatient.setString(1, patientphone);
            ResultSet rsPatient = pstCheckPatient.executeQuery();
            if (!rsPatient.next()) {
                out.print("<script>alert('Only registered patients are allowed to book. Please register first.')</script>");
                out.print("<meta http-equiv=\"Refresh\" content=\"0;URL=patient/register.jsp?doctorname=" + doctorname + "&selectedDate=" + selectedDate + "\">");
                return;
            }
                rsPatient.close();
                pstCheckPatient.close();

            // ✅ Step 2: Check if slot is already booked
            PreparedStatement pstCheck = con.prepareStatement(
                    "SELECT * FROM appointmentss WHERE doctorname = ? AND week = ? AND a_Time = ? AND a_Date = ? AND patientname NOT IN ('absent')");
            pstCheck.setString(1, doctorname);
            pstCheck.setString(2, week);
            pstCheck.setString(3, a_Time);
            pstCheck.setString(4, selectedDate);
            ResultSet rs = pstCheck.executeQuery();
            if (rs.next()) {
                out.print("<script>alert('Selected slot is already booked. Please choose another slot.')</script>");
                out.print("<meta http-equiv=\"Refresh\" content=\"0;URL=admin/slots.jsp?doctorname=" + doctorname + "&selectedDate=" + selectedDate + "\">");
                return;
            }
            rs.close();
            pstCheck.close();

            // ✅ Step 3: Insert booking (with reason column)
            PreparedStatement pst = con.prepareStatement(
                "INSERT INTO appointmentss (doctorname, patientname, week, a_Date, a_Time, prescription, patientphone, reason) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
            pst.setString(1, doctorname);
            pst.setString(2, patientname);
            pst.setString(3, week);
            pst.setString(4, selectedDate);
            pst.setString(5, a_Time);
            pst.setString(6, "");  // prescription empty
            pst.setString(7, patientphone);
            pst.setString(8, reason != null ? reason : "N/A");

            int result = pst.executeUpdate();
            pst.close();

            if (result > 0) {
                out.print("<script>alert('booking successful')</script>");
                out.print("<meta http-equiv=\"Refresh\" content=\"0;URL=admin/bookapp.jsp\">");
            } else {
                out.print("<script>alert('Failed to book the appointment. Please try again.')</script>");
                out.print("<meta http-equiv=\"Refresh\" content=\"0;URL=admin/slots.jsp\">");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print(e);
            out.print("<meta http-equiv='Refresh' content='0; URL=admin/slots.jsp\">");
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
