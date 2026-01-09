package org.apache.jsp.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.*;
import Database.dbconfig;

public final class daily_005fappointments_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

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

    String doctor = request.getParameter("doctorname");
    if (doctor == null) doctor = "";

    List<String> dailyList = new ArrayList<String>();

    try {
        Connection con = new dbconfig().getConnection();

        // WORKING QUERY
        PreparedStatement ps = con.prepareStatement(
            "SELECT id, patientname, doctorname, a_Date, a_Time " +
            "FROM appointmentss " +
            "WHERE a_Date = CURDATE() AND doctorname = ?"
        );

        ps.setString(1, doctor);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String id = rs.getString("id");
            String patient = rs.getString("patientname");
            String date = rs.getString("a_Date");
            String time = rs.getString("a_Time");

            dailyList.add("ID: " + id + ", Patient: " + patient +
                          ", Date: " + date + ", Time: " + time);
        }

        rs.close();
        ps.close();
        con.close();
    }
    catch(Exception e){
        out.println(e);
    }

      out.write("\n");
      out.write("\n");
      out.write("<h2>Daily Appointments for ");
      out.print( doctorname );
      out.write("</h2>\n");
      out.write("<hr>\n");
      out.write("\n");

    if (dailyList.size() == 0) {

      out.write("\n");
      out.write("        <p>No Appointments Today.</p>\n");

    } else {

      out.write("\n");
      out.write("        <ul>\n");
      out.write("        ");
 for (String item : dailyList) { 
      out.write("\n");
      out.write("            <li>");
      out.print( item );
      out.write("</li>\n");
      out.write("        ");
 } 
      out.write("\n");
      out.write("        </ul>\n");

    }

      out.write("\n");
      out.write("\n");
      out.write("<a href=\"appointments_reports.jsp\">Back</a>\n");
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
