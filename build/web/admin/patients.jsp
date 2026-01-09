<%@page import="Database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@include file="header.jsp" %>
  <div class="pc-container" >
      <div class="pc-content">
          
            <div class="col-md-12 col-xl-12">
          <h5 class="mb-3">Patients</h5>
          <div class="card tbl-card">
            <div class="card-body">
                
              <div class="table-responsive" >
                  
                    <div class="d-flex justify-content-between align-items-end mb-4">
                          <h3 class="mb-0"><b>Sign up</b></h3>
                    </div>
                  
                <table class="table table-hover table-bordered mb-0">
                  <thead>
                    <tr>
                      <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>password</th>
                        <th>Gender</th>
                        <th>Age</th>
                        <th>Address</th>
                        <th>Action</th>

    </tr>

    <%
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = new dbconfig().getConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery("SELECT * FROM patients");

            while (rs.next()) {
                int id = rs.getInt("id");
    %>
    <tr>
        <td><%= id %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("password") %></td>
        <td><%= rs.getString("gender") %></td>
        <td><%= rs.getString("age") %></td>
        <td><%= rs.getString("address") %></td>
        <td>
            <a href="editpatient.jsp?id=<%= id %>" title="Edit">
        <i class="fas fa-edit" style="color:blue; margin-right:10px;"></i>
    </a>
         <a href="<%= request.getContextPath() %>/viewpatient?id=<%= id %>" title="View">
    <i class="fas fa-eye" style="color:green;"></i>
  </a>
        
   <a href="<%= request.getContextPath() %>/deletpatient?id=<%= id %>" title="Delete" onclick="return confirm('Are you sure you want to delete this doctor?');">
    <i class="fas fa-trash-alt" style="color:red;"></i>
</a>
        <!-- View Button -->
 </td>
     
  
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println(e);
        }
    %>
</table>
              </div>
            </div>
          </div>
         </div>
      </div>
  </div>
        <%@include file="footer.jsp"%>
         