
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="Database.dbconfig" %>
<%@ include file="header.jsp" %>

<%!
/**
 * Escape a string for safe embedding into single-quoted JS string in HTML.
 * Replaces backslash, single-quote, double-quote, CR and LF.
 */
public String jsEscape(String s) {
    if (s == null) return "";
    return s.replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\r", " ").replace("\n", " ");
}
%>

<%
    int totalDoctors = 0, totalPatients = 0, totalAppointments = 0, todayAppointments = 0;

    List<String> doctorList = new ArrayList<String>();
    Map<String, Integer> doctorMonthlyAppointments = new LinkedHashMap<String, Integer>();
    Map<String, Integer> doctorDailyAppointments = new LinkedHashMap<String, Integer>();
    Map<String, List<String>> doctorMonthlyDetails = new LinkedHashMap<String, List<String>>();
    Map<String, List<String>> doctorDailyDetails = new LinkedHashMap<String, List<String>>();
    Map<String, String> doctorInfo = new LinkedHashMap<String, String>();

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = new dbconfig().getConnection();
        stmt = con.createStatement();

        /* -------------------------------
           LOAD DOCTOR LIST
        --------------------------------*/
        rs = stmt.executeQuery("SELECT doctorname FROM doctor ORDER BY doctorname");
        while (rs.next()) {
            String dn = rs.getString(1);
            if (dn == null) dn = "";
            doctorList.add(dn);
        }
        rs.close();

        /* -------------------------------
           LOAD DOCTOR INFO (for first Details button)
           using the columns you provided
           id, doctorname, username, email, password, education, specialization, joindate, phone
        --------------------------------*/
        rs = stmt.executeQuery("SELECT doctorname, specialization, education, joindate, phone, email FROM doctor ORDER BY doctorname");
        while (rs.next()) {
            String name = rs.getString("doctorname");
            String spec = rs.getString("specialization");
            String edu = rs.getString("education");
            String join = rs.getString("joindate");
            String phone = rs.getString("phone");
            String email = rs.getString("email");

            if (name == null) name = "";
            if (spec == null) spec = "";
            if (edu == null) edu = "";
            if (join == null) join = "";
            if (phone == null) phone = "";
            if (email == null) email = "";

            String info = "Name: " + name + ", Specialization: " + spec + ", Education: " + edu +
                          ", Join Date: " + join + ", Phone: " + phone + ", Email: " + email;

            doctorInfo.put(name, info);
        }
        rs.close();

        /* -------------------------------
           COUNT TOTALS
        --------------------------------*/
        rs = stmt.executeQuery("SELECT COUNT(*) FROM doctor");
        if (rs.next()) totalDoctors = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM patients");
        if (rs.next()) totalPatients = rs.getInt(1);
        rs.close();

        // Use DATE(a_Date) to handle DATETIME columns reliably
        rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE DATE(a_Date) >= CURDATE() - INTERVAL 30 DAY");
        if (rs.next()) totalAppointments = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE DATE(a_Date) = CURDATE()");
        if (rs.next()) todayAppointments = rs.getInt(1);
        rs.close();

        /* -------------------------------
           MONTHLY COUNTS (last 30 days)
        --------------------------------*/
        rs = stmt.executeQuery(
            "SELECT d.doctorname, COUNT(a.id) AS cnt " +
            "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
            "AND DATE(a.a_Date) >= CURDATE() - INTERVAL 30 DAY " +
            "GROUP BY d.doctorname ORDER BY d.doctorname"
        );
        while (rs.next()) {
            String d = rs.getString(1);
            int cnt = rs.getInt(2);
            if (d == null) d = "";
            doctorMonthlyAppointments.put(d, cnt);
        }
        rs.close();

        /* -------------------------------
           DAILY COUNTS (today)
        --------------------------------*/
        rs = stmt.executeQuery(
            "SELECT d.doctorname, COUNT(a.id) AS cnt " +
            "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
            "AND DATE(a.a_Date) = CURDATE() " +
            "GROUP BY d.doctorname ORDER BY d.doctorname"
        );
        while (rs.next()) {
            String d = rs.getString(1);
            int cnt = rs.getInt(2);
            if (d == null) d = "";
            doctorDailyAppointments.put(d, cnt);
        }
        rs.close();

        /* -------------------------------
           MONTHLY DETAILS (per doctor) - last 30 days
        --------------------------------*/
        PreparedStatement psM = con.prepareStatement(
            "SELECT id, patientname, doctorname, a_Date, a_Time, reason, patientphone, prescription " +
            "FROM appointmentss WHERE doctorname = ? AND DATE(a_Date) >= CURDATE() - INTERVAL 30 DAY ORDER BY a_Date, a_Time"
        );

        for (int i = 0; i < doctorList.size(); i++) {
            String doc = doctorList.get(i);
            psM.setString(1, doc);
            ResultSet r = psM.executeQuery();

            List<String> list = new ArrayList<String>();
            while (r.next()) {
                String id = String.valueOf(r.getInt("id"));
                String patient = r.getString("patientname");
                String date = r.getString("a_Date");
                String time = r.getString("a_Time");
                String reason = r.getString("reason");
                String pphone = r.getString("patientphone");
                String presc = r.getString("prescription");

                if (patient == null) patient = "Unknown";
                if (date == null) date = "";
                if (time == null) time = "";
                if (reason == null) reason = "";
                if (pphone == null) pphone = "";
                if (presc == null) presc = "";

                String s = "ID: " + id + ", Patient: " + patient + ", Date: " + date + ", Time: " + time +
                           (reason.length() > 0 ? (", Reason: " + reason) : "") +
                           (pphone.length() > 0 ? (", Phone: " + pphone) : "") +
                           (presc.length() > 0 ? (", Presc: " + presc) : "");
                list.add(s);
            }
            doctorMonthlyDetails.put(doc, list);
            try { r.close(); } catch (Exception ex) {}
        }
        try { psM.close(); } catch (Exception ex) {}

        /* -------------------------------
           DAILY DETAILS (per doctor) - today
        --------------------------------*/
        PreparedStatement psD = con.prepareStatement(
            "SELECT id, patientname, doctorname, a_Date, a_Time, reason, patientphone, prescription " +
            "FROM appointmentss WHERE doctorname = ? AND DATE(a_Date) = CURDATE() ORDER BY a_Time"
        );

        for (int i = 0; i < doctorList.size(); i++) {
            String doc = doctorList.get(i);
            psD.setString(1, doc);
            ResultSet r = psD.executeQuery();

            List<String> list = new ArrayList<String>();
            while (r.next()) {
                String id = String.valueOf(r.getInt("id"));
                String patient = r.getString("patientname");
                String date = r.getString("a_Date");
                String time = r.getString("a_Time");
                String reason = r.getString("reason");
                String pphone = r.getString("patientphone");
                String presc = r.getString("prescription");

                if (patient == null) patient = "Unknown";
                if (date == null) date = "";
                if (time == null) time = "";
                if (reason == null) reason = "";
                if (pphone == null) pphone = "";
                if (presc == null) presc = "";

                String s = "ID: " + id + ", Patient: " + patient + ", Date: " + date + ", Time: " + time +
                           (reason.length() > 0 ? (", Reason: " + reason) : "") +
                           (pphone.length() > 0 ? (", Phone: " + pphone) : "") +
                           (presc.length() > 0 ? (", Presc: " + presc) : "");
                list.add(s);
            }
            doctorDailyDetails.put(doc, list);
            try { r.close(); } catch (Exception ex) {}
        }
        try { psD.close(); } catch (Exception ex) {}

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
            <small class="text-muted">Doctor records updated</small><br>
            <button class="btn btn-primary btn-sm mt-2" onclick="showDoctors()">View</button>
          </div>
        </div>
      </div>

      <div class="col-md-3 mb-3">
        <div class="card shadow-sm text-center">
          <div class="card-body">
            <h6>Total Patients</h6>
            <h4><%= totalPatients %></h4>
            <small class="text-muted">Patient records updated</small><br>
            <button class="btn btn-primary btn-sm mt-2" onclick="showPatients()">View</button>
          </div>
        </div>
      </div>

      <div class="col-md-3 mb-3">
        <div class="card shadow-sm text-center">
          <div class="card-body">
            <h6>Appointments (30 days)</h6>
            <h4><%= totalAppointments %></h4>
            <small class="text-muted">Past 30 days summary</small><br>
            <button class="btn btn-primary btn-sm mt-2" onclick="showAppointments()">View</button>
          </div>
        </div>
      </div>

      <div class="col-md-3 mb-3">
        <div class="card shadow-sm text-center">
          <div class="card-body">
            <h6>Today's Appointments</h6>
            <h4><%= todayAppointments %></h4>
            <small class="text-muted">Updated today</small><br>
            <button class="btn btn-primary btn-sm mt-2" onclick="showTodayAppointments()">View</button>
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
/* -------------------------------
   EMBED JAVASCRIPT ARRAYS (safe server-side escaping)
--------------------------------*/

