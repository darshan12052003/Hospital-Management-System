<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Database.dbconfig"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="java.util.*"%>
<%@include file="header.jsp"%>

<%
   

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = new dbconfig().getConnection();
        String sql = "SELECT doctorname FROM doctor WHERE username = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, dname);
        rs = ps.executeQuery();
        if (rs.next()) {
            doctorFullName = rs.getString("doctorname");
        } else {
            response.sendRedirect("dlogout");
            return;
        }
    } catch (Exception e) {
        out.println("Error fetching doctor info: " + e.getMessage());
        return;
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (ps != null) ps.close(); } catch (Exception ignored) {}
        try { if (con != null) con.close(); } catch (Exception ignored) {}
    }

    // Get request parameters
    String action = request.getParameter("action");
    String patientname = request.getParameter("patientname");
    String date = request.getParameter("date");
    String time = request.getParameter("time");

    // Handle prescription submission
    if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("prescription") != null) {
        String prescription = request.getParameter("prescription");

        if (prescription != null && !prescription.trim().equals("")) {
            Connection con2 = null;
            PreparedStatement ps2 = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                con2 = new dbconfig().getConnection();
                String updateSQL = "UPDATE appointmentss SET prescription = ? WHERE patientname = ? AND a_Date = ? AND a_Time = ?";
                ps2 = con2.prepareStatement(updateSQL);
                ps2.setString(1, prescription);
                ps2.setString(2, patientname);
                ps2.setString(3, date);
                ps2.setString(4, time);
                int updated = ps2.executeUpdate();

                if (updated > 0) {
                    message = "Prescription added for " + patientname;
                    action = null;
                } else {
                    message = "Unable to update prescription.";
                }
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            } finally {
                try { if (ps2 != null) ps2.close(); } catch (Exception ignored) {}
                try { if (con2 != null) con2.close(); } catch (Exception ignored) {}
            }
        } else {
            message = "Prescription cannot be blank.";
        }
    }
%>

<% if ("addprescription".equals(action)) { %>

<!-- START: Add Prescription Container -->
<div class="card tbl-card"> 
  <div class="pc-container">
    <div class="pc-content">
      <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">
          <div class="card shadow-sm border">
            <div class="card-body">

              <h5>Add Prescription for <%= patientname %> (<%= date %> @ <%= time %>)</h5>

              <% if (!message.isEmpty()) { %>
                <div style="color: green; font-weight: bold; margin-bottom: 15px;"><%= message %></div>
              <% } %>

              <form method="post">
                <input type="hidden" name="patientname" value="<%= patientname %>" />
                <input type="hidden" name="date" value="<%= date %>" />
                <input type="hidden" name="time" value="<%= time %>" />

                <div class="form-group">
                  <label>Prescription</label>
                  <textarea name="prescription" placeholder="Enter prescription..." required rows="6" style="width:100%;"></textarea>
                </div>

                <div class="form-group mt-2">
                  <input type="submit" value="Save Prescription" class="btn btn-primary" />
                  <a href="viewappoi.jsp" class="btn btn-secondary ms-2">Back</a>
                </div>
              </form>

              <h6 style="margin-top: 30px;">Prescription History (Last 5):</h6>
              <ul>
                <%
                    Connection conHist = null;
                    PreparedStatement psHist = null;
                    ResultSet rsHist = null;
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        conHist = new dbconfig().getConnection();
                        String histSQL = "SELECT prescription, a_Date FROM appointmentss WHERE patientname = ? AND prescription IS NOT NULL ORDER BY a_Date DESC LIMIT 5";
                        psHist = conHist.prepareStatement(histSQL);
                        psHist.setString(1, patientname);
                        rsHist = psHist.executeQuery();
                        while (rsHist.next()) {
                            String rawDate = rsHist.getString("a_Date");
                            String formattedHistDate = rawDate;
                            try {
                                SimpleDateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd");
                                SimpleDateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy");
                                java.util.Date parsedDate = fromFormat.parse(rawDate);
                                formattedHistDate = toFormat.format(parsedDate);
                            } catch (Exception ignored) {}
                %>
                <li><strong><%= formattedHistDate %>:</strong> <%= rsHist.getString("prescription") %></li>
                <%
                        }
                    } catch (Exception e) {
                %>
                <li style="color:red;">Error: <%= e.getMessage() %></li>
                <%
                    } finally {
                        try { if (rsHist != null) rsHist.close(); } catch (Exception ignored) {}
                        try { if (psHist != null) psHist.close(); } catch (Exception ignored) {}
                        try { if (conHist != null) conHist.close(); } catch (Exception ignored) {}
                    }
                %>
              </ul>

            </div> <!-- card-body -->
          </div> <!-- card shadow-sm border -->
        </div> <!-- col -->
      </div> <!-- row -->
    </div> <!-- pc-content -->
  </div> <!-- pc-container -->
