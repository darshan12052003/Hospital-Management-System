<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="Database.dbconfig" %>
<%@ include file="header.jsp" %>

<%
    int totalDoctors = 0, totalPatients = 0, totalAppointments = 0, todayAppointments = 0;

    List<String> doctorList = new ArrayList<String>();
    Map<String, Integer> doctorMonthlyAppointments = new LinkedHashMap<String, Integer>();
    Map<String, Integer> doctorDailyAppointments = new LinkedHashMap<String, Integer>();
    Map<String, List<String>> doctorMonthlyDetails = new LinkedHashMap<String, List<String>>();
    Map<String, List<String>> doctorDailyDetails = new LinkedHashMap<String, List<String>>();
    Map<String, Integer> specAppointmentCounts = new LinkedHashMap<String, Integer>();

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = new dbconfig().getConnection();
        stmt = con.createStatement();

        // Get doctor list
        rs = stmt.executeQuery("SELECT doctorname FROM doctor ORDER BY doctorname");
        while (rs.next()) {
            doctorList.add(rs.getString(1));
        }
        rs.close();

        // Totals
        rs = stmt.executeQuery("SELECT COUNT(*) FROM doctor");
        if (rs.next()) totalDoctors = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM patients");
        if (rs.next()) totalPatients = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE a_Date >= CURDATE() - INTERVAL 30 DAY");
        if (rs.next()) totalAppointments = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE a_Date = CURDATE()");
        if (rs.next()) todayAppointments = rs.getInt(1);
        rs.close();

        // Monthly counts
        rs = stmt.executeQuery(
            "SELECT d.doctorname, COUNT(a.id) AS cnt " +
            "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
            "AND a.a_Date >= CURDATE() - INTERVAL 30 DAY " +
            "GROUP BY d.doctorname ORDER BY d.doctorname");
        while (rs.next()) {
            doctorMonthlyAppointments.put(rs.getString("doctorname"), rs.getInt("cnt"));
        }
        rs.close();

        // Daily counts
        rs = stmt.executeQuery(
            "SELECT d.doctorname, COUNT(a.id) AS cnt " +
            "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
            "AND a.a_Date = CURDATE() " +
            "GROUP BY d.doctorname ORDER BY d.doctorname");
        while (rs.next()) {
            doctorDailyAppointments.put(rs.getString("doctorname"), rs.getInt("cnt"));
        }
        rs.close();

        // Monthly details per doctor
        PreparedStatement psMonthly = con.prepareStatement(
            "SELECT id, patientname, doctorname, a_Date, a_Time FROM appointmentss " +
            "WHERE a_Date >= CURDATE() - INTERVAL 30 DAY AND doctorname = ?");
        for (String doc : doctorList) {
            psMonthly.setString(1, doc);
            ResultSet rsM = psMonthly.executeQuery();
            List<String> details = new ArrayList<String>();
            while (rsM.next()) {
                String id = String.valueOf(rsM.getInt("id"));
                String patient = rsM.getString("patientname") == null ? "Unknown" : rsM.getString("patientname");
                String date = rsM.getString("a_Date") == null ? "" : rsM.getString("a_Date");
                String time = rsM.getString("a_Time") == null ? "" : rsM.getString("a_Time");
                details.add("ID: " + id + ", Patient: " + patient + ", Date: " + date + ", Time: " + time);
            }
            doctorMonthlyDetails.put(doc, details);
            rsM.close();
        }
        psMonthly.close();

        // Daily details per doctor
        PreparedStatement psDaily = con.prepareStatement(
            "SELECT id, patientname, doctorname, a_Date, a_Time FROM appointmentss " +
            "WHERE a_Date = CURDATE() AND doctorname = ?");
        for (String doc : doctorList) {
            psDaily.setString(1, doc);
            ResultSet rsD = psDaily.executeQuery();
            List<String> details = new ArrayList<String>();
            while (rsD.next()) {
                String id = String.valueOf(rsD.getInt("id"));
                String patient = rsD.getString("patientname") == null ? "Unknown" : rsD.getString("patientname");
                String date = rsD.getString("a_Date") == null ? "" : rsD.getString("a_Date");
                String time = rsD.getString("a_Time") == null ? "" : rsD.getString("a_Time");
                details.add("ID: " + id + ", Patient: " + patient + ", Date: " + date + ", Time: " + time);
            }
            doctorDailyDetails.put(doc, details);
            rsD.close();
        }
        psDaily.close();

        // Specialization appointment count
        rs = stmt.executeQuery(
            "SELECT d.specialization, COUNT(a.id) AS cnt " +
            "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
            "GROUP BY d.specialization ORDER BY d.specialization");
        while (rs.next()) {
            specAppointmentCounts.put(rs.getString("specialization"), rs.getInt("cnt"));
        }
        rs.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>

<div class="pc-container">
  <div class="pc-content">
    <div class="row mt-3">
      <div class="col-md-3 mb-3">
        <div class="card shadow-sm text-center">
          <div class="card-body">
            <h6>Total Doctors</h6>
            <h4><%= totalDoctors %></h4>
            <button class="btn btn-primary btn-sm" onclick="showDoctors()">View</button>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card shadow-sm text-center">
          <div class="card-body">
            <h6>Total Patients</h6>
            <h4><%= totalPatients %></h4>
            <button class="btn btn-primary btn-sm" onclick="showPatients()">View</button>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card shadow-sm text-center">
          <div class="card-body">
            <h6>Appointments (30 days)</h6>
            <h4><%= totalAppointments %></h4>
            <button class="btn btn-primary btn-sm" onclick="showAppointments()">View</button>
          </div>
        </div>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card shadow-sm text-center">
          <div class="card-body">
            <h6>Today's Appointments</h6>
            <h4><%= todayAppointments %></h4>
            <button class="btn btn-primary btn-sm" onclick="showTodayAppointments()">View</button>
          </div>
        </div>
      </div>
    </div>

    <div id="detailSection" class="mt-4 p-3" style="background:#f9f9f9;border-radius:8px;min-height:150px;">
      <h5>Click a button to see details</h5>
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>

