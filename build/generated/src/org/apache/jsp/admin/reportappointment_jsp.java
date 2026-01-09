package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import Database.dbconfig;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;

public final class reportappointment_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("          <label>Report</label>\n");
      out.write("          <i class=\"ti ti-brand-chrome\"></i>\n");
      out.write("        </li>\n");
      out.write("       \n");
      out.write("          <ul class=\"pc-submenu\">\n");
      out.write("            <li class=\"pc-item\"><a class=\"pc-link\" href=\"patientsss.jsp\">Total Patients</a></li>\n");
      out.write("            <li class=\"pc-item pc-hasmenu\">\n");
      out.write("              <a href=\"reportappointment.jsp\" class=\"pc-link\"> Appointments<span class=\"pc-arrow\"><i data-feather=\"chevron-right\"></i></span></a>\n");
      out.write("              <ul class=\"pc-submenu\">\n");
      out.write("                <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\"></a></li>\n");
      out.write("                <li class=\"pc-item\"><a class=\"pc-link\" href=\"#!\"></a></li>\n");
      out.write("                <li class=\"pc-item pc-hasmenu\">\n");
      out.write("                  <a href=\"#!\" class=\"pc-link\"><span class=\"pc-arrow\"><i data-feather=\"chevron-right\"></i></span></a>\n");
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
      out.write("    <h3>Appointments</h3>\n");
      out.write("    <hr>\n");
      out.write("\n");
      out.write("    <!-- Filter Form -->\n");
      out.write("    <form method=\"get\" class=\"d-flex align-items-center gap-3 mb-4\">\n");
      out.write("\n");
      out.write("      <!-- View Type -->\n");
      out.write("      <label for=\"viewType\">View:</label>\n");
      out.write("      <select name=\"viewType\" id=\"viewType\" class=\"form-select\">\n");
      out.write("        <option value=\"daily\" ");
      out.print( "daily".equals(request.getParameter("viewType")) ? "selected" : "" );
      out.write(">Daily</option>\n");
      out.write("        <option value=\"weekly\" ");
      out.print( "weekly".equals(request.getParameter("viewType")) ? "selected" : "" );
      out.write(">Weekly</option>\n");
      out.write("        <option value=\"monthly\" ");
      out.print( "monthly".equals(request.getParameter("viewType")) ? "selected" : "" );
      out.write(">Monthly</option>\n");
      out.write("      </select>\n");
      out.write("\n");
      out.write("      <!-- Doctor Filter -->\n");
      out.write("      <label for=\"doctor\">Doctor:</label>\n");
      out.write("      <select name=\"doctor\" id=\"doctor\" class=\"form-select\">\n");
      out.write("        <option value=\"\">All Doctors</option>\n");
      out.write("\n");
      out.write("        ");

            // Load unique doctor names
            try {
                Connection con2 = new dbconfig().getConnection();
                Statement st2 = con2.createStatement();
                ResultSet rs2 = st2.executeQuery("SELECT DISTINCT doctorname FROM appointmentss ORDER BY doctorname ASC");

                String selectedDoctor = request.getParameter("doctor");

                while(rs2.next()) {
                    String dn = rs2.getString("doctorname");
        
      out.write("\n");
      out.write("            <option value=\"");
      out.print( dn );
      out.write('"');
      out.write(' ');
      out.print( dn.equals(selectedDoctor) ? "selected" : "" );
      out.write('>');
      out.print( dn );
      out.write("</option>\n");
      out.write("        ");

                }
                rs2.close();
                st2.close();
                con2.close();
            } catch(Exception e) {}
        
      out.write("\n");
      out.write("      </select>\n");
      out.write("\n");
      out.write("      <!-- Date Range -->\n");
      out.write("      <label for=\"fromDate\">From:</label>\n");
      out.write("      <input type=\"date\" name=\"fromDate\" id=\"fromDate\" class=\"form-control\"\n");
      out.write("             value=\"");
      out.print( request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" );
      out.write("\">\n");
      out.write("\n");
      out.write("      <label for=\"toDate\">To:</label>\n");
      out.write("      <input type=\"date\" name=\"toDate\" id=\"toDate\" class=\"form-control\"\n");
      out.write("             value=\"");
      out.print( request.getParameter("toDate") != null ? request.getParameter("toDate") : "" );
      out.write("\">\n");
      out.write("\n");
      out.write("      <button type=\"submit\" class=\"btn btn-primary\">View</button>\n");
      out.write("    </form>\n");
      out.write("\n");
      out.write("\n");
      out.write("    <!-- Appointments Table -->\n");
      out.write("    <div class=\"table-responsive\">\n");
      out.write("      ");

        String viewType = request.getParameter("viewType");
        if(viewType == null) viewType = "daily";

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

            // Date Range selected
            if(fromDate != null && !fromDate.isEmpty() &&
               toDate != null && !toDate.isEmpty()) {

                query += " AND a_Date BETWEEN '" + fromDate + "' AND '" + toDate + "' ";
            }
            else {
                // DAILY filter
                if(viewType.equals("daily")) {
                    query += " AND a_Date = '" + sdf.format(today) + "' ";
                }

                // WEEKLY filter
                else if(viewType.equals("weekly")) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(today);
                    cal.add(Calendar.DAY_OF_MONTH, -6);
                    String startDate = sdf.format(cal.getTime());
                    String endDate = sdf.format(today);

                    query += " AND a_Date BETWEEN '" + startDate + "' AND '" + endDate + "' ";
                }

                // MONTHLY filter
                else if(viewType.equals("monthly")) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(today);
                    cal.set(Calendar.DAY_OF_MONTH, 1);
                    String firstDay = sdf.format(cal.getTime());
                    cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                    String lastDay = sdf.format(cal.getTime());

                    query += " AND a_Date BETWEEN '" + firstDay + "' AND '" + lastDay + "' ";
                }
            }

            // Doctor filter
            if(doctor != null && !doctor.isEmpty()) {
                query += " AND doctorname = '" + doctor + "' ";
            }

            // Sorting
            query += " ORDER BY doctorname ASC, 
                               STR_TO_DATE(a_Date, '%Y-%m-%d') ASC,
                               STR_TO_DATE(a_Time, '%h:%i %p') ASC";

            res = stat.executeQuery(query);

            String lastDoctor = "";
            boolean firstDoctor = true;

            while(res.next()) {
                int id = res.getInt("id");
                String patientname = res.getString("patientname");
                String doctorname = res.getString("doctorname");
                String a_Date = res.getString("a_Date");
                String a_Time = res.getString("a_Time");

                // Group by doctor
                if(!doctorname.equals(lastDoctor)) {
                    if(!firstDoctor) {
      
      out.write("\n");
      out.write("                      </tbody>\n");
      out.write("                    </table>\n");
      out.write("      ");

                    }
      
      out.write("\n");
      out.write("                    <h4 class=\"mt-4 mb-3 text-primary\"><b>Doctor: ");
      out.print( doctorname );
      out.write("</b></h4>\n");
      out.write("                    <table class=\"table table-hover table-bordered mb-3\">\n");
      out.write("                      <thead class=\"table-light\">\n");
      out.write("                        <tr>\n");
      out.write("                          <th>ID</th>\n");
      out.write("                          <th>Patient</th>\n");
      out.write("                          <th>Date</th>\n");
      out.write("                          <th>Time</th>\n");
      out.write("                          <th>Action</th>\n");
      out.write("                        </tr>\n");
      out.write("                      </thead>\n");
      out.write("                      <tbody>\n");
      out.write("      ");

                    lastDoctor = doctorname;
                    firstDoctor = false;
                }
      
      out.write("\n");
      out.write("                <tr>\n");
      out.write("                  <td>");
      out.print( id );
      out.write("</td>\n");
      out.write("                  <td>");
      out.print( patientname );
      out.write("</td>\n");
      out.write("                  <td>");
      out.print( a_Date );
      out.write("</td>\n");
      out.write("                  <td>");
      out.print( a_Time );
      out.write("</td>\n");
      out.write("                  <td>\n");
      out.write("                    <a href=\"");
      out.print( request.getContextPath() );
      out.write("/deletapp?id=");
      out.print( id );
      out.write("\"\n");
      out.write("                       onclick=\"return confirm('Are you sure you want to delete this Appointment?');\">\n");
      out.write("                      <i class=\"fas fa-trash-alt\" style=\"color:red;\"></i>\n");
      out.write("                    </a>\n");
      out.write("                  </td>\n");
      out.write("                </tr>\n");
      out.write("      ");

            }

            if(!firstDoctor) {
      
      out.write("\n");
      out.write("                </tbody>\n");
      out.write("              </table>\n");
      out.write("      ");

            } else {
      
      out.write("\n");
      out.write("              <div class=\"alert alert-info\">No appointments found.</div>\n");
      out.write("      ");

            }

            res.close();
            stat.close();
            con.close();

        } catch(Exception e) {
      
      out.write("\n");
      out.write("          <div class=\"alert alert-danger\">Error: ");
      out.print( e.getMessage() );
      out.write("</div>\n");
      out.write("      ");

        }
      
      out.write("\n");
      out.write("    </div>\n");
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
