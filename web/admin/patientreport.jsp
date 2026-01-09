<%@page import="Database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="header.jsp" %>

<div class="pc-container">
  <div class="pc-content">
        <div class="row mt-4">
      <div class="col-md-12 mb-4">
          <div class="card shadow-sm p-3">
    <h3>Patient Report</h3>
    <hr>

    <!-- Filters -->
    <form method="get" class="row g-3 mb-4">
      <div class="col-md-3">
        <input type="text" name="search" class="form-control" placeholder="Name, Email, Phone, ID"
               value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
      </div>

      <div class="col-md-2">
        <select name="gender" class="form-select">
          <option value="">All Genders</option>
          <option value="Male" <%= "Male".equals(request.getParameter("gender")) ? "selected" : "" %>>Male</option>
          <option value="Female" <%= "Female".equals(request.getParameter("gender")) ? "selected" : "" %>>Female</option>
          <option value="Other" <%= "Other".equals(request.getParameter("gender")) ? "selected" : "" %>>Other</option>
        </select>
      </div>

      <div class="col-md-2">
        <input type="number" name="age_from" class="form-control" placeholder="Age From"
               value="<%= request.getParameter("age_from") != null ? request.getParameter("age_from") : "" %>">
      </div>

      <div class="col-md-2">
        <input type="number" name="age_to" class="form-control" placeholder="Age To"
               value="<%= request.getParameter("age_to") != null ? request.getParameter("age_to") : "" %>">
      </div>
      
      <div class="col-md-4">
        <label>Registered From:</label>
        <input type="date" name="fromDate" class="form-control"
               value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">
      </div>

      <div class="col-md-4">
        <label>Registered To:</label>
        <input type="date" name="toDate" class="form-control"
               value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">
      </div>

      <div class="col-md-2 align-self-end">
        <button type="submit" class="btn btn-primary">Filter</button>
      </div>

      <div class="col-md-4 align-self-end">
        <a href="?export=excel" class="btn btn-success">Export Excel</a>
        <a href="?export=pdf" class="btn btn-danger">Export PDF</a>
        <button type="button" class="btn btn-secondary" onclick="window.print()">Print</button>
      </div>
    </form>

    <!-- Patient Table -->
    <div class="table-responsive">
         <div class="row mt-4">
      <div class="col-md-12 mb-4">
          <div class="card shadow-sm p-3">
      <table id="patientTable" class="table table-bordered table-hover">
        <thead class="table-light">
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Gender</th>
            <th>Age</th>
            <th>Registered At</th>
            <th>Appointments</th>
          </tr>
        </thead>
        <tbody>
        <%
          Connection con = null;
          Statement stat = null;
          ResultSet rs = null;

          String search = request.getParameter("search");
          String gender = request.getParameter("gender");
          String ageFrom = request.getParameter("age_from");
          String ageTo = request.getParameter("age_to");
          String fromDate = request.getParameter("fromDate");
          String toDate = request.getParameter("toDate");
          String export = request.getParameter("export");

          try {
              con = new dbconfig().getConnection();
              stat = con.createStatement();

              String sql = "SELECT * FROM patients WHERE 1=1";

              if(search != null && !search.trim().isEmpty()) {
                  sql += " AND (name LIKE '%" + search + "%' OR email LIKE '%" + search + "%' OR phone LIKE '%" + search + "%' OR id LIKE '%" + search + "%')";
              }
              if(gender != null && !gender.isEmpty()) {
                  sql += " AND gender='" + gender + "'";
              }
              if(ageFrom != null && !ageFrom.isEmpty()) {
                  sql += " AND age >= " + ageFrom;
              }
              if(ageTo != null && !ageTo.isEmpty()) {
                  sql += " AND age <= " + ageTo;
              }
              if(fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
                  sql += " AND created_at BETWEEN '" + fromDate + "' AND '" + toDate + "'";
              }

              sql += " ORDER BY name ASC";

              rs = stat.executeQuery(sql);

              while(rs.next()){
        %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("phone") %></td>
            <td><%= rs.getString("gender") %></td>
            <td><%= rs.getInt("age") %></td>
            <td><%= rs.getString("created_at") %></td>
            <td>
              <a href="../patient/myappo.jsp<%= rs.getInt("id") %>" class="btn btn-warning btn-sm" onclick="$('#history_<%= rs.getInt("id") %>').toggle()">View</a>
              <div id="history_<%= rs.getInt("id") %>" style="display:none; margin-top:5px;">
                <table class="table table-sm table-bordered">
                  <tr><th>Doctor</th><th>Date</th><th>Time</th><th>Reason</th><th>Prescription</th></tr>
                  <%
                    Statement st2 = con.createStatement();
                    ResultSet rs2 = st2.executeQuery("SELECT * FROM appointmentss WHERE patientname='"+rs.getString("name")+"' ORDER BY a_Date DESC, a_Time DESC");
                    while(rs2.next()){
                  %>
                    <tr>
                      <td><%= rs2.getString("doctorname") %></td>
                      <td><%= rs2.getString("a_Date") %></td>
                      <td><%= rs2.getString("a_Time") %></td>
                      <td><%= rs2.getString("reason") %></td>
                      <td><%= rs2.getString("prescription") %></td>
                    </tr>
                  <%
                    }
                    rs2.close(); st2.close();
                  %>
                </table>
              </div>
            </td>
          </tr>
          
        <%
              }

              rs.close(); stat.close(); con.close();
          } catch(Exception e){
              out.println("<tr><td colspan='8'>Error: "+e.getMessage()+"</td></tr>");
          }
        %>
        </tbody>
      </table>
    </div>
  </div>
</div>
</div>
       </div>
<script>
  $(document).ready(function(){
    $('#patientTable').DataTable({
      "pageLength": 10,
      "lengthMenu":[10,25,50,100],
      "order":[[1,"asc"]],
      "columnDefs":[{"orderable":false,"targets":7}]
    });
  });
</script>

<%@include file="footer.jsp" %>
