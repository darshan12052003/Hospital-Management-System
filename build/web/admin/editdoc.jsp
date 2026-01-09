<%@page import="Database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@include file="header.jsp" %>
  <div class="pc-container" >
      <div class="pc-content">
          
           <%
                String doctorId = request.getParameter("id");
                String doctorname = "", username = "", password = "", email = "",education="", specialization = "",joindate = "",phone = "";

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = new dbconfig().getConnection();
                    Statement stat = con.createStatement();
                    ResultSet res = stat.executeQuery("SELECT * FROM doctor WHERE id=" + doctorId);

                    if (res.next()) {
                        doctorname = res.getString("doctorname");
                        username = res.getString("username");
                        email = res.getString("email");
                        password = res.getString("password");
                        education=res.getString("education");
                        specialization = res.getString("specialization");
                        joindate = res.getString("joindate");
                        phone = res.getString("phone");
                    }

                    
                } catch (Exception e) {
                    out.print(e);
                }
            %>
            
            <div class="col-md-12 col-xl-12">
          <h5 class="mb-3">Edit Doctor</h5>
            <div class="card tbl-card">
              <div class="card-body">
                  
                        <form action="<%= request.getContextPath() %>/updatedoc" method="POST">
                        <input type="hidden" name="id" value="<%=doctorId%>">

                       <div class="d-flex justify-content-between align-items-end mb-4">
                          <h3 class="mb-0"><b>Edit the Details</b></h3>
                        </div>
                       
                        <div class="row">
                            
                             
                            
                          <div class="col-md-6">
                            <div class="form-group mb-3">
                              <label class="form-label">Doctor Name*</label>
                              <input type="text" class="form-control" name="doctorname" value="<%=doctorname%>">
                            </div>
                          </div>
                            
                          <div class="col-md-6">
                            <div class="form-group mb-3">
                              <label class="form-label">User Name</label>
                              <input type="text" class="form-control" name="username" value="<%=username%>">
                            </div>
                          </div>
                        </div>
                       
                       <div class="row">
                           <div class="col-md-6">
                                <div class="form-group mb-6">
                                 <label class="form-label">Email</label>
                                 <input type="text" class="form-control" name="email" value="<%=email%>">
                               </div> 
                           </div>
                           <div class="col-md-6">
                            <div class="form-group mb-6">
                              <label class="form-label">Password</label>
                              <input type="number" class="form-control" name="password" value="<%=password%>">
                            </div>
                           </div>
                           <div class="col-md-3">
                                <div class="form-group mb-3">
                                 <label class="form-label">Education</label>
                                 <input type="text" class="form-control" name="education" value="<%=education%>">
                               </div> 
                           </div>
                           <div class="col-md-3">
                            <div class="form-group mb-3">
                              <label class="form-label">Specialization</label>
                               <select id="specialization" class="form-control"  name="specialization" value="<%=specialization%>">
                                <option value="">-- Select --</option>
                                <option value="Cardiologist">Cardiologist</option>
                                <option value="Dermatologist">Dermatologist</option>
                                <option value="Neurologist">Neurologist</option>
                                <option value="Pediatrician">Pediatrician</option>
                                <option value="General Physician">General Physician</option>
                            </select>

                              
                            </div>
                           </div>
                                 <div class="col-md-3">
                                <div class="form-group mb-4">
                                 <label class="form-label">Join Date</label>
                                 <input type="date" class="form-control" name="joindate" value="<%=joindate%>">
                               </div> 
                       </div>
                       </div>
                       
                        <div class="form-group mb-3">
                          <label class="form-label">Phone</label>
                          <input type="number" class="form-control" name="phone" value="<%=phone%>">
                        </div>
                        
                      
                            <button type="submit" class="btn btn-primary">Submit</button>
                         </form>
              </div>  
                  
            </div>
          </div>
            </div>
      </div>
  <%@include file="footer.jsp"%>
         