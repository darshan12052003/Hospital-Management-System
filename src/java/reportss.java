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
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author darsh
 */
@WebServlet(urlPatterns = {"/reportss"})
public class reportss extends HttpServlet {

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
      
        int totalDoctors = 0, totalPatients = 0, totalAppointments = 0, todayAppointments = 0;

        List<String> doctorList = new ArrayList<>();
        Map<String, Integer> doctorMonthlyAppointments = new LinkedHashMap<>();
        Map<String, Integer> doctorDailyAppointments = new LinkedHashMap<>();
        Map<String, List<String>> doctorMonthlyDetails = new LinkedHashMap<>();
        Map<String, List<String>> doctorDailyDetails = new LinkedHashMap<>();
        Map<String, Integer> specAppointmentCounts = new LinkedHashMap<>();

        try  {

            try (Connection con = new dbconfig().getConnection();
                 Statement stmt = con.createStatement()) {

                // -----------------------------
                // 1. Get Doctor List
                // -----------------------------
                try (ResultSet rs = stmt.executeQuery("SELECT doctorname FROM doctor ORDER BY doctorname")) {
                    while (rs.next()) doctorList.add(rs.getString("doctorname"));
                }

                // -----------------------------
                // 2. Totals
                // -----------------------------
                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM doctor")) {
                    if (rs.next()) totalDoctors = rs.getInt(1);
                }
                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM patients")) {
                    if (rs.next()) totalPatients = rs.getInt(1);
                }
                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE a_Date >= CURDATE() - INTERVAL 30 DAY")) {
                    if (rs.next()) totalAppointments = rs.getInt(1);
                }
                try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE a_Date = CURDATE()")) {
                    if (rs.next()) todayAppointments = rs.getInt(1);
                }

                // -----------------------------
                // 3. Doctor Monthly Appointments
                // -----------------------------
                try (ResultSet rs = stmt.executeQuery(
                        "SELECT d.doctorname, COUNT(a.id) AS cnt " +
                        "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
                        "AND a.a_Date >= CURDATE() - INTERVAL 30 DAY " +
                        "GROUP BY d.doctorname ORDER BY d.doctorname")) {
                    while (rs.next()) {
                        doctorMonthlyAppointments.put(rs.getString("doctorname"), rs.getInt("cnt"));
                    }
                }

                // -----------------------------
                // 4. Doctor Daily Appointments
                // -----------------------------
                try (ResultSet rs = stmt.executeQuery(
                        "SELECT d.doctorname, COUNT(a.id) AS cnt " +
                        "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
                        "AND a.a_Date = CURDATE() " +
                        "GROUP BY d.doctorname ORDER BY d.doctorname")) {
                    while (rs.next()) {
                        doctorDailyAppointments.put(rs.getString("doctorname"), rs.getInt("cnt"));
                    }
                }

                // -----------------------------
                // 5. Monthly Details per Doctor
                // -----------------------------
                String sqlMonthly = "SELECT id, patientname, doctorname, a_Date, a_Time FROM appointmentss " +
                        "WHERE a_Date >= CURDATE() - INTERVAL 30 DAY AND doctorname = ?";
                try (PreparedStatement psMonthly = con.prepareStatement(sqlMonthly)) {
                    for (String doc : doctorList) {
                        psMonthly.setString(1, doc);
                        try (ResultSet rsM = psMonthly.executeQuery()) {
                            List<String> details = new ArrayList<>();
                            while (rsM.next()) {
                                details.add("ID: " + rsM.getInt("id") +
                                        ", Patient: " + (rsM.getString("patientname") == null ? "Unknown" : rsM.getString("patientname")) +
                                        ", Date: " + rsM.getString("a_Date") +
                                        ", Time: " + rsM.getString("a_Time"));
                            }
                            doctorMonthlyDetails.put(doc, details);
                        }
                    }
                }

                // -----------------------------
                // 6. Daily Details per Doctor
                // -----------------------------
                String sqlDaily = "SELECT id, patientname, doctorname, a_Date, a_Time FROM appointmentss " +
                        "WHERE a_Date = CURDATE() AND doctorname = ?";
                try (PreparedStatement psDaily = con.prepareStatement(sqlDaily)) {
                    for (String doc : doctorList) {
                        psDaily.setString(1, doc);
                        try (ResultSet rsD = psDaily.executeQuery()) {
                            List<String> details = new ArrayList<>();
                            while (rsD.next()) {
                                details.add("ID: " + rsD.getInt("id") +
                                        ", Patient: " + (rsD.getString("patientname") == null ? "Unknown" : rsD.getString("patientname")) +
                                        ", Date: " + rsD.getString("a_Date") +
                                        ", Time: " + rsD.getString("a_Time"));
                            }
                            doctorDailyDetails.put(doc, details);
                        }
                    }
                }

                // -----------------------------
                // 7. Specialization Appointment Counts
                // -----------------------------
                try (ResultSet rs = stmt.executeQuery(
                        "SELECT d.specialization, COUNT(a.id) AS cnt " +
                        "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
                        "GROUP BY d.specialization ORDER BY d.specialization")) {
                    while (rs.next()) {
                        specAppointmentCounts.put(rs.getString("specialization"), rs.getInt("cnt"));
                    }
                }

                // -----------------------------
                // 8. Set attributes and forward to JSP
                // -----------------------------
                request.setAttribute("totalDoctors", totalDoctors);
                request.setAttribute("totalPatients", totalPatients);
                request.setAttribute("totalAppointments", totalAppointments);
                request.setAttribute("todayAppointments", todayAppointments);
                request.setAttribute("doctorList", doctorList);
                request.setAttribute("doctorMonthlyAppointments", doctorMonthlyAppointments);
                request.setAttribute("doctorDailyAppointments", doctorDailyAppointments);
                request.setAttribute("doctorMonthlyDetails", doctorMonthlyDetails);
                request.setAttribute("doctorDailyDetails", doctorDailyDetails);
                request.setAttribute("specAppointmentCounts", specAppointmentCounts);

                request.getRequestDispatcher("dashboard.jsp").forward(request, response);

            }

        } catch (Exception ex) {
            ex.printStackTrace();
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
