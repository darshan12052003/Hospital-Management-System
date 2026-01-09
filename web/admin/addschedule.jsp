<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<%@page import="Database.dbconfig"%>
<%@include file="header.jsp" %>

<div class="pc-container">
  <div class="pc-content">
    <div class="row justify-content-center">
      <div class="col-md-10 col-lg-8">

        <!-- Doctor Selection Card -->
        <div class="card tbl-card shadow-sm mb-4">
          <div class="card-body">
            <h3 class="mb-4 text-center">Manage Doctor Schedule (Add / Edit)</h3>
            
            <form method="get" action="">
              <h4 class="text-center mb-3">Select Doctor</h4>
              <label><strong>Select Doctor:</strong></label>
              <select name="doctorname" onchange="this.form.submit()" class="form-control" required>
                <option value="">-- Select Doctor --</option>
                <%
                  Connection con = new dbconfig().getConnection();
                  Statement st = con.createStatement();
                  ResultSet rs = st.executeQuery("SELECT doctorname, specialization FROM doctor");
                  while (rs.next()) {
                    String doc = rs.getString("doctorname");
                    String specialization = rs.getString("specialization");
                %>
                <option value="<%= doc %>" <%= request.getParameter("doctorname") != null && request.getParameter("doctorname").equals(doc) ? "selected" : "" %>>
                  <%= doc %> - <%= specialization %>
                </option>
                <%
                  }
                  rs.close(); st.close(); con.close();
                %>
              </select>
            </form>
          </div>
        </div>

        <%
          String doctorname = request.getParameter("doctorname");
          if (doctorname != null && !doctorname.isEmpty()) {
            con = new dbconfig().getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM doctor_schedule WHERE doctorname = ?");
            ps.setString(1, doctorname);
            rs = ps.executeQuery();

            Map<String, String[]> scheduleMap = new HashMap<String, String[]>();
            while (rs.next()) {
  String day = rs.getString("week");

  String m_start = rs.getString("m_start");
  String m_end   = rs.getString("m_end");
  String e_start = rs.getString("e_start");
  String e_end   = rs.getString("e_end");

  // ? Fix: ensure slot value is never null
  String slotVal = rs.getString("slot");
  if (slotVal == null || slotVal.trim().isEmpty()) {
      slotVal = "0";
  }

  scheduleMap.put(day, new String[]{m_start, m_end, e_start, e_end, slotVal});
}
        %>

        <!-- Weekly Schedule Card -->
        <div class="card tbl-card shadow-sm">
          <div class="card-body">
            <form method="post" action="/hospital/updatesche">
              <input type="hidden" name="doctorname" value="<%= doctorname %>">

              <h4 class="mb-4 text-center">Weekly Schedule</h4>
              <table class="table table-bordered text-center bg-white">
                <thead class="thead-light">
                  <tr>
                    <th>Day</th>
                    <th>Morning Start</th>
                    <th>Morning End</th>
                    <th>Evening Start</th>
                    <th>Evening End</th>
                    <th>Slots</th>
                  </tr>
                </thead>
                <tbody>
                <%
                  String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
                  for (String day : days) {
                    String[] values = scheduleMap.getOrDefault(day, new String[]{"absent", "absent", "absent", "absent", "0"});
                %>
                  <tr>
                    <td><%= day %></td>
                    <td><input type="time" name="m_start_<%= day %>" value="<%= values[0] != null && !values[0].equals("absent") ? values[0] : "" %>" class="form-control"></td>
                    <td><input type="time" name="m_end_<%= day %>" value="<%= values[1] != null && !values[1].equals("absent") ? values[1] : "" %>" class="form-control"></td>
                    <td><input type="time" name="e_start_<%= day %>" value="<%= values[2] != null && !values[2].equals("absent") ? values[2] : "" %>" class="form-control"></td>
                    <td><input type="time" name="e_end_<%= day %>" value="<%= values[3] != null && !values[3].equals("absent") ? values[3] : "" %>" class="form-control"></td>
                    <td><input type="number" name="slot_<%= day %>" value="<%= (values[4] != null && !values[4].equals("0")) ? values[4] : "0" %>" min="0" class="form-control"></td>
                  </tr>
                <%
                  }
                %>
                </tbody>
              </table>

              <div class="text-center mt-3">
                <button type="submit" class="btn btn-success">Save Schedule</button>
              </div>
            </form>
          </div>
        </div>

        <%
            con.close();
          }
        %>

        <!-- Back Link -->
        <div class="text-center mt-4">
          <a class="btn btn-link" href="index.jsp">? Back to Home</a>
        </div>

      </div>
    </div>
  </div>
</div>

<%@include file="footer.jsp" %>