var doctorList = [
<% for (int i=0;i<doctorList.size();i++){ 
       String d = doctorList.get(i);
%>
    '<%= jsEscape(d) %>'<%= (i < doctorList.size()-1 ? "," : "") %>
<% } %>
];

var doctorInfo = {
<% int ci = 0;
   for (Iterator<String> it = doctorInfo.keySet().iterator(); it.hasNext(); ) {
       String doc = it.next();
       String inf = doctorInfo.get(doc);
%>
   '<%= jsEscape(doc) %>': '<%= jsEscape(inf) %>'<%= (ci++ < doctorInfo.size()-1 ? "," : "") %>
<% } %>
};

var doctorMonthly = {
<% ci=0;
   for (Iterator<Map.Entry<String,Integer>> it = doctorMonthlyAppointments.entrySet().iterator(); it.hasNext(); ) {
       Map.Entry<String,Integer> e = it.next();
%>
   '<%= jsEscape(e.getKey()) %>': <%= e.getValue() %><%= (ci++ < doctorMonthlyAppointments.size()-1 ? "," : "") %>
<% } %>
};

var doctorDaily = {
<% ci=0;
   for (Iterator<Map.Entry<String,Integer>> it = doctorDailyAppointments.entrySet().iterator(); it.hasNext(); ) {
       Map.Entry<String,Integer> e = it.next();
%>
   '<%= jsEscape(e.getKey()) %>': <%= e.getValue() %><%= (ci++ < doctorDailyAppointments.size()-1 ? "," : "") %>
<% } %>
};

