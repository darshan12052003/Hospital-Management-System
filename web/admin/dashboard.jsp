<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="Database.dbconfig" %>
<%@ include file="header.jsp" %>

<%
    int totalDoctors = 0, totalPatients = 0, totalAppointments = 0, todayAppointments = 0;

    Map<String, Integer> monthAppointmentCounts = new LinkedHashMap<String, Integer>();
    Map<String, Integer> specAppointmentCounts = new LinkedHashMap<String, Integer>();
    Map<String, Integer> hourlyCounts = new LinkedHashMap<String, Integer>();
    Map<String, Integer> dailyCounts = new LinkedHashMap<String, Integer>();
    Map<String, Integer> weeklyCounts = new LinkedHashMap<String, Integer>();
    List<String> allDoctors = new ArrayList<String>();
    Map<String, int[]> doctorMonthlyAppointmentData = new LinkedHashMap<String, int[]>();

    // Per-doctor slab data (hourly, daily, weekly)
    Map<String, Map<String, List<Integer>>> doctorSlabMap =
        new LinkedHashMap<String, Map<String, List<Integer>>>();

    String[] monthsLabels = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" };
    for (String month : monthsLabels) {
        monthAppointmentCounts.put(month, 0);
    }

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = new dbconfig().getConnection();
        stmt = con.createStatement();

        // Hourly counts
        rs = stmt.executeQuery("SELECT a_Time, COUNT(*) AS cnt FROM appointmentss GROUP BY a_Time ORDER BY a_Time");
        while (rs.next()) {
            hourlyCounts.put(rs.getString("a_Time"), rs.getInt("cnt"));
        }
        rs.close();

        // Daily counts (30 days)
        rs = stmt.executeQuery("SELECT a_Date, COUNT(*) AS cnt FROM appointmentss " +
                               "WHERE a_Date >= CURDATE() - INTERVAL 30 DAY GROUP BY a_Date ORDER BY a_Date");
        while (rs.next()) {
            dailyCounts.put(rs.getDate("a_Date").toString(), rs.getInt("cnt"));
        }
        rs.close();

        // Weekly counts (90 days)
        rs = stmt.executeQuery("SELECT YEARWEEK(a_Date, 1) AS yw, COUNT(*) AS cnt FROM appointmentss " +
                               "WHERE a_Date >= CURDATE() - INTERVAL 90 DAY GROUP BY yw ORDER BY yw");
        while (rs.next()) {
            weeklyCounts.put(rs.getString("yw"), rs.getInt("cnt"));
        }
        rs.close();

        // Summary stats
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

        // Monthly appointment counts
        rs = stmt.executeQuery("SELECT DATE_FORMAT(a_Date, '%b') AS mon, COUNT(*) AS cnt FROM appointmentss GROUP BY MONTH(a_Date)");
        while (rs.next()) {
            monthAppointmentCounts.put(rs.getString("mon"), rs.getInt("cnt"));
        }
        rs.close();

        // Specialization counts
        rs = stmt.executeQuery("SELECT d.specialization, COUNT(*) AS cnt FROM appointmentss a " +
                               "JOIN doctor d ON a.doctorname = d.doctorname GROUP BY d.specialization");
        while (rs.next()) {
            specAppointmentCounts.put(rs.getString("specialization"), rs.getInt("cnt"));
        }
        rs.close();

        // All doctors
        rs = stmt.executeQuery("SELECT doctorname FROM doctor ORDER BY doctorname");
        while (rs.next()) {
            allDoctors.add(rs.getString(1));
        }
        rs.close();

        // Initialize doctorMonthlyAppointmentData + doctorSlabMap
        for (String doc : allDoctors) {
            doctorMonthlyAppointmentData.put(doc, new int[12]);
            Map<String, List<Integer>> slabMap = new LinkedHashMap<String, List<Integer>>();
            slabMap.put("hourly", new ArrayList<Integer>());
            slabMap.put("daily", new ArrayList<Integer>());
            slabMap.put("weekly", new ArrayList<Integer>());
            doctorSlabMap.put(doc, slabMap);
        }

     
 // Avoid diamond operator for compatibility with Java < 7
List<String> dayLabelsList = new ArrayList<String>();

Calendar cal = Calendar.getInstance();
cal.add(Calendar.DATE, -29); // 30 days ago including today

for (int i = 0; i < 30; i++) {
    java.util.Date date = cal.getTime();  // Use fully qualified Date
    dayLabelsList.add(new java.text.SimpleDateFormat("yyyy-MM-dd").format(date));
    cal.add(Calendar.DATE, 1);
}

