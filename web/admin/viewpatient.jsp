<%@page import="Database.dbconfig"%>
<%@page import="java.sql.*"%>
<%@include file="header.jsp" %>

<div class="pc-container">
<div class="pc-content">

<div class="row mt-4">
<div class="col-md-12 mb-4">
<div class="card shadow-sm p-3">
        
         <h3 class="mb-3">Appointment Details</h3>
        <hr>

        <%
            String idParam = request.getParameter("id");

            if (idParam != null && !idParam.isEmpty()) {

                try {
                    int id = Integer.parseInt(idParam);

                    Connection con = new dbconfig().getConnection();
                    PreparedStatement ps = con.prepareStatement(
                        "SELECT `id`, `doctorname`, `patientname`, `prescription`, `patientphone`, `reason` "
                        + "FROM `appointmentss` WHERE id = ?"
                    );
                    ps.setInt(1, id);

                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        String docName = rs.getString("doctorname");
                        String patientName = rs.getString("patientname");
                        String patientPhone = rs.getString("patientphone");
                        String reason = rs.getString("reason");
                        String prescription = rs.getString("prescription");
        %>

        <!-- Details Table -->
        <table class="table table-bordered">
            <thead class="table-light">
                <tr>
                    <th style="width:25%">Field</th>
                    <th>Details</th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td><strong>ID</strong></td>
                    <td><%= id %></td>
                </tr>

                <tr>
                    <td><strong>Doctor Name</strong></td>
                    <td><%= docName %></td>
                </tr>

                <tr>
                    <td><strong>Patient Name</strong></td>
                    <td><%= patientName %></td>
                </tr>

                <tr>
                    <td><strong>Patient Phone</strong></td>
                    <td><%= patientPhone %></td>
                </tr>

                <tr>
                    <td><strong>Reason</strong></td>
                    <td><%= reason %></td>
                </tr>

                <tr>
                    <td><strong>Prescription</strong></td>
                    <td>
                        <%= (prescription != null && !prescription.isEmpty())
                                ? prescription
                                : "No prescription provided" %>
                    </td>
                </tr>
            </tbody>
        </table>

        <a href="reportappointment.jsp" class="btn btn-primary mt-3">Back to Appointments</a>

        <%
                    } else {
        %>

        <div class="alert alert-warning mt-3">Appointment not found.</div>

        <%
                    }

                    rs.close();
                    ps.close();
                    con.close();

                } catch (Exception e) {
        %>

        <div class="alert alert-danger mt-3">
            Error: <%= e.getMessage() %>
        </div>

        <%
                }
            } else {
        %>

        <div class="alert alert-warning mt-3">Invalid appointment ID.</div>

        <%
            }
        %>

    </div>

</div>


    </div> <!-- card end -->

</div> <!-- container end -->
</div>
</div></div>
<%@include file="footer.jsp" %>