<script>
  // Helper for escaping JSP text into JavaScript safely
  function esc(str) {
    return str.replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\n/g, " ").replace(/\r/g, "");
  }

  var doctorList = [
    <% for (int i = 0; i < doctorList.size(); i++) { String n = doctorList.get(i); %>
      "<%= n.replace("\\","\\\\").replace("\"","\\\"").replace("\n"," ").replace("\r","") %>"<%= (i < doctorList.size() - 1) ? "," : "" %>
    <% } %>
  ];

  var doctorMonthlyDetails = {
    <% int c = 0;
       for (String doc : doctorMonthlyDetails.keySet()) {
         String docName = doc.replace("\\","\\\\").replace("\"","\\\"").replace("\n"," ").replace("\r","");
         List<String> list = doctorMonthlyDetails.get(doc);
    %>
      "<%= docName %>": [
        <% for (int i = 0; i < list.size(); i++) { 
             String item = list.get(i);
             if (item == null) item = "";
             item = item.replace("\\","\\\\").replace("\"","\\\"").replace("\n"," ").replace("\r","");
        %>
          "<%= item %>"<%= (i < list.size() - 1) ? "," : "" %>
        <% } %>
      ]<%= (++c < doctorMonthlyDetails.size()) ? "," : "" %>
    <% } %>
  };

  var doctorDailyDetails = {
    <% c = 0;
       for (String doc : doctorDailyDetails.keySet()) {
         String docName = doc.replace("\\","\\\\").replace("\"","\\\"").replace("\n"," ").replace("\r","");
         List<String> list = doctorDailyDetails.get(doc);
    %>
      "<%= docName %>": [
        <% for (int i = 0; i < list.size(); i++) { 
             String item = list.get(i);
             if (item == null) item = "";
             item = item.replace("\\","\\\\").replace("\"","\\\"").replace("\n"," ").replace("\r","");
        %>
          "<%= item %>"<%= (i < list.size() - 1) ? "," : "" %>
        <% } %>
      ]<%= (++c < doctorDailyDetails.size()) ? "," : "" %>
    <% } %>
  };

  var doctorMonthly = {
    <% c = 0; for (Map.Entry<String,Integer> e : doctorMonthlyAppointments.entrySet()) { %>
      "<%= e.getKey() %>": <%= e.getValue() %><%= (++c < doctorMonthlyAppointments.size()) ? "," : "" %>
    <% } %>
  };

  var doctorDaily = {
    <% c = 0; for (Map.Entry<String,Integer> e : doctorDailyAppointments.entrySet()) { %>
      "<%= e.getKey() %>": <%= e.getValue() %><%= (++c < doctorDailyAppointments.size()) ? "," : "" %>
    <% } %>
  };

  function showDoctors() {
    let html = "<h5>Doctors List</h5><ul>";
    doctorList.forEach(doc => {
      html += "<li><b>" + doc + "</b> - Daily: " + (doctorDaily[doc] || 0) +
        " <button class='btn btn-link p-0' onclick=\"showDailyDetails('" + doc + "')\">Details</button>, " +
        "Monthly: " + (doctorMonthly[doc] || 0) +
        " <button class='btn btn-link p-0' onclick=\"showMonthlyDetails('" + doc + "')\">Details</button></li>";
    });
    html += "</ul>";
    document.getElementById("detailSection").innerHTML = html;
  }

  function showPatients() {
    document.getElementById("detailSection").innerHTML = "<h5>Total Patients</h5><p><%= totalPatients %> patients registered.</p>";
  }

 function showAppointments() {
    let list = monthlyFull;   // full monthly appointment details (already generated from JSP)

    let html = "<h5>Appointments (Last 30 Days ? Full Details)</h5>";

    if (list.length === 0) {
        html += "<p>No appointments found.</p>";
    } else {
        html += "<ul>";
        list.forEach(item => {
            html += "<li>" + item + "</li>";
        });
        html += "</ul>";
    }

    document.getElementById("detailSection").innerHTML = html;
}

  function showTodayAppointments() {
    let html = "<h5>Today's Appointments</h5><ul>";
    for (let doc in doctorDaily) {
      html += `<li>${doc}: ${doctorDaily[doc]} 
        <button class='btn btn-link p-0' onclick="showDailyDetails('${doc}')">Details</button></li>`;
    }
    html += "</ul>";
    document.getElementById("detailSection").innerHTML = html;
  }

  function showMonthlyDetails(doc) {
    let list = doctorMonthlyDetails[doc] || [];
    let html = `<h5>Monthly Appointments for ${doc}</h5>`;
    if (list.length === 0) html += "<p>No appointments found.</p>";
    else html += "<ul>" + list.map(item => `<li>${item}</li>`).join("") + "</ul>";
    document.getElementById("detailSection").innerHTML = html;
  }

  function showDailyDetails(doc) {
    let list = doctorDailyDetails[doc] || [];
    let html = `<h5>Today's Appointments for ${doc}</h5>`;
    if (list.length === 0) html += "<p>No appointments found.</p>";
    else html += "<ul>" + list.map(item => `<li>${item}</li>`).join("") + "</ul>";
    document.getElementById("detailSection").innerHTML = html;
  }
</script>
here i attached the output page photo in that in that 
when i click first details button it should display the doctor's registration information
change the code into this

