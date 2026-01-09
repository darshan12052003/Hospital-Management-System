<%@page import="Database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@include file="header.jsp" %>

<%
    // Session validation (make sure uname is set, e.g., from session)
    String name = "";
    String email = "";
    String gender = "";
    int age = 0;
    String phone = "";
    String address = "";
    String errorMsg = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = new dbconfig().getConnection();

        String sql = "SELECT name, email, gender, age, phone, address FROM patients WHERE name = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, uname);  // Ensure 'uname' is available from session or request

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            gender = rs.getString("gender");
            age = rs.getInt("age");
            phone = rs.getString("phone");
            address = rs.getString("address");
        } else {
            errorMsg = "No patient data found for user: " + uname;
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        errorMsg = "Database error: " + e.getMessage();
        e.printStackTrace();
    }
%>

<!-- ? Start of the required layout -->
<div class="pc-container">
  <div class="pc-content">
    <div class="row justify-content-center">
      <div class="col-md-10 col-lg-8">
        <div class="card shadow-sm border p-4">
          <h3 class="mb-4">My Profile</h3>

          <% if (errorMsg != null) { %>
              <div class="alert alert-danger"><%= errorMsg %></div>
          <% } else { %>
              <table class="table table-striped">
                  <tr><th>Name:</th><td><%= name %></td></tr>
                  <tr><th>Email:</th><td><%= email %></td></tr>
                  <tr><th>Gender:</th><td><%= gender %></td></tr>
                  <tr><th>Age:</th><td><%= age %></td></tr>
                  <tr><th>Phone:</th><td><%= phone %></td></tr>
                  <tr><th>Address:</th><td><%= address %></td></tr>
              </table>
          <% } %>

        </div>
      </div>
    </div>
  </div>
</div>
<!-- ? End of layout -->

<%@include file="footer.jsp" %>
