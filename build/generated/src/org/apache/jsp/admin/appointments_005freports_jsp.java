package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.sql.*;
import Database.dbconfig;

public final class appointments_005freports_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


/**
 * Escape a string for safe embedding into single-quoted JS string in HTML.
 * Replaces backslash, single-quote, double-quote, CR and LF.
 */
public String jsEscape(String s) {
    if (s == null) return "";
    return s.replace("\\", "\\\\").replace("'", "\\'").replace("\"", "\\\"").replace("\r", " ").replace("\n", " ");
}

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList<String>(2);
    _jspx_dependants.add("/admin/header.jsp");
    _jspx_dependants.add("/admin/footer.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<!-- [Head] start -->\n");
      out.write("\n");
      out.write("<head>\n");
      out.write("  <title>Home | Mantis Bootstrap 5 Admin Template</title>\n");
      out.write("  <!-- [Meta] -->\n");
      out.write("  <meta charset=\"utf-8\">\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui\">\n");
      out.write("  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n");
      out.write("  <meta name=\"description\" content=\"Mantis is made using Bootstrap 5 design framework. Download the free admin template & use it for your project.\">\n");
      out.write("  <meta name=\"keywords\" content=\"Mantis, Dashboard UI Kit, Bootstrap 5, Admin Template, Admin Dashboard, CRM, CMS, Bootstrap Admin Template\">\n");
      out.write("  <meta name=\"author\" content=\"CodedThemes\">\n");
      out.write("\n");
      out.write("  <!-- [Favicon] icon -->\n");
      out.write("  <link rel=\"icon\" href=\"../assets/images/favicon.svg\" type=\"image/x-icon\"> <!-- [Google Font] Family -->\n");
      out.write("<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;500;600;700&display=swap\" id=\"main-font-link\">\n");
      out.write("<!-- [Tabler Icons] https://tablericons.com -->\n");
      out.write("<link rel=\"stylesheet\" href=\"../assets/fonts/tabler-icons.min.css\" >\n");
      out.write("<!-- [Feather Icons] https://feathericons.com -->\n");
      out.write("<link rel=\"stylesheet\" href=\"../assets/fonts/feather.css\" >\n");
      out.write("<!-- [Font Awesome Icons] https://fontawesome.com/icons -->\n");
      out.write("<link rel=\"stylesheet\" href=\"../assets/fonts/fontawesome.css\" >\n");
      out.write("<!-- [Material Icons] https://fonts.google.com/icons -->\n");
      out.write("<link rel=\"stylesheet\" href=\"../assets/fonts/material.css\" >\n");
      out.write("<!-- [Template CSS Files] -->\n");
      out.write("<link rel=\"stylesheet\" href=\"../assets/css/style.css\" id=\"main-style-link\" >\n");
      out.write("<link rel=\"stylesheet\" href=\"../assets/css/style-preset.css\" >\n");
      out.write("\n");
      out.write("</head>\n");
      out.write("<!-- [Head] end -->\n");
      out.write("<!-- [Body] Start -->\n");
      out.write("\n");
      out.write("<body data-pc-preset=\"preset-1\" data-pc-direction=\"ltr\" data-pc-theme=\"light\">\n");
      out.write("  <!-- [ Pre-loader ] start -->\n");
      out.write("<div class=\"loader-bg\">\n");
      out.write("  <div class=\"loader-track\">\n");
      out.write("    <div class=\"loader-fill\"></div>\n");
      out.write("  </div>\n");
      out.write("</div>\n");
      out.write("<!-- [ Pre-loader ] End -->\n");
      out.write(" <!-- [ Sidebar Menu ] start -->\n");
      out.write("<nav class=\"pc-sidebar\">\n");
      out.write("  <div class=\"navbar-wrapper\">\n");
      out.write("    <div class=\"m-header\">\n");
      out.write("      <a href=\"dashboard/index.html\" class=\"b-brand text-primary\">\n");
      out.write("        <!-- ========   Change your logo from here   ============ -->\n");
      out.write("        <img src=\"assets/images/logo-dark.svg\" class=\"img-fluid logo-lg\" alt=\"logo\">\n");
      out.write("      </a>\n");
      out.write("    </div>\n");
      out.write("      <div class=\"navbar-content\" >\n");
      out.write("      <ul class=\"pc-navbar\" >\n");
      out.write("        <li class=\"pc-item\" >\n");
      out.write("          <a href=\"dashboard.jsp\" class=\"pc-link\" >\n");
      out.write("            <span class=\"pc-micon\" ><i class=\"ti ti-dashboard\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Dashboard</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("\n");
      out.write("        <li class=\"pc-item pc-caption\">\n");
      out.write("          <label>View</label>\n");
      out.write("          <i class=\"ti ti-dashboard\"></i>\n");
      out.write("        </li>\n");
      out.write("        <li class=\"pc-item\">\n");
      out.write("          <a href=\"apointments.jsp\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-typography\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Appointments</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("        <li class=\"pc-item\">\n");
      out.write("          <a href=\"doctor.jsp\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-stethoscope\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Doctors</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("        <li class=\"pc-item\">\n");
      out.write("          <a href=\"patients.jsp\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-friends\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Patients</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("\n");
      out.write("        <li class=\"pc-item pc-caption\">\n");
      out.write("          <label>ADD Pages</label>\n");
      out.write("          <i class=\"ti ti-news\"></i>\n");
      out.write("        </li>\n");
      out.write("        <li class=\"pc-item\">\n");
      out.write("          <a href=\"doctoradd.jsp\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-lock\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Add Doctor</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("        <li class=\"pc-item\">\n");
      out.write("          <a href=\"bookapp.jsp\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-user-plus\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Book app</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("         <li class=\"pc-item\">\n");
      out.write("          <a href=\"addschedule.jsp\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-user-plus\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Add Schedule</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("        \n");
      out.write("         <li class=\"pc-item\">\n");
      out.write("          <a href=\"/hospital/index.html\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-user-plus\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">logout</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("\n");
      out.write("        <li class=\"pc-item pc-caption\">\n");
      out.write("          <label>Edit/Delete</label>\n");
      out.write("          <i class=\"ti ti-brand-chrome\"></i>\n");
      out.write("        </li>\n");
      out.write("        <li class=\"pc-item pc-hasmenu\">\n");
      out.write("          <a href=\"#!\" class=\"pc-link\"><span class=\"pc-micon\"><i class=\"ti ti-menu\"></i></span><span class=\"pc-mtext\">Menu\n");
      out.write("              levels</span><span class=\"pc-arrow\"><i data-feather=\"chevron-right\"></i></span></a>\n");
      out.write("          <ul class=\"pc-submenu\">\n");
      out.write("            <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 2.1</a></li>\n");
      out.write("            <li class=\"pc-item pc-hasmenu\">\n");
      out.write("              <a href=\"#!\" class=\"pc-link\">Level 2.2<span class=\"pc-arrow\"><i data-feather=\"chevron-right\"></i></span></a>\n");
      out.write("              <ul class=\"pc-submenu\">\n");
      out.write("                <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 3.1</a></li>\n");
      out.write("                <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 3.2</a></li>\n");
      out.write("                <li class=\"pc-item pc-hasmenu\">\n");
      out.write("                  <a href=\"#!\" class=\"pc-link\">Level 3.3<span class=\"pc-arrow\"><i data-feather=\"chevron-right\"></i></span></a>\n");
      out.write("                  <ul class=\"pc-submenu\">\n");
      out.write("                    <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 4.1</a></li>\n");
      out.write("                    <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 4.2</a></li>\n");
      out.write("                  </ul>\n");
      out.write("                </li>\n");
      out.write("              </ul>\n");
      out.write("            </li>\n");
      out.write("            <li class=\"pc-item pc-hasmenu\">\n");
      out.write("              <a href=\"#!\" class=\"pc-link\">Level 2.3<span class=\"pc-arrow\"><i data-feather=\"chevron-right\"></i></span></a>\n");
      out.write("              <ul class=\"pc-submenu\">\n");
      out.write("                <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 3.1</a></li>\n");
      out.write("                <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 3.2</a></li>\n");
      out.write("                <li class=\"pc-item pc-hasmenu\">\n");
      out.write("                  <a href=\"#!\" class=\"pc-link\">Level 3.3<span class=\"pc-arrow\"><i data-feather=\"chevron-right\"></i></span></a>\n");
      out.write("                  <ul class=\"pc-submenu\">\n");
      out.write("                    <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 4.1</a></li>\n");
      out.write("                    <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\">Level 4.2</a></li>\n");
      out.write("                  </ul>\n");
      out.write("                </li>\n");
      out.write("              </ul>\n");
      out.write("            </li>\n");
      out.write("          </ul>\n");
      out.write("        </li>\n");
      out.write("        <li class=\"pc-item\">\n");
      out.write("          <a href=\"other/sample-page.html\" class=\"pc-link\">\n");
      out.write("            <span class=\"pc-micon\"><i class=\"ti ti-brand-chrome\"></i></span>\n");
      out.write("            <span class=\"pc-mtext\">Sample page</span>\n");
      out.write("          </a>\n");
      out.write("        </li>\n");
      out.write("      </ul>\n");
      out.write("      \n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("</nav>\n");
      out.write("<!-- [ Sidebar Menu ] end --> <!-- [ Header Topbar ] start -->\n");
      out.write("<header class=\"pc-header\">\n");
      out.write("  <div class=\"header-wrapper\"> <!-- [Mobile Media Block] start -->\n");
      out.write("<div class=\"me-auto pc-mob-drp\">\n");
      out.write("  <ul class=\"list-unstyled\">\n");
      out.write("    <!-- ======= Menu collapse Icon ===== -->\n");
      out.write("    <li class=\"pc-h-item pc-sidebar-collapse\">\n");
      out.write("      <a href=\"#\" class=\"pc-head-link ms-0\" id=\"sidebar-hide\">\n");
      out.write("        <i class=\"ti ti-menu-2\"></i>\n");
      out.write("      </a>\n");
      out.write("    </li>\n");
      out.write("    <li class=\"pc-h-item pc-sidebar-popup\">\n");
      out.write("      <a href=\"#\" class=\"pc-head-link ms-0\" id=\"mobile-collapse\">\n");
      out.write("        <i class=\"ti ti-menu-2\"></i>\n");
      out.write("      </a>\n");
      out.write("    </li>\n");
      out.write("    <li class=\"dropdown pc-h-item d-inline-flex d-md-none\">\n");
      out.write("      <a\n");
      out.write("        class=\"pc-head-link dropdown-toggle arrow-none m-0\"\n");
      out.write("        data-bs-toggle=\"dropdown\"\n");
      out.write("        href=\"#\"\n");
      out.write("        role=\"button\"\n");
      out.write("        aria-haspopup=\"false\"\n");
      out.write("        aria-expanded=\"false\"\n");
      out.write("      >\n");
      out.write("        <i class=\"ti ti-search\"></i>\n");
      out.write("      </a>\n");
      out.write("      <div class=\"dropdown-menu pc-h-dropdown drp-search\">\n");
      out.write("        <form class=\"px-3\">\n");
      out.write("          <div class=\"form-group mb-0 d-flex align-items-center\">\n");
      out.write("            <i data-feather=\"search\"></i>\n");
      out.write("            <input type=\"search\" class=\"form-control border-0 shadow-none\" placeholder=\"Search here. . .\">\n");
      out.write("          </div>\n");
      out.write("        </form>\n");
      out.write("      </div>\n");
      out.write("    </li>\n");
      out.write("   \n");
      out.write("</header>\n");
      out.write("<!-- [ Header ] end -->\n");
      out.write('\n');
      out.write('\n');
      out.write('\n');
      out.write('\n');

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

      out.write("\n");
      out.write("\n");
      out.write("<div class=\"pc-container\">\n");
      out.write("  <div class=\"pc-content\">\n");
      out.write("\n");
      out.write("    <div class=\"row mt-3\">\n");
      out.write("      <div class=\"col-md-3 mb-3\">\n");
      out.write("        <div class=\"card shadow-sm text-center\">\n");
      out.write("          <div class=\"card-body\">\n");
      out.write("            <h6>Total Doctors</h6>\n");
      out.write("            <h4>");
      out.print( totalDoctors );
      out.write("</h4>\n");
      out.write("            <small class=\"text-muted\">Doctor records updated</small><br>\n");
      out.write("            <button class=\"btn btn-primary btn-sm mt-2\" onclick=\"showDoctors()\">View</button>\n");
      out.write("          </div>\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("\n");
      out.write("      <div class=\"col-md-3 mb-3\">\n");
      out.write("        <div class=\"card shadow-sm text-center\">\n");
      out.write("          <div class=\"card-body\">\n");
      out.write("            <h6>Total Patients</h6>\n");
      out.write("            <h4>");
      out.print( totalPatients );
      out.write("</h4>\n");
      out.write("            <small class=\"text-muted\">Patient records updated</small><br>\n");
      out.write("            <button class=\"btn btn-primary btn-sm mt-2\" onclick=\"showPatients()\">View</button>\n");
      out.write("          </div>\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("\n");
      out.write("      <div class=\"col-md-3 mb-3\">\n");
      out.write("        <div class=\"card shadow-sm text-center\">\n");
      out.write("          <div class=\"card-body\">\n");
      out.write("            <h6>Appointments (30 days)</h6>\n");
      out.write("            <h4>");
      out.print( totalAppointments );
      out.write("</h4>\n");
      out.write("            <small class=\"text-muted\">Past 30 days summary</small><br>\n");
      out.write("            <button class=\"btn btn-primary btn-sm mt-2\" onclick=\"showAppointments()\">View</button>\n");
      out.write("          </div>\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("\n");
      out.write("      <div class=\"col-md-3 mb-3\">\n");
      out.write("        <div class=\"card shadow-sm text-center\">\n");
      out.write("          <div class=\"card-body\">\n");
      out.write("            <h6>Today's Appointments</h6>\n");
      out.write("            <h4>");
      out.print( todayAppointments );
      out.write("</h4>\n");
      out.write("            <small class=\"text-muted\">Updated today</small><br>\n");
      out.write("            <button class=\"btn btn-primary btn-sm mt-2\" onclick=\"showTodayAppointments()\">View</button>\n");
      out.write("          </div>\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <div id=\"detailSection\" class=\"mt-4 p-3\" style=\"background:#f9f9f9;border-radius:8px;min-height:150px;\">\n");
      out.write("      <h5>Click a button to see details</h5>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("  </div>\n");
      out.write("</div>\n");
      out.write("\n");
      out.write("<!-- [ Main Content ] end -->\n");
      out.write("  <footer class=\"pc-footer\">\n");
      out.write("    <div class=\"footer-wrapper container-fluid\">\n");
      out.write("      <div class=\"row\">\n");
      out.write("        <div class=\"col-sm my-1\">\n");
      out.write("          <p class=\"m-0\"\n");
      out.write("            > &copy; 2025 Clinic Management System. All Rights Reserved. <a href=\"https://themeforest.net/user/codedthemes\" target=\"_blank\"></a> <a href=\"https://themewagon.com/\"></a>.</p\n");
      out.write("          >\n");
      out.write("        </div>\n");
      out.write("        <div class=\"col-auto my-1\">\n");
      out.write("          <ul class=\"list-inline footer-link mb-0\">\n");
      out.write("            <li class=\"list-inline-item\"><a href=\"index.html\">Home</a></li>\n");
      out.write("          </ul>\n");
      out.write("        </div>\n");
      out.write("      </div>\n");
      out.write("    </div>\n");
      out.write("  </footer>\n");
      out.write("\n");
      out.write("  <!-- [Page Specific JS] start -->\n");
      out.write("  <script src=\"../assets/js/plugins/apexcharts.min.js\"></script>\n");
      out.write("  <script src=\"../assets/js/pages/dashboard-default.js\"></script>\n");
      out.write("  <!-- [Page Specific JS] end -->\n");
      out.write("  <!-- Required Js -->\n");
      out.write("  <script src=\"../assets/js/plugins/popper.min.js\"></script>\n");
      out.write("  <script src=\"../assets/js/plugins/simplebar.min.js\"></script>\n");
      out.write("  <script src=\"../assets/js/plugins/bootstrap.min.js\"></script>\n");
      out.write("  <script src=\"../assets/js/fonts/custom-font.js\"></script>\n");
      out.write("  <script src=\"../assets/js/pcoded.js\"></script>\n");
      out.write("  <script src=\"../assets/js/plugins/feather.min.js\"></script>\n");
      out.write("\n");
      out.write("  \n");
      out.write("  \n");
      out.write("  \n");
      out.write("  \n");
      out.write("  <script>layout_change('light');</script>\n");
      out.write("  \n");
      out.write("  \n");
      out.write("  \n");
      out.write("  \n");
      out.write("  <script>change_box_container('false');</script>\n");
      out.write("  \n");
      out.write("  \n");
      out.write("  \n");
      out.write("  <script>layout_rtl_change('false');</script>\n");
      out.write("  \n");
      out.write("  \n");
      out.write("  <script>preset_change(\"preset-1\");</script>\n");
      out.write("  \n");
      out.write("  \n");
      out.write("  <script>font_change(\"Public-Sans\");</script>\n");
      out.write("  \n");
      out.write("    \n");
      out.write("\n");
      out.write("\n");
      out.write("<script>\n");
      out.write("/* -------------------------------\n");
      out.write("   EMBED JAVASCRIPT ARRAYS (safe server-side escaping)\n");
      out.write("--------------------------------*/\n");
      out.write("\n");
      out.write("var doctorList = [\n");
 for (int i=0;i<doctorList.size();i++){ 
       String d = doctorList.get(i);

      out.write("\n");
      out.write("    '");
      out.print( jsEscape(d) );
      out.write('\'');
      out.print( (i < doctorList.size()-1 ? "," : "") );
      out.write('\n');
 } 
      out.write("\n");
      out.write("];\n");
      out.write("\n");
      out.write("var doctorInfo = {\n");
 int ci = 0;
   for (Iterator<String> it = doctorInfo.keySet().iterator(); it.hasNext(); ) {
       String doc = it.next();
       String inf = doctorInfo.get(doc);

      out.write("\n");
      out.write("   '");
      out.print( jsEscape(doc) );
      out.write("': '");
      out.print( jsEscape(inf) );
      out.write('\'');
      out.print( (ci++ < doctorInfo.size()-1 ? "," : "") );
      out.write('\n');
 } 
      out.write("\n");
      out.write("};\n");
      out.write("\n");
      out.write("var doctorMonthly = {\n");
 ci=0;
   for (Iterator<Map.Entry<String,Integer>> it = doctorMonthlyAppointments.entrySet().iterator(); it.hasNext(); ) {
       Map.Entry<String,Integer> e = it.next();

      out.write("\n");
      out.write("   '");
      out.print( jsEscape(e.getKey()) );
      out.write("': ");
      out.print( e.getValue() );
      out.print( (ci++ < doctorMonthlyAppointments.size()-1 ? "," : "") );
      out.write('\n');
 } 
      out.write("\n");
      out.write("};\n");
      out.write("\n");
      out.write("var doctorDaily = {\n");
 ci=0;
   for (Iterator<Map.Entry<String,Integer>> it = doctorDailyAppointments.entrySet().iterator(); it.hasNext(); ) {
       Map.Entry<String,Integer> e = it.next();

      out.write("\n");
      out.write("   '");
      out.print( jsEscape(e.getKey()) );
      out.write("': ");
      out.print( e.getValue() );
      out.print( (ci++ < doctorDailyAppointments.size()-1 ? "," : "") );
      out.write('\n');
 } 
      out.write("\n");
      out.write("};\n");
      out.write("\n");
      out.write("var doctorMonthlyDetails = {\n");
 ci=0;
   for (Iterator<String> it = doctorMonthlyDetails.keySet().iterator(); it.hasNext(); ) {
       String doc = it.next();
       List<String> list = doctorMonthlyDetails.get(doc);

      out.write("\n");
      out.write("   '");
      out.print( jsEscape(doc) );
      out.write("': [\n");
      out.write("   ");
 for (int j=0;j<list.size();j++){ 
      out.write("\n");
      out.write("       '");
      out.print( jsEscape(list.get(j)) );
      out.write('\'');
      out.print( (j < list.size()-1 ? "," : "") );
      out.write("\n");
      out.write("   ");
 } 
      out.write("\n");
      out.write("   ]");
      out.print( (ci++ < doctorMonthlyDetails.size()-1 ? "," : "") );
      out.write('\n');
 } 
      out.write("\n");
      out.write("};\n");
      out.write("\n");
      out.write("var doctorDailyDetails = {\n");
 ci=0;
   for (Iterator<String> it = doctorDailyDetails.keySet().iterator(); it.hasNext(); ) {
       String doc = it.next();
       List<String> list = doctorDailyDetails.get(doc);

      out.write("\n");
      out.write("   '");
      out.print( jsEscape(doc) );
      out.write("': [\n");
      out.write("   ");
 for (int j=0;j<list.size();j++){ 
      out.write("\n");
      out.write("       '");
      out.print( jsEscape(list.get(j)) );
      out.write('\'');
      out.print( (j < list.size()-1 ? "," : "") );
      out.write("\n");
      out.write("   ");
 } 
      out.write("\n");
      out.write("   ]");
      out.print( (ci++ < doctorDailyDetails.size()-1 ? "," : "") );
      out.write('\n');
 } 
      out.write("\n");
      out.write("};\n");
      out.write("\n");
      out.write("/* -------------------------------\n");
      out.write("   DISPLAY FUNCTIONS\n");
      out.write("--------------------------------*/\n");
      out.write("\n");
      out.write("function showDoctors() {\n");
      out.write("    var html = \"<h5>Doctors List</h5><ul>\";\n");
      out.write("    doctorList.forEach(function(doc) {\n");
      out.write("        // doc is escaped server-side already\n");
      out.write("        html += \"<li><b>\" + doc + \"</b> - Daily: \" + (doctorDaily[doc] || 0) +\n");
      out.write("            \" <button class='btn btn-link p-0' onclick=\\\"showDailyDetails('\" + doc + \"')\\\">Daily Details</button>, \" +\n");
      out.write("            \"Monthly: \" + (doctorMonthly[doc] || 0) +\n");
      out.write("            \" <button class='btn btn-link p-0' onclick=\\\"showMonthlyDetails('\" + doc + \"')\\\">Monthly Details</button></li>\";\n");
      out.write("    });\n");
      out.write("    html += \"</ul>\";\n");
      out.write("    document.getElementById(\"detailSection\").innerHTML = html;\n");
      out.write("}\n");
      out.write("\n");
      out.write("function showDoctorInfo(doc) {\n");
      out.write("    document.getElementById(\"detailSection\").innerHTML =\n");
      out.write("        \"<h5>Doctor Info</h5><p>\" + (doctorInfo[doc] || \"No info\") + \"</p>\";\n");
      out.write("}\n");
      out.write("\n");
      out.write("function showPatients() {\n");
      out.write("    document.getElementById(\"detailSection\").innerHTML =\n");
      out.write("        \"<h5>Total Patients</h5><p>");
      out.print( totalPatients );
      out.write(" patients registered.</p>\";\n");
      out.write("}\n");
      out.write("\n");
      out.write("function showAppointments() {\n");
      out.write("    var html = \"<h5>Appointments (Last 30 Days)</h5>\";\n");
      out.write("    var all = [];\n");
      out.write("    for (var d in doctorMonthlyDetails) {\n");
      out.write("        if (doctorMonthlyDetails.hasOwnProperty(d)) {\n");
      out.write("            all = all.concat(doctorMonthlyDetails[d]);\n");
      out.write("        }\n");
      out.write("    }\n");
      out.write("    if (all.length === 0) html += \"<p>No appointments found.</p>\";\n");
      out.write("    else {\n");
      out.write("        html += \"<ul>\";\n");
      out.write("        all.forEach(function(i){ html += \"<li>\" + i + \"</li>\"; });\n");
      out.write("        html += \"</ul>\";\n");
      out.write("    }\n");
      out.write("    document.getElementById(\"detailSection\").innerHTML = html;\n");
      out.write("}\n");
      out.write("\n");
      out.write("function showTodayAppointments() {\n");
      out.write("    var html = \"<h5>Today's Appointments</h5><ul>\";\n");
      out.write("    for (var d in doctorDaily) {\n");
      out.write("        if (doctorDaily.hasOwnProperty(d)) {\n");
      out.write("            html += \"<li>\" + d + \": \" + doctorDaily[d] +\n");
      out.write("                \" <button class='btn btn-link p-0' onclick=\\\"showDailyDetails('\" + d + \"')\\\">Details</button></li>\";\n");
      out.write("        }\n");
      out.write("    }\n");
      out.write("    html += \"</ul>\";\n");
      out.write("    document.getElementById(\"detailSection\").innerHTML = html;\n");
      out.write("}\n");
      out.write("\n");
      out.write("function showMonthlyDetails(doc) {\n");
      out.write("    var list = doctorMonthlyDetails[doc] || [];\n");
      out.write("    var html = \"<h5>Monthly Appointments for \" + doc + \"</h5>\";\n");
      out.write("    if (list.length === 0) html += \"<p>No appointments in last 30 days.</p>\";\n");
      out.write("    else {\n");
      out.write("        html += \"<ul>\";\n");
      out.write("        list.forEach(function(i){ html += \"<li>\" + i + \"</li>\"; });\n");
      out.write("        html += \"</ul>\";\n");
      out.write("    }\n");
      out.write("    document.getElementById(\"detailSection\").innerHTML = html;\n");
      out.write("}\n");
      out.write("\n");
      out.write("function showDailyDetails(doc) {\n");
      out.write("    var list = doctorDailyDetails[doc] || [];\n");
      out.write("    var html = \"<h5>Today's Appointments for \" + doc + \"</h5>\";\n");
      out.write("    if (list.length === 0) html += \"<p>No appointments today.</p>\";\n");
      out.write("    else {\n");
      out.write("        html += \"<ul>\";\n");
      out.write("        list.forEach(function(i){ html += \"<li>\" + i + \"</li>\"; });\n");
      out.write("        html += \"</ul>\";\n");
      out.write("    }\n");
      out.write("    document.getElementById(\"detailSection\").innerHTML = html;\n");
      out.write("}\n");
      out.write("</script>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