// Avoid diamond operator for Map
Map<String, int[]> doctorDailyAppointmentData = new LinkedHashMap<String, int[]>();
for (String doc : allDoctors) {
    doctorDailyAppointmentData.put(doc, new int[30]);
}


// Query to get daily appointments per doctor for last 30 days
rs = stmt.executeQuery("SELECT doctorname, a_Date, COUNT(*) AS cnt FROM appointmentss " +
                       "WHERE a_Date >= CURDATE() - INTERVAL 29 DAY GROUP BY doctorname, a_Date ORDER BY doctorname, a_Date");

while (rs.next()) {
    String doc = rs.getString("doctorname");
    String dateStr = rs.getDate("a_Date").toString();
    int cnt = rs.getInt("cnt");

    int[] arr = doctorDailyAppointmentData.get(doc);
    if (arr != null) {
        int idx = dayLabelsList.indexOf(dateStr);
        if (idx >= 0) {
            arr[idx] = cnt;
        }
    }
}
rs.close();

// Save dayLabelsList and doctorDailyAppointmentData in request for use in JSP
request.setAttribute("dayLabelsList", dayLabelsList);
request.setAttribute("doctorDailyAppointmentData", doctorDailyAppointmentData);


        // Fill doctor slab data (hourly)
        for (String doc : allDoctors) {
            rs = stmt.executeQuery("SELECT a_Time, COUNT(*) AS cnt FROM appointmentss WHERE doctorname='" + doc + "' GROUP BY a_Time ORDER BY a_Time");
            List<Integer> list = doctorSlabMap.get(doc).get("hourly");
            while (rs.next()) list.add(rs.getInt("cnt"));
            rs.close();
        }
        // Fill daily
        for (String doc : allDoctors) {
            rs = stmt.executeQuery("SELECT a_Date, COUNT(*) AS cnt FROM appointmentss WHERE doctorname='" + doc + "' " +
                                   "AND a_Date >= CURDATE() - INTERVAL 30 DAY GROUP BY a_Date ORDER BY a_Date");
            List<Integer> list = doctorSlabMap.get(doc).get("daily");
            while (rs.next()) list.add(rs.getInt("cnt"));
            rs.close();
        }
        // Fill weekly
        for (String doc : allDoctors) {
            rs = stmt.executeQuery("SELECT YEARWEEK(a_Date,1) AS yw, COUNT(*) AS cnt FROM appointmentss WHERE doctorname='" + doc + "' " +
                                   "AND a_Date >= CURDATE() - INTERVAL 90 DAY GROUP BY yw ORDER BY yw");
            List<Integer> list = doctorSlabMap.get(doc).get("weekly");
            while (rs.next()) list.add(rs.getInt("cnt"));
            rs.close();
        }

        request.setAttribute("doctorSlabMap", doctorSlabMap);

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

    <!-- Summary Cards -->
    <div class="row mt-3">
      <div class="col-md-3 mb-3"><div class="card shadow-sm">
              <div class="card-body text-center">
                  <h6>Total Doctors</h6><h4><%= totalDoctors %></h4>
              </div></div></div>
      <div class="col-md-3 mb-3">
          <div class="card shadow-sm"><div class="card-body text-center">
                  <h6>Total Patients</h6><h4><%= totalPatients %></h4>
              </div></div></div>
      <div class="col-md-3 mb-3">
          <div class="card shadow-sm">
              <div class="card-body text-center">
                  <h6>Appointments (30 days)</h6><h4><%= totalAppointments %></h4>
              </div></div></div>
      <div class="col-md-3 mb-3">
          <div class="card shadow-sm"><div class="card-body text-center">
                  <h6>Today's Appointments</h6><h4><%= todayAppointments %></h4>
              </div></div></div>
    </div>

    <!-- Charts Row -->
    <div class="row mt-4">
      <div class="col-md-6 mb-4">
          <div class="card shadow-sm p-3">
              <h5>Monthly Appointments</h5><canvas id="monthChart" height="250">
                  
              </canvas></div></div>
      <div class="col-md-6 mb-4">
          <div class="card shadow-sm p-3">
              <h5>Appointments by Specialization</h5>
              <canvas id="specializationChart" height="250"></canvas></div></div>
    </div>
  <%
  String firstDoctor = allDoctors.size() > 0 ? allDoctors.get(0) : "";
%>
   <!-- Doctor-wise Daily Appointments -->
<div class="row mt-4">
  <div class="col-md-12 mb-4" style="padding: 15px; background: #f9f9f9; border-radius: 8px; box-shadow: 0 0 8px rgba(0,0,0,0.1);">
    <h5>Doctor-wise Daily Appointments</h5>
    <select id="doctorSelect" class="form-control mb-3" style="max-width: 320px;">
      <option value="">-- Select Doctor --</option>
      <% for (String doc : allDoctors) { %>
        <option value="<%= doc %>"><%= doc %></option>
      <% } %>
    </select>
    <canvas id="doctorDailyChart" height="100"></canvas>
  </div>