</div> <!-- card tbl-card -->
<!-- END: Add Prescription Container -->

<% } else { %>

<!-- START: Appointment List View -->
<div class="pc-container">
  <div class="pc-content">
    <h5 class="mb-3">Appointments for Dr. <%= doctorFullName %></h5>

    <% if (!message.isEmpty()) { %>
      <div style="color: green; font-weight: bold; margin-bottom: 15px;"><%= message %></div>
    <% } %>

    <div class="card tbl-card">
      <div class="card-body">
        <div class="table-responsive">
          <table class="table table-hover table-bordered mb-0">
            <thead>
              <tr>
                <th>ID</th>
                <th>Patient</th>
                <th>Week</th>
                <th>Date</th>
                <th>Time</th>
                <th>Phone</th>
                <th>Prescription</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <%
                  Connection con2 = null;
                  PreparedStatement ps2 = null;
                  ResultSet rs2 = null;
                  try {
                      Class.forName("com.mysql.jdbc.Driver");
                      con2 = new dbconfig().getConnection();
                      String query = "SELECT id, patientname, week, a_Date, a_Time, patientphone, prescription FROM appointmentss WHERE doctorname = ?";
                      ps2 = con2.prepareStatement(query);
                      ps2.setString(1, doctorFullName);
                      rs2 = ps2.executeQuery();

                      int slno = 0;
                      while (rs2.next()) {
                          slno++;
                          int id = rs2.getInt("id");
                          String pname = rs2.getString("patientname");
                          String week = rs2.getString("week");
                          String aDate = rs2.getString("a_Date");
                          String aTime = rs2.getString("a_Time");
                          String phone = rs2.getString("patientphone");
                          String pres = rs2.getString("prescription");

                          String formattedDate = aDate;
                          try {
                              SimpleDateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd");
                              SimpleDateFormat toFormat = new SimpleDateFormat("dd/MM/yyyy");
                              java.util.Date parsedDate = fromFormat.parse(aDate);
                              formattedDate = toFormat.format(parsedDate);
                          } catch (Exception ignored) {}
              %>
              <tr>
                <td><%= slno %></td>
                <td><%= pname %></td>
                <td><%= week %></td>
                <td><%= formattedDate %></td>
                <td><%= aTime %></td>
                <td><%= phone %></td>
                <td><%= (pres != null && !pres.trim().equals("")) ? pres : "?" %></td>
                <td>
                  <% if (pres == null || pres.trim().equals("")) { %>
                    <a class="btn btn-sm btn-primary" href="viewappoi.jsp?action=addprescription&patientname=<%= pname %>&date=<%= aDate %>&time=<%= aTime %>">Add Prescription</a>
                  <% } else { %>
                    <span class="text-success">Done</span>
                  <% } %>
                </td>
              </tr>
              <%
                      }
                  } catch (Exception e) {
              %>
              <tr>
                <td colspan="8" style="color:red;">Error: <%= e.getMessage() %></td>
              </tr>
              <%
                  } finally {
                      try { if (rs2 != null) rs2.close(); } catch (Exception ignored) {}
                      try { if (ps2 != null) ps2.close(); } catch (Exception ignored) {}
                      try { if (con2 != null) con2.close(); } catch (Exception ignored) {}
                  }
              %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- END: Appointment List View -->

<% } %>

<%@include file="footer.jsp" %>
