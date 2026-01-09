<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.sql.*" %>
<%@ page import="Database.dbconfig" %>
<%@include file="header.jsp" %>

<div class="pc-container">
  <div class="pc-content">

<%
    String errorMessage = (String) session.getAttribute("errorMessage");
    String successMessage = (String) session.getAttribute("successMessage");
    if (errorMessage != null) {
%>
    <p class="message error-message"><%= errorMessage %></p>
<%
        session.removeAttribute("errorMessage");
    }
    if (successMessage != null) {
%>
    <p class="message success-message"><%= successMessage %></p>
<%
        session.removeAttribute("successMessage");
    }
%>

<%
    String doctorname = request.getParameter("doctorname");
    if (doctorname == null || doctorname.trim().isEmpty()) {
%>
    <p class="warning-message center-content">Doctor name is required to book slots.</p>
<%
        return;
    }

    String selectedDate = request.getParameter("selectedDate");
    if (selectedDate == null || selectedDate.trim().isEmpty()) {
%>
<div class="col-md-12 col-xl-12">
    <h5 class="mb-3">Select Date</h5>
    <div class="card tbl-card">
        <div class="card-body text-center">
            <h3 class="mb-5">Select Appointment Date</h3>

            <form method="post" action="slots.jsp" class="text-center">
                <input type="hidden" name="doctorname" value="<%= doctorname %>">

                <div class="d-flex justify-content-center">
                    <div class="form-group mb-4" style="width: 300px;">
                        <label for="selectedDate" class="form-label" style="font-size: 18px;">Pick a Date:</label>
                        <input type="date" id="selectedDate" name="selectedDate" 
                               class="form-control text-center" 
                               min="<%= java.time.LocalDate.now() %>" required>
                    </div>
                </div>

                <div class="d-flex justify-content-center">
                    <input type="submit" value="Show Slots" class="btn btn-primary">
                </div>
            </form>
        </div>
    </div>
</div>
</div></div>

<footer style="text-align:center; margin-top:30px; color:#666;">
    &copy; 2025 Clinic Management System. All rights reserved.
</footer>

<%
        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date selDateObj = sdf.parse(selectedDate);
    Calendar cal = Calendar.getInstance();
    cal.setTime(selDateObj);
    String week = new SimpleDateFormat("EEEE").format(cal.getTime());
    String displayDate = new SimpleDateFormat("MMMM dd, yyyy").format(cal.getTime());

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    List<String> morningSlots = new ArrayList<String>();
    List<String> eveningSlots = new ArrayList<String>();
    Set<String> bookedSlots = new HashSet<String>();

    String m_start = "", m_end = "", e_start = "", e_end = "";
    int totalSlots = 0;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = new dbconfig().getConnection();

        // Get schedule
        pst = con.prepareStatement("SELECT m_start, m_end, e_start, e_end, slot FROM doctor_schedule WHERE doctorname = ? AND week = ?");
        pst.setString(1, doctorname);
        pst.setString(2, week);
        rs = pst.executeQuery();
        if (rs.next()) {
            m_start = rs.getString("m_start");
            m_end = rs.getString("m_end");
            e_start = rs.getString("e_start");
            e_end = rs.getString("e_end");
            totalSlots = rs.getInt("slot");
        }
        rs.close();
        pst.close();

        // Get booked slots
        pst = con.prepareStatement("SELECT a_Time FROM appointmentss WHERE doctorname = ? AND a_Date = ? AND patientname NOT IN ('BLOCKED','absent')");
        pst.setString(1, doctorname);
        pst.setString(2, selectedDate);
        rs = pst.executeQuery();
        while (rs.next()) {
            bookedSlots.add(rs.getString("a_Time"));
        }
        rs.close();
        pst.close();

        SimpleDateFormat sdf24 = new SimpleDateFormat("HH:mm");
        SimpleDateFormat sdf12 = new SimpleDateFormat("hh:mm a");
        Calendar slotCal = Calendar.getInstance();

        int morningCount = totalSlots / 2;
        int eveningCount = totalSlots - morningCount;

        // Morning
        if (morningCount > 0 && m_start != null && !m_start.equalsIgnoreCase("absent") && m_end != null && !m_end.equalsIgnoreCase("absent")) {
            java.util.Date start = sdf24.parse(m_start);
            java.util.Date end = sdf24.parse(m_end);
            long diff = end.getTime() - start.getTime();
            int interval = (int)(diff / morningCount / (60 * 1000));
            slotCal.setTime(start);
            for (int i = 0; i < morningCount; i++) {
                String time24 = sdf24.format(slotCal.getTime());
                String time12 = sdf12.format(slotCal.getTime());
                morningSlots.add(time12 + "||" + time24);
                slotCal.add(Calendar.MINUTE, interval);
            }
        }

        // Evening
        if (eveningCount > 0 && e_start != null && !e_start.equalsIgnoreCase("absent") && e_end != null && !e_end.equalsIgnoreCase("absent")) {
            java.util.Date start = sdf24.parse(e_start);
            java.util.Date end = sdf24.parse(e_end);
            long diff = end.getTime() - start.getTime();
            int interval = (int)(diff / eveningCount / (60 * 1000));
            slotCal.setTime(start);
            for (int i = 0; i < eveningCount; i++) {
                String time24 = sdf24.format(slotCal.getTime());
                String time12 = sdf12.format(slotCal.getTime());
                eveningSlots.add(time12 + "||" + time24);
                slotCal.add(Calendar.MINUTE, interval);
            }
        }
    } catch (Exception e) {
        out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch(Exception e) {}
        try { if (pst != null) pst.close(); } catch(Exception e) {}
        try { if (con != null) con.close(); } catch(Exception e) {}
    }
%>

