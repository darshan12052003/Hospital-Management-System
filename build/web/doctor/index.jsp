<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="Database.dbconfig" %>
<%@ include file="header.jsp" %>

<%
    // SESSION CHECK
    if (hs == null || hs.getAttribute("dname") == null) {
        response.sendRedirect("dlogout");
        return;
    }
    String username = (String) hs.getAttribute("dname");
    if (username == null || username.trim().isEmpty()) {
        response.sendRedirect("dlogout");
        return;
    }

    // If doctorFullName was declared in header.jsp, do not redeclare it; only assign if null
    if (doctorFullName == null) {
        doctorFullName = "";
    }

    int totalAppointments = 0;
    int totalPatients = 0;
    int todayAppointments = 0;

    // Data maps
    Map dailyAppointmentsMap = new LinkedHashMap();        // for today?s chart (by time)
    Map monthAppointmentCounts = new LinkedHashMap();     // for monthly chart
    Map yearAppointmentCounts = new LinkedHashMap();      // for yearly chart

    // Initialize month map with 0 counts
    String[] monthsLabels = { "Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec" };
    for (int i = 0; i < monthsLabels.length; i++) {
        monthAppointmentCounts.put(monthsLabels[i], new Integer(0));
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // Load driver
        Class.forName("com.mysql.jdbc.Driver");
        con = new dbconfig().getConnection();

        // 1. Get doctorFullName from doctor table
        ps = con.prepareStatement("SELECT doctorname FROM doctor WHERE username = ?");
        ps.setString(1, username);
        rs = ps.executeQuery();
        if (rs.next()) {
            doctorFullName = rs.getString("doctorname");
        } else {
            // No matching doctor ? force logout
            rs.close();
            ps.close();
            response.sendRedirect("dlogout");
            return;
        }
        rs.close();
        ps.close();

        // 2. Total appointments
        ps = con.prepareStatement("SELECT COUNT(*) FROM appointmentss WHERE doctorname = ?");
        ps.setString(1, doctorFullName);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalAppointments = rs.getInt(1);
        }
        rs.close();
        ps.close();

        // 3. Total distinct patients
        ps = con.prepareStatement("SELECT COUNT(DISTINCT patientphone) FROM appointmentss WHERE doctorname = ?");
        ps.setString(1, doctorFullName);
        rs = ps.executeQuery();
        if (rs.next()) {
            totalPatients = rs.getInt(1);
        }
        rs.close();
        ps.close();

        // 4. Today?s total appointments (just a number)
        ps = con.prepareStatement("SELECT COUNT(*) FROM appointmentss WHERE doctorname = ? AND a_Date = CURDATE()");
        ps.setString(1, doctorFullName);
        rs = ps.executeQuery();
        if (rs.next()) {
            todayAppointments = rs.getInt(1);
        }
        rs.close();
        ps.close();

        // 5. Today?s appointments by time (for new chart)
        ps = con.prepareStatement(
            "SELECT a_Time, COUNT(*) AS cnt " +
            "FROM appointmentss " +
            "WHERE doctorname = ? AND a_Date = CURDATE() " +
            "GROUP BY a_Time " +
            "ORDER BY STR_TO_DATE(a_Time, '%h:%i %p')"
        );
        ps.setString(1, doctorFullName);
        rs = ps.executeQuery();
        while (rs.next()) {
            String time = rs.getString("a_Time");
            int cnt = rs.getInt("cnt");
            dailyAppointmentsMap.put(time, new Integer(cnt));
        }
        rs.close();
        ps.close();

        // 6. Monthly appointments
        ps = con.prepareStatement(
            "SELECT DATE_FORMAT(a_Date,'%b') AS mon, COUNT(*) AS cnt " +
            "FROM appointmentss " +
            "WHERE doctorname = ? " +
            "GROUP BY YEAR(a_Date), MONTH(a_Date) " +
            "ORDER BY YEAR(a_Date), MONTH(a_Date)"
        );
        ps.setString(1, doctorFullName);
        rs = ps.executeQuery();
        while (rs.next()) {
            String mon = rs.getString("mon");
            int cnt = rs.getInt("cnt");
            if (monthAppointmentCounts.containsKey(mon)) {
                monthAppointmentCounts.put(mon, new Integer(cnt));
            }
        }
        rs.close();
        ps.close();

        // 7. Yearly appointments
        ps = con.prepareStatement(
            "SELECT YEAR(a_Date) AS yr, COUNT(*) AS cnt " +
            "FROM appointmentss " +
            "WHERE doctorname = ? " +
            "GROUP BY YEAR(a_Date) " +
            "ORDER BY YEAR(a_Date)"
        );
        ps.setString(1, doctorFullName);
        rs = ps.executeQuery();
        while (rs.next()) {
            String yr = rs.getString("yr");
            int cnt = rs.getInt("cnt");
            yearAppointmentCounts.put(yr, new Integer(cnt));
        }
        rs.close();
        ps.close();

    } catch (Exception e) {
        out.println("<pre style='color:red;'>Error: " + e.getMessage() + "</pre>");
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }

    // Convert daily map to JS arrays
    StringBuilder jsDailyLabels = new StringBuilder();
    StringBuilder jsDailyData = new StringBuilder();
    {
        Iterator it = dailyAppointmentsMap.entrySet().iterator();
        int idx = 0;
        int size = dailyAppointmentsMap.size();
        while (it.hasNext()) {
            Map.Entry entry = (Map.Entry) it.next();
            jsDailyLabels.append("'").append(entry.getKey()).append("'");
            jsDailyData.append(entry.getValue());
            if (idx < size - 1) {
                jsDailyLabels.append(",");
                jsDailyData.append(",");
            }
            idx++;
        }
    }

    // Convert monthly map to JS arrays
    StringBuilder jsMonthLabels = new StringBuilder();
    StringBuilder jsMonthData = new StringBuilder();
    for (int i = 0; i < monthsLabels.length; i++) {
        String m = monthsLabels[i];
        jsMonthLabels.append("'").append(m).append("'");
        jsMonthData.append(monthAppointmentCounts.get(m));
        if (i < monthsLabels.length - 1) {
            jsMonthLabels.append(",");
            jsMonthData.append(",");
        }
    }

    // Convert yearly map to JS arrays
    StringBuilder jsYearLabels = new StringBuilder();
    StringBuilder jsYearData = new StringBuilder();
    {
        Iterator it2 = yearAppointmentCounts.entrySet().iterator();
        int idx2 = 0;
        int size2 = yearAppointmentCounts.size();
        while (it2.hasNext()) {
            Map.Entry entry = (Map.Entry) it2.next();
            jsYearLabels.append("'").append(entry.getKey()).append("'");
            jsYearData.append(entry.getValue());
            if (idx2 < size2 - 1) {
                jsYearLabels.append(",");
                jsYearData.append(",");
            }
            idx2++;
        }
    }