</div>


    <!-- Doctor Capacity Slab-wise Dashboard -->
  

<div class="row mt-4">
  <div class="col-md-6 " style="padding: 15px; background: #f9f9f9; border-radius: 8px; box-shadow: 0 0 8px rgba(0,0,0,0.1);">
       <h5>Doctor Capacity Slab-wise </h5>
    <label for="slabSelect">Select Capacity Slab:</label>
    <select id="slabSelect" class="form-control">
      <option value="hourly">Hourly Slots</option>
      <option value="daily">Daily</option>
      <option value="weekly">Weekly</option>
    </select>
  </div>
</div>
<div class="row mt-4">
  <div class="col-md-6" style="padding: 15px; background: #f9f9f9; border-radius: 8px; box-shadow: 0 0 8px rgba(0,0,0,0.1);">
    <label for="doctorSlabSelect">Select Doctor:</label>
    <select id="doctorSlabSelect" class="form-control">
      <option value="">-- All Doctors --</option>
      <% for (String doc : allDoctors) { %>
        <option value="<%= doc %>" <%= doc.equals(firstDoctor) ? "selected" : "" %>><%= doc %></option>
      <% } %>
    </select>
  </div>
</div>
<canvas id="capacityChart" height="100" style="margin-top: 30px; background: #fff; border-radius: 8px;"></canvas>
</div>
  </div>

