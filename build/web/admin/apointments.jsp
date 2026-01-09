<%@page import="Database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@include file="header.jsp" %>

<div class="pc-container">
  <div class="pc-content">
    <div class="col-md-12 col-xl-12">
      <h5 class="mb-3">Appointments</h5>
      <div class="card tbl-card">
        <div class="card-body">
          <div class="table-responsive">

            <div class="d-flex justify-content-between align-items-end mb-4">
              <h3 class="mb-0"><b>Today's Appointments</b></h3>
            </div>

            <%
              try {
                  Connection con = new dbconfig().getConnection();
                  Statement stat = con.createStatement();

                  // Get today's date as yyyy-MM-dd string
                  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                  String todayDate = sdf.format(new Date());

                  // Query only today's appointments, ordered by doctorname and time
                  String query = "SELECT * FROM appointmentss WHERE a_Date = '" + todayDate + "' ORDER BY doctorname ASC, a_Time ASC";
                  ResultSet res = stat.executeQuery(query);

                  String lastDoctor = "";
                  boolean firstDoctor = true;

                  while (res.next()) {
                      int id = res.getInt("id");
                      String patientname = res.getString("patientname");
                      String doctorname = res.getString("doctorname");
                      String a_Time = res.getString("a_Time");

                      // Group by doctor
                      if (!doctorname.equals(lastDoctor)) {
                          if (!firstDoctor) {
            %>
                              </tbody>
                            </table>
            <%
                          }
            %>
                          <h4 class="mt-4 mb-3 text-primary"><b>Doctor: <%= doctorname %></b></h4>
                          <table class="table table-hover table-bordered mb-3">
                            <thead class="table-light">
                              <tr>
                                <th>ID</th>
                                <th>Patient</th>
                                <th>Time</th>
                                <th>Action</th>
                              </tr>
                            </thead>
                            <tbody>
            <%
                          lastDoctor = doctorname;
                          firstDoctor = false;
                      }
            %>
                      <tr>
                        <td><%= id %></td>
                        <td><%= patientname %></td>
                        <td><%= a_Time %></td>
                        <td>
                          <a href="<%= request.getContextPath() %>/deletapp?id=<%= id %>" title="Delete" onclick="return confirm('Are you sure you want to delete this Appointment?');">
                            <i class="fas fa-trash-alt" style="color:red;"></i>
                          </a>
                        </td>
                      </tr>
            <%
                  }

                  // Close the last open table
                  if (!firstDoctor) {
            %>
                      </tbody>
                    </table>
            <%
                  } else {
            %>
                    <div class="alert alert-info">No appointments for today.</div>
            <%
                  }

                  res.close();
                  stat.close();
                  con.close();

              } catch (Exception e) {
            %>
                <div class="alert alert-danger">Error: <%= e.getMessage() %></div>
            <%
              }
            %>

          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@include file="footer.jsp" %>
