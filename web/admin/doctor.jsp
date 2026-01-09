<%@page import="Database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@include file="header.jsp" %>
  <div class="pc-container" >
      <div class="pc-content">
          
            <div class="col-md-12 col-xl-12">
          <h5 class="mb-3">Doctors</h5>
          <div class="card tbl-card">
            <div class="card-body">
                
              <div class="table-responsive" >
                  
                    <div class="d-flex justify-content-between align-items-end mb-4">
                          <h3 class="mb-0"><b>Sign up</b></h3>
                    </div>
                  
                <table class="table table-hover table-bordered mb-0">
                  <thead>
                    <tr>
            <th>Slno</th>
            <th>Name</th>
            <th>Username</th>
            <th>Email</th>
            <th>Education</th>
            <th>Specialization</th>
            <th>joindate</th>
            <th>Phone</th>
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
                rs = stmt.executeQuery("SELECT * FROM doctor");

                while (rs.next()) {
                    int id = rs.getInt("id");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= rs.getString("doctorname") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("education") %></td>
            <td><%= rs.getString("specialization") %></td>
            <td><%= rs.getString("joindate") %></td>
            <td><%= rs.getString("phone") %></td>
            <td>
              
    <a href="editdoc.jsp?id=<%= id %>" title="Edit">
        <i class="fas fa-edit" style="color:blue; margin-right:10px;"></i>
    </a>
   <a href="<%= request.getContextPath() %>/deletdoc?id=<%= id %>" title="Delete" onclick="return confirm('Are you sure you want to delete this doctor?');">
    <i class="fas fa-trash-alt" style="color:red;"></i>
</a>



            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='7'>" + e + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
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
         