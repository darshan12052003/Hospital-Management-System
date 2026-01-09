<%-- 
    Document   : newjsp
    Created on : 1 Dec, 2025, 11:20:46 AM
    Author     : darsh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
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
            doctorList.add(rs.getString(1));
        }
        rs.close();

        /* -------------------------------
           LOAD DOCTOR INFO (for first Details button)
        --------------------------------*/
        rs = stmt.executeQuery(
            "SELECT doctorname, specialization, phoneno, email FROM doctor ORDER BY doctorname"
        );
        while (rs.next()) {
            String name = rs.getString("doctorname");
            String spec = rs.getString("specialization");
            String phone = rs.getString("phoneno");
            String email = rs.getString("email");

            if(name == null) name = "";
            if(spec == null) spec = "";
            if(phone == null) phone = "";
            if(email == null) email = "";

            String info =
                "Name: " + name +
                ", Specialization: " + spec +
                ", Phone: " + phone +
                ", Email: " + email;

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

        rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE a_Date >= CURDATE() - INTERVAL 30 DAY");
        if (rs.next()) totalAppointments = rs.getInt(1);
        rs.close();

        rs = stmt.executeQuery("SELECT COUNT(*) FROM appointmentss WHERE a_Date = CURDATE()");
        if (rs.next()) todayAppointments = rs.getInt(1);
        rs.close();

        /* -------------------------------
           MONTHLY COUNTS
        --------------------------------*/
        rs = stmt.executeQuery(
            "SELECT d.doctorname, COUNT(a.id) AS cnt " +
            "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
            "AND a.a_Date >= CURDATE() - INTERVAL 30 DAY " +
            "GROUP BY d.doctorname ORDER BY d.doctorname"
        );
        while (rs.next()) {
            doctorMonthlyAppointments.put(rs.getString(1), rs.getInt(2));
        }
        rs.close();

        /* -------------------------------
           DAILY COUNTS
        --------------------------------*/
        rs = stmt.executeQuery(
            "SELECT d.doctorname, COUNT(a.id) AS cnt " +
            "FROM doctor d LEFT JOIN appointmentss a ON d.doctorname = a.doctorname " +
            "AND a.a_Date = CURDATE() " +
            "GROUP BY d.doctorname ORDER BY d.doctorname"
        );
        while (rs.next()) {
            doctorDailyAppointments.put(rs.getString(1), rs.getInt(2));
        }
        rs.close();

        /* -------------------------------
           MONTHLY DETAILS (per doctor)
        --------------------------------*/
        PreparedStatement psM = con.prepareStatement(
            "SELECT id, patientname, a_Date, a_Time FROM appointmentss " +
            "WHERE a_Date >= CURDATE() - INTERVAL 30 DAY AND doctorname = ? ORDER BY a_Date"
        );
        for (String doc : doctorList) {
            psM.setString(1, doc);
            ResultSet r = psM.executeQuery();

            List<String> list = new ArrayList<String>();
            while (r.next()) {
                String s =
                    "ID: " + r.getInt("id") +
                    ", Patient: " + (r.getString("patientname") == null ? "Unknown" : r.getString("patientname")) +
                    ", Date: " + r.getString("a_Date") +
                    ", Time: " + r.getString("a_Time");

                list.add(s);
            }
            doctorMonthlyDetails.put(doc, list);
            r.close();
        }
        psM.close();

        /* -------------------------------
           DAILY DETAILS (per doctor)
        --------------------------------*/
        PreparedStatement psD = con.prepareStatement(
            "SELECT id, patientname, a_Date, a_Time FROM appointmentss " +
            "WHERE a_Date = CURDATE() AND doctorname = ? ORDER BY a_Time"
        );
        for (String doc : doctorList) {
            psD.setString(1, doc);
            ResultSet r = psD.executeQuery();

            List<String> list = new ArrayList<String>();
            while (r.next()) {
                String s =
                    "ID: " + r.getInt("id") +
                    ", Patient: " + (r.getString("patientname") == null ? "Unknown" : r.getString("patientname")) +
                    ", Date: " + r.getString("a_Date") +
                    ", Time: " + r.getString("a_Time");

                list.add(s);
            }
            doctorDailyDetails.put(doc, list);
            r.close();
        }
        psD.close();

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
%>

<!-- =====================================
     DASHBOARD CARDS
====================================== -->
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
/* -------------------------------
   EMBED JAVASCRIPT ARRAYS
--------------------------------*/

var doctorList = [
<% for(int i=0;i<doctorList.size();i++){ %>
    "<%= doctorList.get(i) %>"<%= (i < doctorList.size()-1 ? "," : "") %>
<% } %>
];

var doctorInfo = {
<% int c = 0;
   for(String doc : doctorInfo.keySet()){
       String inf = doctorInfo.get(doc);
%>
   "<%= doc %>": "<%= inf.replace("\"","\\\"") %>"<%= (++c < doctorInfo.size() ? "," : "") %>
<% } %>
};