var doctorMonthlyDetails = {
<% ci=0;
   for (Iterator<String> it = doctorMonthlyDetails.keySet().iterator(); it.hasNext(); ) {
       String doc = it.next();
       List<String> list = doctorMonthlyDetails.get(doc);
%>
   '<%= jsEscape(doc) %>': [
   <% for (int j=0;j<list.size();j++){ %>
       '<%= jsEscape(list.get(j)) %>'<%= (j < list.size()-1 ? "," : "") %>
   <% } %>
   ]<%= (ci++ < doctorMonthlyDetails.size()-1 ? "," : "") %>
<% } %>
};

var doctorDailyDetails = {
<% ci=0;
   for (Iterator<String> it = doctorDailyDetails.keySet().iterator(); it.hasNext(); ) {
       String doc = it.next();
       List<String> list = doctorDailyDetails.get(doc);
%>
   '<%= jsEscape(doc) %>': [
   <% for (int j=0;j<list.size();j++){ %>
       '<%= jsEscape(list.get(j)) %>'<%= (j < list.size()-1 ? "," : "") %>
   <% } %>
   ]<%= (ci++ < doctorDailyDetails.size()-1 ? "," : "") %>
<% } %>
};

/* -------------------------------
   DISPLAY FUNCTIONS
--------------------------------*/

function showDoctors() {
    var html = "<h5>Doctors List</h5><ul>";
    doctorList.forEach(function(doc) {
        // doc is escaped server-side already
        html += "<li><b>" + doc + "</b> - Daily: " + (doctorDaily[doc] || 0) +
            " <button class='btn btn-link p-0' onclick=\"showDailyDetails('" + doc + "')\">Daily Details</button>, " +
            "Monthly: " + (doctorMonthly[doc] || 0) +
            " <button class='btn btn-link p-0' onclick=\"showMonthlyDetails('" + doc + "')\">Monthly Details</button></li>";
    });
    html += "</ul>";
    document.getElementById("detailSection").innerHTML = html;
}

function showDoctorInfo(doc) {
    document.getElementById("detailSection").innerHTML =
        "<h5>Doctor Info</h5><p>" + (doctorInfo[doc] || "No info") + "</p>";
}

function showPatients() {
    document.getElementById("detailSection").innerHTML =
        "<h5>Total Patients</h5><p><%= totalPatients %> patients registered.</p>";
}

function showAppointments() {
    var html = "<h5>Appointments (Last 30 Days)</h5>";
    var all = [];
    for (var d in doctorMonthlyDetails) {
        if (doctorMonthlyDetails.hasOwnProperty(d)) {
            all = all.concat(doctorMonthlyDetails[d]);
        }
    }
    if (all.length === 0) html += "<p>No appointments found.</p>";
    else {
        html += "<ul>";
        all.forEach(function(i){ html += "<li>" + i + "</li>"; });
        html += "</ul>";
    }
    document.getElementById("detailSection").innerHTML = html;
}

function showTodayAppointments() {
    var html = "<h5>Today's Appointments</h5><ul>";
    for (var d in doctorDaily) {
        if (doctorDaily.hasOwnProperty(d)) {
            html += "<li>" + d + ": " + doctorDaily[d] +
                " <button class='btn btn-link p-0' onclick=\"showDailyDetails('" + d + "')\">Details</button></li>";
        }
    }
    html += "</ul>";
    document.getElementById("detailSection").innerHTML = html;
}

function showMonthlyDetails(doc) {
    var list = doctorMonthlyDetails[doc] || [];
    var html = "<h5>Monthly Appointments for " + doc + "</h5>";
    if (list.length === 0) html += "<p>No appointments in last 30 days.</p>";
    else {
        html += "<ul>";
        list.forEach(function(i){ html += "<li>" + i + "</li>"; });
        html += "</ul>";
    }
    document.getElementById("detailSection").innerHTML = html;
}

function showDailyDetails(doc) {
    var list = doctorDailyDetails[doc] || [];
    var html = "<h5>Today's Appointments for " + doc + "</h5>";
    if (list.length === 0) html += "<p>No appointments today.</p>";
    else {
        html += "<ul>";
        list.forEach(function(i){ html += "<li>" + i + "</li>"; });
        html += "</ul>";
    }
    document.getElementById("detailSection").innerHTML = html;
}
</script>
