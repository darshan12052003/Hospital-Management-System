<%@page import="java.sql.PreparedStatement"%>
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
                          <h3 class="mb-0"><b> Available Doctors</b></h3>
                    </div>
                  
                <table class="table table-hover table-bordered mb-0">
                  <thead>
                    <tr>
                     <th>Doctor Name</th>
                        <th>Education</th>
                        <th>Specialization</th>
                        <th>Action</th>

        </tr>
        <%
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet res = null;
            try {
                con = new dbconfig().getConnection();
                pst = con.prepareStatement("SELECT doctorname, education, specialization FROM doctor");
                res = pst.executeQuery();
                while (res.next()) {
                    String doctorname = res.getString("doctorname");
                    String education = res.getString("education");
                    String specialization = res.getString("specialization");
        %>
            <tr>
                <td><%= doctorname %></td>
                <td><%= education %></td>
                <td><%= specialization %></td>
                <td>
                    <!-- Either a button inside a form or a simple link -->
                    <form action="slots.jsp" method="get" style="margin: 0;">
                        <input type="hidden" name="doctorname" value="<%=doctorname %>" />
                        <button type="submit"class="btn" style="background-color: limegreen; color:white; " >Book</button>
                    </form>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
        %>
            <tr>
                <td colspan="4" style="color: red; text-align: center;">
                    Error loading doctors: <%= e.getMessage() %>
                </td>
            </tr>
        <%
            } finally {
                try { if (res != null) res.close(); } catch (Exception ignored) {}
                try { if (pst != null) pst.close(); } catch (Exception ignored) {}
                try { if (con != null) con.close(); } catch (Exception ignored) {}
            }
        %>
        </tbody>
    </table>
</div>

          
      </div>
  </div>

      </div>
  </div>
<%@include file="footer.jsp"%>
         