var doctorMonthly = {
<% c=0;
   for(Map.Entry<String,Integer> e : doctorMonthlyAppointments.entrySet()){ %>
    "<%= e.getKey() %>": <%= e.getValue() %><%= (++c < doctorMonthlyAppointments.size() ? "," : "") %>
<% } %>
};

var doctorDaily = {
<% c=0;
   for(Map.Entry<String,Integer> e : doctorDailyAppointments.entrySet()){ %>
    "<%= e.getKey() %>": <%= e.getValue() %><%= (++c < doctorDailyAppointments.size() ? "," : "") %>
<% } %>
};

var doctorMonthlyDetails = {
<% c=0;
   for(String doc : doctorMonthlyDetails.keySet()){
       List<String> list = doctorMonthlyDetails.get(doc);
%>
   "<%= doc %>": [
   <% for(int i=0;i<list.size();i++){ %>
       "<%= list.get(i).replace("\"","\\\"") %>"<%= (i<list.size()-1 ? "," : "") %>
   <% } %>
   ]<%= (++c < doctorMonthlyDetails.size() ? "," : "") %>
<% } %>
};

var doctorDailyDetails = {
<% c=0;
   for(String doc : doctorDailyDetails.keySet()){
       List<String> list = doctorDailyDetails.get(doc);
%>
   "<%= doc %>": [
   <% for(int i=0;i<list.size();i++){ %>
       "<%= list.get(i).replace("\"","\\\"") %>"<%= (i<list.size()-1 ? "," : "") %>
   <% } %>
   ]<%= (++c < doctorDailyDetails.size() ? "," : "") %>
<% } %>
};

/* -------------------------------
   DISPLAY FUNCTIONS
--------------------------------*/

function showDoctors() {
    let html = "<h5>Doctors</h5><ul>";
    doctorList.forEach(doc => {
        html += "<li><b>" + doc + "</b> — " +
                "<button class='btn btn-link p-0' onclick=\"showDoctorInfo('" + doc + "')\">Details</button>, " +
                "Daily: " + (doctorDaily[doc] || 0) +
                " <button class='btn btn-link p-0' onclick=\"showDailyDetails('" + doc + "')\">Details</button>, " +
                "Monthly: " + (doctorMonthly[doc] || 0) +
                " <button class='btn btn-link p-0' onclick=\"showMonthlyDetails('" + doc + "')\">Details</button></li>";
    });
    html += "</ul>";
    document.getElementById("detailSection").innerHTML = html;
}

function showDoctorInfo(doc) {
    document.getElementById("detailSection").innerHTML =
        "<h5>Doctor Info</h5><p>" + doctorInfo[doc] + "</p>";
}

function showPatients() {
    document.getElementById("detailSection").innerHTML =
        "<h5>Total Patients</h5><p><%= totalPatients %> patients registered.</p>";
}

function showAppointments() {
    let html = "<h5>Appointments (Last 30 Days)</h5>";
    let list = [];

    for (var doc in doctorMonthlyDetails) {
        list = list.concat(doctorMonthlyDetails[doc]);
    }

    if(list.length === 0) html += "<p>No appointments found.</p>";
    else html += "<ul>" + list.map(i => "<li>" + i + "</li>").join("") + "</ul>";

    document.getElementById("detailSection").innerHTML = html;
}

function showTodayAppointments() {
    let html = "<h5>Today's Appointments</h5><ul>";
    for (let doc in doctorDaily) {
        html += "<li>" + doc + ": " + doctorDaily[doc] +
                " <button class='btn btn-link p-0' onclick=\"showDailyDetails('" + doc + "')\">Details</button></li>";
    }
    html += "</ul>";
    document.getElementById("detailSection").innerHTML = html;
}

function showMonthlyDetails(doc) {
    let list = doctorMonthlyDetails[doc] || [];
    let html = "<h5>Monthly Appointments for " + doc + "</h5>";

    if(list.length === 0) html += "<p>No appointments found.</p>";
    else html += "<ul>" + list.map(i => "<li>" + i + "</li>").join("") + "</ul>";

    document.getElementById("detailSection").innerHTML = html;
}