%>

<div class="pc-container">
  <div class="pc-content">
    <div class="card shadow-sm border p-4">
      <h2>Welcome, Dr. <%= doctorFullName %></h2>

      <!-- Summary Cards -->
      <div class="row mt-4">
        <div class="col-md-4 mb-3">
          <div class="card text-black shadow-sm h-100">
            <div class="card-body text-center">
              <h5 class="card-title">Total Appointments</h5>
              <h3><%= totalAppointments %></h3>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-3">
          <div class="card text-black shadow-sm h-100">
            <div class="card-body text-center">
              <h5 class="card-title">Total Patients</h5>
              <h3><%= totalPatients %></h3>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-3">
          <div class="card text-black shadow-sm h-100">
            <div class="card-body text-center">
              <h5 class="card-title">Today's Appointments</h5>
              <h3><%= todayAppointments %></h3>
            </div>
          </div>
        </div>
      </div>

      <!-- Today's Appointments Chart -->
      <div class="row mt-4">
        <div class="col-md-12">
          <div class="card shadow-sm p-3">
            <h5>Today's Appointments by Time</h5>
            <div style="position: relative; width:100%; height:300px;">
              <canvas id="dailyChart"></canvas>
            </div>
          </div>
        </div>
      </div>

      <!-- Monthly Chart -->
      <div class="row mt-4">
        <div class="col-md-12">
          <div class="card shadow-sm p-3">
            <h5>Monthly Appointments</h5>
            <div style="position: relative; width:100%; height:300px;">
              <canvas id="monthChart"></canvas>
            </div>
          </div>
        </div>
      </div>

      <!-- Yearly Chart -->
      <div class="row mt-4">
        <div class="col-md-12">
          <div class="card shadow-sm p-3">
            <h5>Yearly Appointments</h5>
            <div style="position: relative; width:100%; height:300px;">
              <canvas id="yearChart"></canvas>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const dailyLabels = [ <%= jsDailyLabels.toString() %> ];
    const dailyData = [ <%= jsDailyData.toString() %> ];
    const monthLabels = [ <%= jsMonthLabels.toString() %> ];
    const monthData = [ <%= jsMonthData.toString() %> ];
    const yearLabels = [ <%= jsYearLabels.toString() %> ];
    const yearData = [ <%= jsYearData.toString() %> ];

    // Daily chart
    new Chart(document.getElementById('dailyChart'), {
        type: 'bar',
        data: {
            labels: dailyLabels,
            datasets: [{
                label: "Today's Appointments",
                data: dailyData,
                backgroundColor: 'rgba(0, 123, 255, 0.6)',
                borderColor: 'rgba(0, 123, 255, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { precision: 0 }
                }
            }
        }
    });

    // Monthly chart
    new Chart(document.getElementById('monthChart'), {
        type: 'line',
        data: {
            labels: monthLabels,
            datasets: [{
                label: 'Monthly Appointments',
                data: monthData,
                borderColor: '#007bff',
                backgroundColor: 'rgba(0,123,255,0.1)',
                fill: true,
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { precision: 0 }
                }
            }
        }
    });

    // Yearly chart
    new Chart(document.getElementById('yearChart'), {
        type: 'bar',
        data: {
            labels: yearLabels,
            datasets: [{
                label: 'Appointments per Year',
                data: yearData,
                backgroundColor: 'rgba(40, 167, 69, 0.6)',
                borderColor: 'rgba(40, 167, 69, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: { precision: 0 }
                }
            }
        }
    });
});
</script>
