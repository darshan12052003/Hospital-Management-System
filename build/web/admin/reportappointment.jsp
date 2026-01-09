<%@page import="Database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@include file="header.jsp" %>

<div class="pc-container">
<div class="pc-content">

<div class="row mt-4">
<div class="col-md-12 mb-4">
<div class="card shadow-sm p-3">

<h3>Appointments</h3>
<hr>

<!-- Filter Form -->
<form method="get" id="filterForm" class="d-flex align-items-center gap-3 mb-4">

    <!-- Doctor Filter -->
    <label for="doctor">Doctor:</label>
    <select name="doctor" id="doctor" class="form-select" onchange="document.getElementById('filterForm').submit()">
        <option value="">All Doctors</option>

        <%
            try {
                Connection con2 = new dbconfig().getConnection();
                Statement st2 = con2.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT DISTINCT doctorname FROM appointmentss ORDER BY doctorname ASC");

                String selectedDoctor = request.getParameter("doctor");

                while(rs2.next()) {
                    String dn = rs2.getString("doctorname");
        %>
            <option value="<%= dn %>" <%= dn.equals(selectedDoctor) ? "selected" : "" %>><%= dn %></option>
        <%
                }
                rs2.close(); st2.close(); con2.close();
            } catch(Exception e) {}
        %>
    </select>

    <!-- Date Range -->
    <label for="fromDate">From:</label>
    <input type="date" name="fromDate" id="fromDate" class="form-control"
           value="<%= request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>"
           onchange="document.getElementById('filterForm').submit()">

    <label for="toDate">To:</label>
    <input type="date" name="toDate" id="toDate" class="form-control"
           value="<%= request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>"
           onchange="document.getElementById('filterForm').submit()">

</form>

</div></div></div>


<!-- Appointment Table -->
<div class="row mt-4">
<div class="col-md-12 mb-4">
<div class="card shadow-sm p-3">

<div class="table-responsive">

<%
    String doctor = request.getParameter("doctor");
    String fromDate = request.getParameter("fromDate");
    String toDate   = request.getParameter("toDate");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Date today = new Date();

    Connection con = null;
    Statement stat = null;
    ResultSet res = null;

    try {
        con = new dbconfig().getConnection();
        stat = con.createStatement();

        String query = "SELECT * FROM appointmentss WHERE 1=1 ";

        // Date Range Filter
        if(fromDate != null && !fromDate.isEmpty() &&
           toDate != null && !toDate.isEmpty()) {

            query += " AND a_Date BETWEEN '" + fromDate + "' AND '" + toDate + "' ";
        }

        // Doctor Filter
        if(doctor != null && !doctor.isEmpty()) {
            query += " AND doctorname = '" + doctor + "' ";
        }

        // Sorting
        query += " ORDER BY doctorname ASC, " +
                 "STR_TO_DATE(a_Date, '%Y-%m-%d') ASC, " +
                 "STR_TO_DATE(a_Time, '%h:%i %p') ASC ";

        res = stat.executeQuery(query);

        String lastDoctor = "";
        boolean firstDoctor = true;

        while(res.next()) {
            int id = res.getInt("id");
            String patientname = res.getString("patientname");
            String doctorname = res.getString("doctorname");
            String a_Date = res.getString("a_Date");
            String a_Time = res.getString("a_Time");

            if(!doctorname.equals(lastDoctor)) {
                if(!firstDoctor) {
%>
                </tbody></table>
<%
                }
%>
                <h4 class="mt-4 mb-3 text-primary"><b>Doctor: <%= doctorname %></b></h4>
                <table class="table table-hover table-bordered mb-3">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Patient</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
<%
                lastDoctor = doctorname;
                firstDoctor = false;
            }
%>

<tr>
    <td><%= id %></td>
    <td><%= patientname %></td>
    <td><%= a_Date %></td>
    <td><%= a_Time %></td>
    <td>
        <a href="<%= request.getContextPath() %>/deletapp?id=<%= id %>"
           onclick="return confirm('Are you sure you want to delete this Appointment?');">
            <i class="fas fa-trash-alt" style="color:red;"></i>
     
        </a>
            <a href="<%= request.getContextPath() %>/admin/viewpatient.jsp?id=<%= id %>" title="View">
    <i class="fas fa-eye" style="color:green;"></i>
  </a>
    </td>
</tr>

<%
        }

        if(!firstDoctor) {
%>
            </tbody></table>
<%
        } else {
%>
            <div class="alert alert-info">No appointments found.</div>
<%
        }

        res.close(); stat.close(); con.close();

    } catch(Exception e) {
%>

<div class="alert alert-danger">Error: <%= e.getMessage() %></div>

<%
    }
%>

</div></div></div></div></div></div>

<%@include file="footer.jsp" %>