function showDailyDetails(doc) {
    let list = doctorDailyDetails[doc] || [];
    let html = "<h5>Today's Appointments for " + doc + "</h5>";

    if(list.length === 0) html += "<p>No appointments found.</p>";
    else html += "<ul>" + list.map(i => "<li>" + i + "</li>").join("") + "</ul>";

    document.getElementById("detailSection").innerHTML = html;
}
</script>
change the code that shows total updated doctors and patient registered

<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Java 6/7 compatible map declaration
    Map<String, String> doctorInfo = new HashMap<String, String>();

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "");

        // Load all doctors and create safe info map
        ps = con.prepareStatement("SELECT doctorname, specialization, phone, email FROM doctor");
        rs = ps.executeQuery();

        while (rs.next()) {
            String name = rs.getString("doctorname");
            String spec = rs.getString("specialization");
            String phone = rs.getString("phone");
            String email = rs.getString("email");

            // Clean null values
            String safeSpec  = (spec  == null || spec.trim().equals(""))  ? "Not Provided" : spec;
            String safePhone = (phone == null || phone.trim().equals("")) ? "Not Provided" : phone;
            String safeEmail = (email == null || email.trim().equals("")) ? "Not Provided" : email;

            // Store info with normalized key
            doctorInfo.put(name.trim().toLowerCase(),
                "Name: " + name +
                ", Specialization: " + safeSpec +
                ", Phone: " + safePhone +
                ", Email: " + safeEmail
            );
        }

        rs.close();
        ps.close();

    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Reports</title>

<style>
body {
    font-family: Arial;
    background: #f5f5f5;
    margin: 20px;
}
.report-box {
    padding: 10px;
    border: 1px solid #ccc;
    background: white;
    width: 420px;
    margin-bottom: 25px;
}
.btn {
    padding: 6px 12px;
    background: #4CAF50;
    border: none;
    color: white;
    cursor: pointer;
}
.btn:hover {
    background: #45a049;
}
</style>

<script>
// Build doctorInfo JS object safely
let doctorInfo = {
<%
Iterator<Map.Entry<String, String>> it = doctorInfo.entrySet().iterator();
while (it.hasNext()) {
    Map.Entry<String, String> entry = it.next();
    String key = entry.getKey().trim().toLowerCase();
    String value = entry.getValue().replace("'", "\\'");
%>
    "<%= key %>": "<%= value %>"<%= it.hasNext() ? "," : "" %>
<%
}
%>
};

// Universal safe function for all doctors
function showInfo(name) {
    let normalized = name.trim().toLowerCase();

    if (doctorInfo[normalized]) {
        alert(doctorInfo[normalized]);
    } else {
        alert("Doctor information not found.");
    }
}
</script>

</head>

<body>

<h2>Doctor Reports</h2>

<div class="report-box">
<h3>Daily Appointments</h3>

<%
    int dailyCount = 0;
    try {
        ps = con.prepareStatement(
            "SELECT COUNT(*) FROM appointmentss WHERE a_Date = CURDATE()"
        );
        rs = ps.executeQuery();
        if (rs.next()) dailyCount = rs.getInt(1);
        rs.close();
        ps.close();
%>

<p>Total Appointments Today: <%= dailyCount %></p>
<button class="btn" onclick="window.location='viewdaily.jsp'">View Details</button>

<%
    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>
</div>

<div class="report-box">
<h3>Monthly Appointments</h3>

<%
    int monthlyCount = 0;
    try {
        ps = con.prepareStatement(
            "SELECT COUNT(*) FROM appointmentss WHERE a_Date BETWEEN CURDATE() AND CURDATE() + INTERVAL 30 DAY"
        );
        rs = ps.executeQuery();
        if (rs.next()) monthlyCount = rs.getInt(1);
        rs.close();
        ps.close();
%>

<p>Total Appointments (Next 30 Days): <%= monthlyCount %></p>
<button class="btn" onclick="window.location='viewmonthly.jsp'">View Details</button>

<%
    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>
</div>

<hr>

<h2>Doctor List</h2>

<%
    try {
        ps = con.prepareStatement("SELECT doctorname FROM doctor");
        rs = ps.executeQuery();

        while (rs.next()) {
            String doc = rs.getString("doctorname");
%>
            <div class="report-box">
                <b>Doctor:</b> <%= doc %><br><br>
                <button class="btn" onclick="showInfo('<%= doc %>')">Info</button>
                <button class="btn" onclick="window.location='apointments.jsp?doctor=<%= doc %>'">Daily</button>
                <button class="btn" onclick="window.location='apointments.jsp?doctor=<%= doc %>'">Monthly</button>
            </div>
<%
        }
        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>

</body>
</html>