<%@ include file="footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
     window.addEventListener('load', function () {
    // Auto-load Doctor-wise Monthly Chart
    const docSelect = document.getElementById('doctorSelect');
    if (docSelect && docSelect.value) {
      docSelect.dispatchEvent(new Event('change')); // Trigger the chart for first doctor
    }

    // Auto-load Capacity Chart with selected doctor or All
    updateCapacityChart(); // already handles selected doctor
  });
    // Monthly Appointments chart data
  var monthLabels = [
    <% 
      for (int i = 0; i < monthsLabels.length; i++) {
        out.print("'" + monthsLabels[i] + "'");
        if (i < monthsLabels.length - 1) out.print(", ");
      }
    %>
  ];
  var monthData = [
    <% 
      for (int i = 0; i < monthsLabels.length; i++) {
        Integer cnt = monthAppointmentCounts.get(monthsLabels[i]);
        out.print(cnt != null ? cnt : 0);
        if (i < monthsLabels.length - 1) out.print(", ");
      }
    %>
  ];

  new Chart(document.getElementById('monthChart').getContext('2d'), {
    type: 'line',
    data: {
      labels: monthLabels,
      datasets: [{
        label: 'Appointments',
        data: monthData,
        borderColor: '#007bff',
        backgroundColor: 'rgba(0,123,255,0.1)',
        fill: true,
        tension: 0.3
      }]
    },
    options: {
      responsive: true,
      scales: {
        y: { beginAtZero: true }
      }
    }
  });
  // Specialization chart data
  var specLabels = [
    <%
      Iterator<String> it = specAppointmentCounts.keySet().iterator();
      while (it.hasNext()) {
        String key = it.next();
        out.print("'" + key + "'");
        if (it.hasNext()) out.print(", ");
      }
    %>
  ];
  var specData = [
    <%
      Iterator<Integer> itv = specAppointmentCounts.values().iterator();
      while (itv.hasNext()) {
        out.print(itv.next());
        if (itv.hasNext()) out.print(", ");
      }
    %>
  ];

  new Chart(document.getElementById('specializationChart').getContext('2d'), {
    type: 'bar',
    data: {
      labels: specLabels,
      datasets: [{
        label: 'Appointments',
        data: specData,
        backgroundColor: '#ff9800'
      }]
    },
    options: {
      responsive: true,
      scales: {
        y: { beginAtZero: true }
      }
    }
  });
  // doctorMonthlyData// Fetch dayLabels from backend
  var dayLabels = [
    <% 
      List<String> dayLabelsList = (List<String>) request.getAttribute("dayLabelsList");
      for (int i = 0; i < dayLabelsList.size(); i++) {
        out.print("'" + dayLabelsList.get(i) + "'");
        if (i < dayLabelsList.size() - 1) out.print(", ");
      }
    %>
  ];

  // Fetch doctorDailyAppointmentData from backend
  var doctorDailyData = {
    <% 
      Map<String, int[]> doctorDailyAppointmentData = (Map<String, int[]>) request.getAttribute("doctorDailyAppointmentData");
      int docCount = 0;
      for (String doc : allDoctors) {
        int[] arr = doctorDailyAppointmentData.get(doc);
        out.print("\"" + doc + "\": [");
        for (int j = 0; j < arr.length; j++) {
          out.print(arr[j]);
          if (j < arr.length - 1) out.print(", ");
        }
        out.print("]");
        if (++docCount < allDoctors.size()) out.print(", ");
      }
    %>
  };

  var doctorChart = null;

  function renderDoctorChart(doctorName) {
    var ctx = document.getElementById('doctorDailyChart').getContext('2d');
    if (doctorChart) doctorChart.destroy();
    if (!doctorName || !doctorDailyData[doctorName]) return;

    doctorChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: dayLabels,
        datasets: [{
          label: doctorName + ' - Daily Appointments',
          data: doctorDailyData[doctorName],
          borderColor: '#2196f3',
          backgroundColor: 'rgba(33, 150, 243, 0.2)',
          fill: true,
          tension: 0.3
        }]
      },
      options: {
        responsive: true,
        scales: {
          y: {
            beginAtZero: true
          },
          x: {
            ticks: {
              autoSkip: true,
              maxTicksLimit: 10
            }
          }
        }
      }
    });
  }

  // Event listener for doctor selection
  document.getElementById('doctorSelect').addEventListener('change', function () {
    var selected = this.value;
    renderDoctorChart(selected);
  });

  // Automatically select and show the first doctor on page load
  window.addEventListener('DOMContentLoaded', function () {
    var select = document.getElementById('doctorSelect');
    if (select.options.length > 1) {
      select.selectedIndex = 1; // Select first doctor (not placeholder)
      renderDoctorChart(select.value);
    }
  });

  // doctorSlabData
  var doctorSlabData={
    <%
      Map<String, Map<String, List<Integer>>> dsp=(Map<String, Map<String, List<Integer>>>)request.getAttribute("doctorSlabMap");
      int dcount=0;
      for(String doc:allDoctors){
        Map<String, List<Integer>> smap=dsp.get(doc);
        StringBuilder hb=new StringBuilder();List<Integer> hl=smap.get("hourly");for(int i=0;i<hl.size();i++){hb.append(hl.get(i));if(i<hl.size()-1) hb.append(",");}
        StringBuilder db=new StringBuilder();List<Integer> dl=smap.get("daily");for(int i=0;i<dl.size();i++){db.append(dl.get(i));if(i<dl.size()-1) db.append(",");}
        StringBuilder wb=new StringBuilder();List<Integer> wl=smap.get("weekly");for(int i=0;i<wl.size();i++){wb.append(wl.get(i));if(i<wl.size()-1) wb.append(",");}
        out.print("\""+doc+"\":{hourly:["+hb.toString()+"],daily:["+db.toString()+"],weekly:["+wb.toString()+"]}");
        if(dcount<allDoctors.size()-1) out.print(",");
        dcount++;
      }
    %>
  };

  var ctxCap=document.getElementById('capacityChart').getContext('2d');
  var capacityChart=null;
  function createCapacityChart(labels,data,label){
    if(capacityChart) capacityChart.destroy();
    capacityChart=new Chart(ctxCap,{type:'bar',data:{labels:labels,datasets:[{label:label+' Appointments',data:data,backgroundColor:'rgba(54,162,235,0.7)',borderColor:'rgba(54,162,235,1)',borderWidth:1,borderRadius:5}]},options:{responsive:true,scales:{x:{ticks:{maxRotation:90,minRotation:45,autoSkip:false}},y:{beginAtZero:true}}}});
  }

  function updateCapacityChart(){
    var slab=document.getElementById('slabSelect').value;
    var doc=document.getElementById('doctorSlabSelect').value;
    var labels=[],data=[];
    if(doc&&doctorSlabData[doc]){labels=doctorSlabData[doc][slab].map((v,i)=>slab+" "+(i+1));data=doctorSlabData[doc][slab];}
    else{ // aggregate across all
      var maxlen=0;allDoctors.forEach(d=>{if(doctorSlabData[d][slab].length>maxlen)maxlen=doctorSlabData[d][slab].length;});
      for(var i=0;i<maxlen;i++){labels.push(slab+" "+(i+1));var sum=0;allDoctors.forEach(d=>{sum+=doctorSlabData[d][slab][i]||0;});data.push(sum);}
    }
    createCapacityChart(labels,data,doc?doc:("All Doctors ("+slab+")"));
  }

  document.getElementById('slabSelect').addEventListener('change',updateCapacityChart);
  document.getElementById('doctorSlabSelect').addEventListener('change',updateCapacityChart);
  updateCapacityChart();
</script> 