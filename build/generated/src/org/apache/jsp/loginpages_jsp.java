package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class loginpages_jsp extends org.apache.jasper.runtime.HttpJspBase
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

      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("  <meta charset=\"UTF-8\" />\n");
      out.write("  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n");
      out.write("  <title>Hospital Management Login</title>\n");
      out.write("  <link href=\"https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap\" rel=\"stylesheet\">\n");
      out.write("  <style>\n");
      out.write("    body {\n");
      out.write("      margin: 0;\n");
      out.write("      font-family: 'Inter', sans-serif;\n");
      out.write("      background: linear-gradient(135deg, #000000, #1a1a1a);\n");
      out.write("      color: #ffffff;\n");
      out.write("      display: flex;\n");
      out.write("      flex-direction: column;\n");
      out.write("      min-height: 100vh;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    header {\n");
      out.write("      display: flex;\n");
      out.write("      justify-content: space-between;\n");
      out.write("      align-items: center;\n");
      out.write("      padding: 20px 50px;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .logo {\n");
      out.write("      font-size: 24px;\n");
      out.write("      font-weight: 700;\n");
      out.write("      color: #00b0ff;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    nav a {\n");
      out.write("      color: #ccc;\n");
      out.write("      margin-left: 20px;\n");
      out.write("      text-decoration: none;\n");
      out.write("      font-weight: 500;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .btn-primary {\n");
      out.write("      background-color: #2196f3;\n");
      out.write("      color: #fff;\n");
      out.write("      padding: 10px 20px;\n");
      out.write("      border: none;\n");
      out.write("      border-radius: 8px;\n");
      out.write("      font-weight: 600;\n");
      out.write("      cursor: pointer;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .center-content {\n");
      out.write("      flex: 1;\n");
      out.write("      display: flex;\n");
      out.write("      justify-content: center;\n");
      out.write("      align-items: center;\n");
      out.write("      text-align: center;\n");
      out.write("      flex-direction: column;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .login-buttons {\n");
      out.write("      display: flex;\n");
      out.write("      gap: 20px;\n");
      out.write("      margin-top: 30px;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .login-buttons .btn {\n");
      out.write("      background-color: #0d47a1;\n");
      out.write("      border: none;\n");
      out.write("      padding: 15px 30px;\n");
      out.write("      font-size: 16px;\n");
      out.write("      border-radius: 6px;\n");
      out.write("      cursor: pointer;\n");
      out.write("      color: #fff;\n");
      out.write("      transition: 0.3s;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    .login-buttons .btn:hover {\n");
      out.write("      background-color: #1565c0;\n");
      out.write("    }\n");
      out.write("\n");
      out.write("    @media (max-width: 600px) {\n");
      out.write("      .login-buttons {\n");
      out.write("        flex-direction: column;\n");
      out.write("        gap: 15px;\n");
      out.write("      }\n");
      out.write("    }\n");
      out.write("  </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("  <header>\n");
      out.write("    <div class=\"logo\">? Hospital Management</div>\n");
      out.write("    <nav>\n");
      out.write("      <a href=\"#\">Dashboard</a>\n");
      out.write("      <button class=\"btn-primary\">Purchase Now</button>\n");
      out.write("    </nav>\n");
      out.write("  </header>\n");
      out.write("\n");
      out.write("  <div class=\"center-content\">\n");
      out.write("    <h2>Login As</h2>\n");
      out.write("    <div class=\"login-buttons\">\n");
      out.write("      <button class=\"btn\" onclick=\"location.href='/hospital/admin/login.jsp'\">Admin Login</button>\n");
      out.write("      <button class=\"btn\" onclick=\"location.href='/hospital/doctor/dlogin.jsp'\">Doctor Login</button>\n");
      out.write("      <button class=\"btn\" onclick=\"location.href='patient-login.html'\">Patient Login</button>\n");
      out.write("    </div>\n");
      out.write("  </div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>\n");
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
