<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="Database.dbconfig"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="header.jsp" %>


<div class="pc-container">
  <div class="pc-content">
    <div class="row justify-content-center">
      <div class="col-md-10 col-lg-8">
        <div class="card shadow-sm border">
          <div class="card-body">
            <h2 class="mb-4 text-center  ">Patient Appointment History</h2>

            <% 
              String patientphone = request.getParameter("patientphone");
            %>

            <!-- Form -->
            <form method="post" action="history.jsp" class="mb-4 text-center">
              <input type="text" name="patientphone" placeholder="Enter Phone Number" 
                     value="<%= (patientphone != null) ? patientphone : "" %>" 
                     required class="form-control w-75 d-inline-block mb-2" />
              <br/>
              <input type="submit" value="View History" class="btn btn-primary" />
            </form>

            <!-- Result Table -->
            <%
              if (patientphone != null && !patientphone.trim().isEmpty()) {
                  Connection con = null;
                  PreparedStatement ps = null;
                  ResultSet rs = null;

                  try {
                      Class.forName("com.mysql.jdbc.Driver");
                      con = new dbconfig().getConnection();
                      String sql = "SELECT id, doctorname, patientname, week, a_Time, a_Date, prescription FROM appointmentss WHERE patientphone = ?";
                      ps = con.prepareStatement(sql);
                      ps.setString(1, patientphone);
                      rs = ps.executeQuery();

                      boolean found = false;
            %>

            <div class="table-responsive">
              <table class="table table-hover table-bordered table-striped">
                <thead class="table-light">
                  <tr class="text-center">
                    <th>ID</th>
                    <th>Doctor Name</th>
                    <th>Patient Name</th>
                    <th>Week</th>
                    <th>Time</th>
                    <th>Date</th>
                    <th>Prescription</th>
                  </tr>
                </thead>
                <tbody>
                  <%
                    SimpleDateFormat dbFormat = new SimpleDateFormat("yyyy-MM-dd");
                    SimpleDateFormat displayFormat = new SimpleDateFormat("dd/MM/yyyy");

                    while (rs.next()) {
                        found = true;
                        String rawDate = rs.getString("a_Date");
                        String formattedDate = rawDate;
                        try {
                            Date parsedDate = dbFormat.parse(rawDate);
                            formattedDate = displayFormat.format(parsedDate);
                        } catch (Exception ignored) {}
                  %>
                  <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("doctorname") %></td>
                    <td><%= rs.getString("patientname") %></td>
                    <td><%= rs.getString("week") %></td>
                    <td><%= rs.getString("a_Time") %></td>
                    <td><%= formattedDate %></td>
                    <td><%= rs.getString("prescription") %></td>
                  </tr>
                  <%
                    }

                    if (!found) {
                  %>
                  <tr>
                    <td colspan="7" class="text-center text-muted">No records found for this phone number.</td>
                  </tr>
                  <% } %>
                </tbody>
              </table>
            </div>

            <%
                  } catch (Exception e) {
            %>
                  <p class="text-danger text-center">Error: <%= e.getMessage() %></p>
            <%
                  } finally {
                      try { if (rs != null) rs.close(); } catch (Exception ignored) {}
                      try { if (ps != null) ps.close(); } catch (Exception ignored) {}
                      try { if (con != null) con.close(); } catch (Exception ignored) {}
                  }
              } else if (patientphone != null) {
            %>
              <p class="text-danger text-center">Please enter a valid phone number.</p>
            <% } %>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@include file="footer.jsp" %>
