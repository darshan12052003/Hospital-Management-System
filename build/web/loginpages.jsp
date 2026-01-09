<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Hospital Management Login</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #000000, #1a1a1a);
      color: #ffffff;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px 50px;
    }

    .logo {
      font-size: 24px;
      font-weight: 700;
      color: #00b0ff;
    }

    nav a {
      color: #ccc;
      margin-left: 20px;
      text-decoration: none;
      font-weight: 500;
    }

    .btn-primary {
      background-color: #2196f3;
      color: #fff;
      padding: 10px 20px;
      border: none;
      border-radius: 8px;
      font-weight: 600;
      cursor: pointer;
    }

    .center-content {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      text-align: center;
      flex-direction: column;
    }

    .login-buttons {
      display: flex;
      gap: 20px;
      margin-top: 30px;
    }

    .login-buttons .btn {
      background-color: #0d47a1;
      border: none;
      padding: 15px 30px;
      font-size: 16px;
      border-radius: 6px;
      cursor: pointer;
      color: #fff;
      transition: 0.3s;
    }

    .login-buttons .btn:hover {
      background-color: #1565c0;
    }

    @media (max-width: 600px) {
      .login-buttons {
        flex-direction: column;
        gap: 15px;
      }
    }
  </style>
</head>
<body>

  <header>
    <div class="logo">? Hospital Management</div>
    <nav>
      <a href="#">Dashboard</a>
      <button class="btn-primary">Purchase Now</button>
    </nav>
  </header>

  <div class="center-content">
    <h2>Login As</h2>
    <div class="login-buttons">
      <button class="btn" onclick="location.href='/hospital/admin/login.jsp'">Admin Login</button>
      <button class="btn" onclick="location.href='/hospital/doctor/dlogin.jsp'">Doctor Login</button>
      <button class="btn" onclick="location.href='patient-login.html'">Patient Login</button>
    </div>
  </div>

</body>
</html>
