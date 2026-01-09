<%@page import="Database.dbconfig"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@include file="header.jsp" %>
  <div class="pc-container" >
      <div class="pc-content">
                 <div class="col-md-12 col-xl-12">
          <h5 class="mb-3">Add Doctor</h5>
            <div class="card tbl-card">
              <div class="card-body">
                  
                   <form action="/hospital/adddoc" method="POST">
                       
                       <div class="d-flex justify-content-between align-items-end mb-4">
                          <h3 class="mb-0"><b>Fill the Details</b></h3>
                        </div>
                       
                        <div class="row">
                            
                          <div class="col-md-6">
                            <div class="form-group mb-3">
                              <label class="form-label">Doctor Name*</label>
                              <input type="text" class="form-control" name="doctorname" placeholder="Doctor Name">
                            </div>
                          </div>
                            
                          <div class="col-md-6">
                            <div class="form-group mb-3">
                              <label class="form-label">User Name</label>
                              <input type="text" class="form-control" name="username" placeholder="User Name">
                            </div>
                          </div>
                        </div>
                       
                       <div class="row">
                           <div class="col-md-6">
                                <div class="form-group mb-6">
                                 <label class="form-label">Email</label>
                                 <input type="text" class="form-control" name="email" placeholder="  Email">
                               </div> 
                           </div>
                           <div class="col-md-6">
                            <div class="form-group mb-6">
                              <label class="form-label">Password</label>
                              <input type="text" class="form-control" name="password" placeholder="Password">
                            </div>
                           </div>
                           <div class="col-md-3">
                                <div class="form-group mb-4">
                                 <label class="form-label">Education</label>
                                 <input type="text" class="form-control" name="education" placeholder="Education">
                               </div> 
                           </div>
                           <div class="col-md-3">
                            <div class="form-group mb-4">
                              <label class="form-label">Specialization</label>
                               <select id="specialization" class="form-control"  name="specialization" required>
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
                                 <label class="form-label">Joining Date</label>
                                 <input type="date" class="form-control" name="joindate" placeholder="Date">
                               </div> 
                       </div>
                       </div>
                        <div class="form-group mb-3">
                          <label class="form-label">Phone</label>
                          <input type="text" class="form-control" name="phone" placeholder="Phone number">
                        </div>
                        
                      
                            <button type="submit" class="btn btn-primary">Add Doctor</button>
                        </div>
                  </form>  
                  
             </div>    
            </div>
        </div>
          
          
      </div>
  </div>

      </div>
  </div>
<%@include file="footer.jsp"%>
         