package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import Database.dbconfig;

public final class slots_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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
      out.write("\n");
      out.write("\n");
      out.write("<div class=\"pc-container\">\n");
      out.write("  <div class=\"pc-content\">\n");
      out.write("\n");

    String errorMessage = (String) session.getAttribute("errorMessage");
    String successMessage = (String) session.getAttribute("successMessage");

    if (errorMessage != null) {

      out.write("\n");
      out.write("    <p class=\"message error-message\">");
      out.print( errorMessage );
      out.write("</p>\n");

        session.removeAttribute("errorMessage");
    }

    if (successMessage != null) {

      out.write("\n");
      out.write("    <p class=\"message success-message\">");
      out.print( successMessage );
      out.write("</p>\n");

        session.removeAttribute("successMessage");
    }

    String doctorname = request.getParameter("doctorname");
    if (doctorname == null || doctorname.trim().equals("")) {

      out.write("\n");
      out.write("    <p class=\"warning-message center-content\">Doctor name is required to book slots.</p>\n");

        return;
    }

    String selectedDate = request.getParameter("selectedDate");
    if (selectedDate == null || selectedDate.trim().equals("")) {

      out.write("\n");
      out.write("    <h3 class=\"center-content\">Pick Date</h3>\n");
      out.write("    <form method=\"GET\" action=\"/hospital/slots.jsp\" style=\"text-align:center;\">\n");
      out.write("      <input type=\"hidden\" name=\"doctorname\" value=\"");
      out.print(doctorname);
      out.write("\">\n");
      out.write("      <input type=\"date\" name=\"selectedDate\" required>\n");
      out.write("      <br><br>\n");
      out.write("      <input type=\"submit\" value=\"Show Slots\" class=\"btn\" style=\"background-color: limegreen\">\n");
      out.write("    </form>\n");
      out.write("  </div>\n");
      out.write("</div>\n");
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
      out.write('\n');

        return;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date utilSelDate = sdf.parse(selectedDate);
    Calendar cal = Calendar.getInstance();
    cal.setTime(utilSelDate);
    String week = new SimpleDateFormat("EEEE").format(cal.getTime());
    String displayDate = new SimpleDateFormat("MMMM dd, yyyy").format(cal.getTime());

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    ArrayList morningSlots = new ArrayList();
    ArrayList eveningSlots = new ArrayList();
    HashSet bookedSlots = new HashSet();

    String m_start = "", m_end = "", e_start = "", e_end = "";
    int totalSlots = 6;

    try {
        con = new dbconfig().getConnection();

        pst = con.prepareStatement("SELECT m_start, m_end, e_start, e_end FROM doctor_schedule WHERE doctorname = ? AND week = ?");
        pst.setString(1, doctorname);
        pst.setString(2, week);
        rs = pst.executeQuery();

        if (rs.next()) {
            m_start = rs.getString("m_start");
            m_end = rs.getString("m_end");
            e_start = rs.getString("e_start");
            e_end = rs.getString("e_end");
        }
        rs.close();
        pst.close();

        pst = con.prepareStatement("SELECT a_Time FROM appointmentss WHERE doctorname = ? AND a_Date = ? AND patientname NOT IN ('BLOCKED','absent')");
        pst.setString(1, doctorname);
        pst.setDate(2, new java.sql.Date(utilSelDate.getTime()));
        rs = pst.executeQuery();

        while (rs.next()) {
            bookedSlots.add(rs.getString("a_Time"));
        }
        rs.close();
        pst.close();

        SimpleDateFormat sdf24 = new SimpleDateFormat("HH:mm");
        SimpleDateFormat sdf12 = new SimpleDateFormat("hh:mm a");
        Calendar slotCal = Calendar.getInstance();

        // Morning slots
        if (m_start != null && !m_start.trim().equals("") && !m_start.equalsIgnoreCase("absent")
            && m_end != null && !m_end.trim().equals("") && !m_end.equalsIgnoreCase("absent")) {

            java.util.Date start = sdf24.parse(m_start);
            java.util.Date end = sdf24.parse(m_end);
            long diff = end.getTime() - start.getTime();
            int interval = (int) (diff / totalSlots / (60 * 1000));
            slotCal.setTime(start);

            for (int i = 0; i < totalSlots; i++) {
                String time24 = sdf24.format(slotCal.getTime());
                String time12 = sdf12.format(slotCal.getTime());
                morningSlots.add(time12 + "||" + time24);
                slotCal.add(Calendar.MINUTE, interval);
            }
        }

        // Evening slots
        if (e_start != null && !e_start.trim().equals("") && !e_start.equalsIgnoreCase("absent")
            && e_end != null && !e_end.trim().equals("") && !e_end.equalsIgnoreCase("absent")) {

            java.util.Date start = sdf24.parse(e_start);
            java.util.Date end = sdf24.parse(e_end);
            long diff = end.getTime() - start.getTime();
            int interval = (int) (diff / totalSlots / (60 * 1000));
            slotCal.setTime(start);

            for (int i = 0; i < totalSlots; i++) {
                String time24 = sdf24.format(slotCal.getTime());
                String time12 = sdf12.format(slotCal.getTime());
                eveningSlots.add(time12 + "||" + time24);
                slotCal.add(Calendar.MINUTE, interval);
            }
        }

    } catch (Exception e) {
        out.println("<p class='error-message'>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pst != null) try { pst.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }

      out.write("\n");
      out.write("\n");
      out.write("<h2 class=\"center-content\">Slots for <strong>");
      out.print( doctorname );
      out.write("</strong> on <strong>");
      out.print( week );
      out.write("</strong>, <strong>");
      out.print( displayDate );
      out.write("</strong></h2>\n");
      out.write("\n");
      out.write("<form action=\"/hospital/bookappo\" method=\"POST\" style=\"text-align:center;\">\n");
      out.write("  <input type=\"hidden\" name=\"doctorname\" value=\"");
      out.print( doctorname );
      out.write("\">\n");
      out.write("  <input type=\"hidden\" name=\"selectedDate\" value=\"");
      out.print( selectedDate );
      out.write("\">\n");
      out.write("  <input type=\"hidden\" name=\"week\" value=\"");
      out.print( week );
      out.write("\">\n");
      out.write("\n");
      out.write("  ");
      out.write("\n");
      out.write("  ");
 if (morningSlots.size() > 0) { 
      out.write("\n");
      out.write("  <div class=\"slot-section\">\n");
      out.write("    <label class=\"slot-label\">Morning Slots:</label>\n");
      out.write("    <div class=\"slot-container\">\n");
      out.write("      ");

        for (int i = 0; i < morningSlots.size(); i++) {
            String[] parts = ((String) morningSlots.get(i)).split("\\|\\|");
            String displayTime = parts[0];
            String valueTime = parts[1];
            boolean isBooked = bookedSlots.contains(valueTime);
      
      out.write("\n");
      out.write("      <label class=\"slot-box\">\n");
      out.write("        <input type=\"radio\" name=\"time\" value=\"");
      out.print( valueTime );
      out.write('"');
      out.write(' ');
      out.print( isBooked ? "disabled" : "" );
      out.write(">\n");
      out.write("        <span style=\"");
      out.print( isBooked ? "background-color:#f44336;color:white;" : "background-color:#4CAF50;color:white;" );
      out.write("\">\n");
      out.write("          ");
      out.print( displayTime );
      out.write("\n");
      out.write("        </span>\n");
      out.write("      </label>\n");
      out.write("      ");
 } 
      out.write("\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("  ");
 } else { 
      out.write("\n");
      out.write("    <p class=\"error-message center-content\">No Morning Slots Available</p>\n");
      out.write("  ");
 } 
      out.write("\n");
      out.write("\n");
      out.write("  ");
      out.write("\n");
      out.write("  ");
 if (eveningSlots.size() > 0) { 
      out.write("\n");
      out.write("  <div class=\"slot-section\">\n");
      out.write("    <label class=\"slot-label\">Evening Slots:</label>\n");
      out.write("    <div class=\"slot-container\">\n");
      out.write("      ");

        for (int i = 0; i < eveningSlots.size(); i++) {
            String[] parts = ((String) eveningSlots.get(i)).split("\\|\\|");
            String displayTime = parts[0];
            String valueTime = parts[1];
            boolean isBooked = bookedSlots.contains(valueTime);
      
      out.write("\n");
      out.write("      <label class=\"slot-box\">\n");
      out.write("        <input type=\"radio\" name=\"time\" value=\"");
      out.print( valueTime );
      out.write('"');
      out.write(' ');
      out.print( isBooked ? "disabled" : "" );
      out.write(">\n");
      out.write("        <span style=\"");
      out.print( isBooked ? "background-color:#f44336;color:white;" : "background-color:#4CAF50;color:white;" );
      out.write("\">\n");
      out.write("          ");
      out.print( displayTime );
      out.write("\n");
      out.write("        </span>\n");
      out.write("      </label>\n");
      out.write("      ");
 } 
      out.write("\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("  ");
 } else { 
      out.write("\n");
      out.write("    <p class=\"error-message center-content\">No Evening Slots Available</p>\n");
      out.write("  ");
 } 
      out.write("\n");
      out.write("\n");
      out.write("  ");
      out.write("\n");
      out.write("  <div style=\"margin-top:20px;\">\n");
      out.write("    <label for=\"patientname\"><strong>Patient Name:</strong></label><br>\n");
      out.write("    <input type=\"text\" id=\"patientname\" name=\"patientname\" required style=\"padding: 8px; width: 250px;\">\n");
      out.write("  </div>\n");
      out.write("  <div style=\"margin-top:20px;\">\n");
      out.write("    <label for=\"patientphone\"><strong>Patient Phone Number:</strong></label><br>\n");
      out.write("    <input type=\"text\" id=\"patientphone\" name=\"patientphone\" required style=\"padding: 8px; width: 250px;\">\n");
      out.write("  </div>\n");
      out.write("\n");
      out.write("  <div class=\"center-content\" style=\"margin-top:20px;\">\n");
      out.write("    <button type=\"button\" onclick=\"window.location.href='slots.jsp?doctorname=");
      out.print(doctorname);
      out.write("'\" class=\"btn\" style=\"background-color:#f44336; margin-right: 10px;\">\n");
      out.write("      Back to Select Date\n");
      out.write("    </button>\n");
      out.write("    <input type=\"submit\" value=\"Book Slot\" class=\"btn\">\n");
      out.write("  </div>\n");
      out.write("</form>\n");
      out.write("\n");
      out.write("</div>\n");
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
      out.write('\n');
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
