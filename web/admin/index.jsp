<%@include file="header.jsp" %>
  <div class="pc-container" >
      <div class="pc-content">
          
        <div class="col-md-12 col-xl-12">
          <h5 class="mb-3">Recent Orders</h5>
          <div class="card tbl-card">
            <div class="card-body">
                
              <div class="table-responsive" >
                  
                    <div class="d-flex justify-content-between align-items-end mb-4">
                          <h3 class="mb-0"><b>Sign up</b></h3>
                    </div>
                  
                <table class="table table-hover table-bordered mb-0">
                  <thead>
                    <tr>
                      <th>TRACKING NO.</th>
                      <th>PRODUCT NAME</th>
                      <th>TOTAL ORDER</th>
                      <th>STATUS</th>
                      <th class="text-end">TOTAL AMOUNT</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Camera Lens</td>
                      <td>40</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-danger f-10 m-r-5"></i>Rejected</span>
                      </td>
                      <td class="text-end">$40,570</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Laptop</td>
                      <td>300</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-warning f-10 m-r-5"></i>Pending</span>
                      </td>
                      <td class="text-end">$180,139</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Mobile</td>
                      <td>355</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-success f-10 m-r-5"></i>Approved</span></td>
                      <td class="text-end">$180,139</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Camera Lens</td>
                      <td>40</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-danger f-10 m-r-5"></i>Rejected</span>
                      </td>
                      <td class="text-end">$40,570</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Laptop</td>
                      <td>300</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-warning f-10 m-r-5"></i>Pending</span>
                      </td>
                      <td class="text-end">$180,139</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Mobile</td>
                      <td>355</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-success f-10 m-r-5"></i>Approved</span></td>
                      <td class="text-end">$180,139</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Camera Lens</td>
                      <td>40</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-danger f-10 m-r-5"></i>Rejected</span>
                      </td>
                      <td class="text-end">$40,570</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Laptop</td>
                      <td>300</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-warning f-10 m-r-5"></i>Pending</span>
                      </td>
                      <td class="text-end">$180,139</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Mobile</td>
                      <td>355</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-success f-10 m-r-5"></i>Approved</span></td>
                      <td class="text-end">$180,139</td>
                    </tr>
                    <tr>
                      <td><a href="#" class="text-muted">84564564</a></td>
                      <td>Mobile</td>
                      <td>355</td>
                      <td><span class="d-flex align-items-center gap-2"><i
                            class="fas fa-circle text-success f-10 m-r-5"></i>Approved</span></td>
                      <td class="text-end">$180,139</td>
                    </tr>
                  </tbody>
                </table>
              </div>
                
            </div>
          </div>
        </div>
          
          
        <div class="col-md-12 col-xl-12">
          <h5 class="mb-3">Recent Orders</h5>
            <div class="card tbl-card">
              <div class="card-body">
                  
                   <form action="/final/creg" method="POST">
                       
                       <div class="d-flex justify-content-between align-items-end mb-4">
                          <h3 class="mb-0"><b>Sign up</b></h3>
                        </div>
                       
                        <div class="row">
                            
                          <div class="col-md-6">
                            <div class="form-group mb-3">
                              <label class="form-label">First Name*</label>
                              <input type="text" class="form-control" name="fname" placeholder="First Name">
                            </div>
                          </div>
                            
                          <div class="col-md-6">
                            <div class="form-group mb-3">
                              <label class="form-label">Last Name</label>
                              <input type="text" class="form-control" name="lname" placeholder="Last Name">
                            </div>
                          </div>
                        </div>
                       
                       <div class="row">
                           <div class="col-md-3">
                                <div class="form-group mb-3">
                                 <label class="form-label">Meter Number</label>
                                 <input type="number" class="form-control" name="meter" placeholder="Meter Number">
                               </div> 
                           </div>
                           <div class="col-md-3">
                            <div class="form-group mb-3">
                              <label class="form-label">Address</label>
                              <input type="text" class="form-control" name="add" placeholder="Address">
                            </div>
                           </div>
                           <div class="col-md-3">
                                <div class="form-group mb-3">
                                 <label class="form-label">Meter Number</label>
                                 <input type="number" class="form-control" name="meter" placeholder="Meter Number">
                               </div> 
                           </div>
                           <div class="col-md-3">
                            <div class="form-group mb-3">
                              <label class="form-label">Address</label>
                              <input type="text" class="form-control" name="add" placeholder="Address">
                            </div>
                           </div>
                       </div>
                       
                        <div class="form-group mb-3">
                          <label class="form-label">City</label>
                          <input type="text" class="form-control" name="city" placeholder="Address">
                        </div>
                        <div class="form-group mb-3">
                          <label class="form-label">State</label>
                          <input type="text" class="form-control" name="state" placeholder="Contact Number">
                        </div>
                        <div class="form-group mb-3">
                          <label class="form-label">Email Address*</label>
                          <input type="email" class="form-control" name="email" placeholder="Email Address">
                        </div>
                         <div class="form-group mb-3">
                          <label class="form-label">Number</label>
                          <input type="number" class="form-control" name="num" placeholder="Number">
                        </div>
                          <div class="form-group mb-3">
                          <label class="form-label">Meter Location</label>
                          <input type="text" class="form-control" name="loc" placeholder="Meter Location">
                            </div>
                          <div class="form-group mb-3">
                          <label class="form-label">Meter Type</label>
                          <input type="text" class="form-control" name="mtype" placeholder="Meter Type">
                        </div>
                          <div class="form-group mb-3">
                          <label class="form-label">Phase Code</label>
                          <input type="text" class="form-control" name="pcode" placeholder="Phase Code">
                        </div>
                          <div class="form-group mb-3">
                          <label class="form-label">Bill Type</label>
                          <input type="text" class="form-control" name="btype" placeholder="Bill type">
                        </div>
                        <div class="form-group mb-3">
                          <label class="form-label">Password</label>
                          <input type="password" class="form-control" name="pass" placeholder="Password">
                        </div>
                        <p class="mt-4 text-sm text-muted">By Signing up, you agree to our <a href="#" class="text-primary"> Terms of Service </a> and <a href="#" class="text-primary"> Privacy Policy</a></p>
                        <div class="d-grid mt-3">
                            <button type="submit" class="btn btn-primary">Create Account</button>
                        </div>
                  </form>  
                  
             </div>    
            </div>
        </div>
          
          
      </div>
  </div>

<%@include file="footer.jsp" %>