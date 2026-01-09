<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.sql.*, Database.dbconfig" %>
<%@ include file="header.jsp" %>

<div class="pc-container">
  <div class="pc-content">
    <h3>Edit Doctor Schedule</h3>

    <form method="get" action="">
      <label>Select Doctor:</label>
      <select name="doctorname" onchange="this.form.submit()" required>
        <option value="">-- Select Doctor --</option>
        <%
          Connection con = new dbconfig().getConnection();
          Statement st = con.createStatement();
          ResultSet rs = st.executeQuery("SELECT DISTINCT doctorname FROM doctor_schedule");
          while (rs.next()) {
            String doc = rs.getString("doctorname");
        %>
        <option value="<%= doc %>" <%= request.getParameter("doctorname") != null && request.getParameter("doctorname").equals(doc) ? "selected" : "" %>><%= doc %></option>
        <%
          }
          rs.close();
          st.close();
          con.close();
        %>
      </select>
    </form>

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
          scheduleMap.put(day, new String[]{
            rs.getString("m_start"),
            rs.getString("m_end"),
            rs.getString("e_start"),
            rs.getString("e_end"),
            rs.getString("slot")
          });
        }
    %>

    <form method="post" action="/hospital/updatesche">
      <input type="hidden" name="doctorname" value="<%= doctorname %>">

      <table border="1" style="width: 100%; text-align: center;">
        <tr>
          <th>Day</th>
          <th>Morning Start</th>
          <th>Morning End</th>
          <th>Evening Start</th>
          <th>Evening End</th>
          <th>Slots</th>
        </tr>
        <%
          String[] days = {"Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"};
          for (String day : days) {
            String[] values = scheduleMap.getOrDefault(day, new String[]{"absent", "absent", "absent", "absent", "0"});
        %>
        <tr>
          <td><%= day %></td>
          <td><input type="time" name="m_start_<%= day %>" value="<%= values[0].equals("absent") ? "" : values[0] %>"></td>
          <td><input type="time" name="m_end_<%= day %>" value="<%= values[1].equals("absent") ? "" : values[1] %>"></td>
          <td><input type="time" name="e_start_<%= day %>" value="<%= values[2].equals("absent") ? "" : values[2] %>"></td>
          <td><input type="time" name="e_end_<%= day %>" value="<%= values[3].equals("absent") ? "" : values[3] %>"></td>
          <td><input type="number" name="slot_<%= day %>" value="<%= values[4] %>"></td>
        </tr>
        <%
          }
        %>
      </table>

      <br>
      <button type="submit">Update Schedule</button>
    </form>
    <%
        rs.close();
        ps.close();
        con.close();
      }
    %>
  </div>
</div>

<%@ include file="footer.jsp" %>
