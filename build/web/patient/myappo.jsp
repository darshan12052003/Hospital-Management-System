<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Database.dbconfig"%>
<%@page import="java.sql.Connection"%>
<%@include file="header.jsp" %>

<%
    // Appointment data list
    class Appointment {
        int id;
        String doctor;
        String date;
        String time;
        String status;
    }

    java.util.List<Appointment> appointments = new java.util.ArrayList<Appointment>();
    String errorMsg = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();

        String sql = "SELECT id, doctorname, a_Date, a_Time FROM appointmentss WHERE patientname = ? ORDER BY a_Date DESC, a_Time DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, uname); // Make sure 'uname' is defined (e.g., from session)

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Appointment ap = new Appointment();
            ap.id = rs.getInt("id");
            ap.doctor = rs.getString("doctorname");
            ap.date = rs.getString("a_Date");
            ap.time = rs.getString("a_Time");
            ap.status = "Pending"; // or fetch from DB if status column exists
            appointments.add(ap);
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        errorMsg = "Database error: " + e.getMessage();
        e.printStackTrace();
    }
%>

<!-- ? Use the required layout only -->
<div class="pc-container">
  <div class="pc-content">
    <div class="row justify-content-center">
      <div class="col-md-10 col-lg-8">
        <div class="card shadow-sm border p-4">
          <h3 class="mb-4">My Appointments</h3>

          <% if (errorMsg != null) { %>
              <div class="alert alert-danger"><%= errorMsg %></div>
          <% } else if (appointments.isEmpty()) { %>
              <p class="text-center fs-5">You have no appointments scheduled.</p>
          <% } else { %>
              <div class="table-responsive">
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Appointment ID</th>
                            <th>Doctor</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Appointment ap : appointments) { %>
                            <tr>
                                <td><%= ap.id %></td>
                                <td><%= ap.doctor %></td>
                                <td><%= ap.date %></td>
                                <td><%= ap.time %></td>
                                <td><%= ap.status %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
              </div>
          <% } %>

        </div>
      </div>
    </div>
  </div>
</div>

<%@include file="footer.jsp" %>
