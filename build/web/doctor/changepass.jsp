<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div class="pc-container">
  <div class="pc-content">
    <div class="container">
      <div class="row justify-content-center mt-5">
        <div class="col-md-10 col-lg-6">
          <div class="card shadow-sm border">
            <div class="card-body">
              <h3 class="mb-4 text-center">Change Password</h3>
             <form action="<%=request.getContextPath()%>/changepass" method="post">

                <!-- Current Password -->
                <div class="mb-3">
                  <label for="oldpass" class="form-label">Current Password</label>
                  <input type="password" class="form-control" id="oldpass" name="oldpass" required>
                </div>

                <!-- New Password -->
                <div class="mb-3">
                  <label for="newpass" class="form-label">New Password</label>
                  <input type="password" class="form-control" id="newpass" name="newpass" required>
                </div>

                <!-- Confirm Password -->
                <div class="mb-3">
                  <label for="confirmpass" class="form-label">Confirm New Password</label>
                  <input type="password" class="form-control" id="confirmpass" name="confirmpass" required>
                </div>

                <!-- Submit -->
                <div class="d-grid">
                  <button type="submit" class="btn btn-primary">Update Password</button>
                </div>

              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
