<%@page import="java.sql.*"%>
<%@page import="Database.dbconfig"%>
<%@include file="header.jsp" %>

<%
    String name = "";
    String upcomingAppointment = "No appointments";
    int totalAppointments = 0;
    String errorMsg = null;

    if (session.getAttribute("uname") == null) {
        response.sendRedirect("login.jsp"); // Or wherever your login page is
        return;
    }

   

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();

        // Get patient name
        String sqlProfile = "SELECT name FROM patients WHERE name = ?";
        PreparedStatement ps1 = con.prepareStatement(sqlProfile);
        ps1.setString(1, uname);
        ResultSet rs1 = ps1.executeQuery();

        if (rs1.next()) {
            name = rs1.getString("name");
        }

        // Get recent appointment
        String sqlApp = "SELECT doctorname, a_Date, a_Time FROM appointmentss WHERE patientname = ? ORDER BY a_Date DESC, a_Time DESC LIMIT 1";
        PreparedStatement ps2 = con.prepareStatement(sqlApp);
        ps2.setString(1, uname);
        ResultSet rs2 = ps2.executeQuery();

        if (rs2.next()) {
            upcomingAppointment = rs2.getString("doctorname") + " on " + rs2.getString("a_Date") + " at " + rs2.getString("a_Time");
        }

        // Count total appointments
        String sqlCount = "SELECT COUNT(*) AS total FROM appointmentss WHERE patientname = ?";
        PreparedStatement ps3 = con.prepareStatement(sqlCount);
        ps3.setString(1, uname);
        ResultSet rs3 = ps3.executeQuery();
        if (rs3.next()) {
            totalAppointments = rs3.getInt("total");
        }

        // Close everything
        rs1.close(); rs2.close(); rs3.close();
        ps1.close(); ps2.close(); ps3.close();
        con.close();
    } catch (Exception e) {
        errorMsg = "Error: " + e.getMessage();
        e.printStackTrace();
    }
%>

<div class="pc-container">
  <div class="pc-content">
    <div class="row justify-content-center">
      <div class="col-md-12 col-lg-10 h-100">
        <div class="card shadow-sm p-4 mb-4">
          <h2 class="mb-3">Welcome, <%= name %></h2>

          <% if (errorMsg != null) { %>
              <div class="alert alert-danger"><%= errorMsg %></div>
          <% } %>

          <div class="row">
            <div class="col-md-6 mb-3">
              <div class="card border shadow-sm h-100">
                <div class="card-body">
                  <h5 class="card-title">Upcoming Appointment</h5>
                  <p class="card-text"><%= upcomingAppointment %></p>
                  <a href="myappo.jsp" class="btn btn-sm btn-primary">View All Appointments</a>
                </div>
              </div>
            </div>

            <div class="col-md-6 mb-3">
              <div class="card border shadow-sm h-100">
                <div class="card-body">
                  <h5 class="card-title">Profile Info</h5>
                  <p class="card-text">Total Appointments: <b><%= totalAppointments %></b></p>
                  <a href="profile.jsp" class="btn btn-sm btn-secondary">View Profile</a>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>

<%@include file="footer.jsp" %>