<style>
  .slot-box input[type="radio"] { display: none; }
  .slot-box {
    border: 2px solid #007bff;
    border-radius: 10px;
    padding: 15px;
    font-weight: bold;
    color: #007bff;
    background-color: white;
    cursor: pointer;
    transition: all 0.3s ease;
  }
  .slot-box:hover { background-color: #e6f0ff; }
  .slot-box input[type="radio"]:checked + .slot-span {
    background-color: #007bff;
    color: white;
    border-radius: 8px;
    padding: 5px 10px;
  }
  .slot-box.disabled {
    background-color: #f44336;
    color: white;
    border-color: #a94442;
    cursor: not-allowed;
    pointer-events: none;
  }
  .slot-span.booked { text-decoration: line-through; }
</style>

<div class="col-md-12 col-xl-12">
  <h5 class="mb-3">Slots for</h5>
  <div class="card tbl-card">
    <div class="card-body text-center">
      <div class="container">
        <div class="content">
          <h3 class="mb-5">
            <strong><%= doctorname %></strong> on <strong><%= week %></strong>, <strong><%= displayDate %></strong>
          </h3>

          <!-- Booking Form -->
          <form action="../bookapp" method="post">
            <input type="hidden" name="doctorname" value="<%= doctorname %>">
            <input type="hidden" name="selectedDate" value="<%= selectedDate %>">
            <input type="hidden" name="week" value="<%= week %>">

            <!-- Morning Slots -->
            <div class="col-md-12 col-xl-12 mb-4">
              <div class="card shadow-sm">
                <div class="card-body">
                  <h5 class="card-title mb-3">Morning Slots</h5>
                  <% if (morningSlots.size() > 0) { %>
                    <div class="row">
                      <% for (int i = 0; i < morningSlots.size(); i++) {
                           String[] parts = morningSlots.get(i).split("\\|\\|");
                           String displayTime = parts[0];
                           String valueTime = parts[1];
                           boolean isBooked = bookedSlots.contains(valueTime);
                      %>
                        <div class="col-md-3 col-sm-6 mb-3">
                          <label class="slot-box w-100 text-center <%= isBooked ? "disabled" : "" %>">
                            <input type="radio" name="time" value="<%= valueTime %>" <%= isBooked ? "disabled" : "required" %>>
                            <span class="slot-span <%= isBooked ? "booked" : "" %>"><%= displayTime %></span>
                          </label>
                        </div>
                      <% } %>
                    </div>
                  <% } else { %>
                    <p class="text-danger fw-bold text-center">No Morning Slots Available</p>
                  <% } %>
                </div>
              </div>
            </div>

            <!-- Evening Slots -->
            <div class="col-md-12 col-xl-12 mb-4">
              <div class="card shadow-sm">
                <div class="card-body">
                  <h5 class="card-title mb-3">Evening Slots</h5>
                  <% if (eveningSlots.size() > 0) { %>
                    <div class="row">
                      <% for (int i = 0; i < eveningSlots.size(); i++) {
                           String[] parts = eveningSlots.get(i).split("\\|\\|");
                           String displayTime = parts[0];
                           String valueTime = parts[1];
                           boolean isBooked = bookedSlots.contains(valueTime);
                      %>
                        <div class="col-md-3 col-sm-6 mb-3">
                          <label class="slot-box w-100 text-center <%= isBooked ? "disabled" : "" %>">
                            <input type="radio" name="time" value="<%= valueTime %>" <%= isBooked ? "disabled" : "required" %>>
                            <span class="slot-span <%= isBooked ? "booked" : "" %>"><%= displayTime %></span>
                          </label>
                        </div>
                      <% } %>
                    </div>
                  <% } else { %>
                    <p class="text-danger fw-bold text-center">No Evening Slots Available</p>
                  <% } %>
                </div>
              </div>
            </div>

                            <!-- Patient Details -->
                <div class="container" style="margin-top: 20px;">
                  <div class="row justify-content-center">
                    <div class="col-md-3">
                      <div class="form-group mb-3 text-center">
                        <label class="form-label">Patient Name:</label>
                        <input type="text" class="form-control text-center" name="patientname" placeholder="Enter Patient Name" required>
                      </div>
                    </div>
                    <div class="col-md-3">
                      <div class="form-group mb-3 text-center">
                        <label class="form-label">Patient Phone Number:</label>
                        <input type="text" class="form-control text-center" name="patientphone"
                               placeholder="Enter Patient Phone Number" required
                               pattern="[0-9]{10}" maxlength="10" title="Enter a 10-digit phone number">
                      </div>
                    </div>
                  </div>

                  <!-- Reason for multiple bookings -->
                  <div class="row justify-content-center">
                    <div class="col-md-6">
                      <div class="form-group mb-3 text-center">
                        <label class="form-label">Reason for Booking Again (if applicable):</label>
                        <select name="reason" class="form-control text-center">
                          <option value="N/A">-- Select Reason --</option>
                          <option value="Follow-up Consultation">Follow-up Consultation</option>
                          <option value="New Health Concern">New Health Concern</option>
                          <option value="Report Discussion">Report Discussion</option>
                          <option value="Emergency Visit">Emergency Visit</option>
                          <option value="Other">Other</option>
                        </select>
                      </div>
                    </div>
                  </div>

                  <div class="row justify-content-center">
                    <div class="col-md-3">
                      <input type="submit" value="Book Slot" class="btn btn-primary" style="width: 100%;">
                    </div>
                  </div>
                  <br>

                  <!-- Back to Select Date Button -->
                  <div class="mb-4 text-center">
                    <a href="slots.jsp?doctorname=<%= doctorname %>" class="btn btn-secondary">
                      &larr; Back to Select Date
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </form>

        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
