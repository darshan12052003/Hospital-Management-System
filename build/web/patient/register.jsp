<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="Mantis is made using Bootstrap 5 design framework. Download the free admin template & use it for your project.">
  <meta name="keywords" content="Mantis, Dashboard UI Kit, Bootstrap 5, Admin Template, Admin Dashboard, CRM, CMS, Bootstrap Admin Template">
  <meta name="author" content="CodedThemes">
  <title>Register | Mantis Bootstrap 5 Admin Template</title>

  <!-- Favicon -->
  <link rel="icon" href="../assets/images/favicon.svg" type="image/x-icon">

  <!-- Google Fonts -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Public+Sans:wght@300;400;500;600;700&display=swap" id="main-font-link">

  <!-- Icons -->
  <link rel="stylesheet" href="../assets/fonts/tabler-icons.min.css">
  <link rel="stylesheet" href="../assets/fonts/feather.css">
  <link rel="stylesheet" href="../assets/fonts/fontawesome.css">
  <link rel="stylesheet" href="../assets/fonts/material.css">

  <!-- Styles -->
  <link rel="stylesheet" href="../assets/css/style.css" id="main-style-link">
  <link rel="stylesheet" href="../assets/css/style-preset.css">
</head>

<body>
  <!-- Pre-loader -->
  <div class="loader-bg">
    <div class="loader-track">
      <div class="loader-fill"></div>
    </div>
  </div>

  <!-- Main Content -->
  <div class="auth-main">
    <div class="auth-wrapper v3">
      <div class="auth-form">
        <div class="auth-header text-center mb-4">
          <a href="#"><img src="../assets/images/logo-dark.svg" alt="Logo"></a>
        </div>

        <div class="card my-5">
          <div class="card-body">
            <form method="post" action="/hospital/pregister">
              <div class="mb-4 d-flex justify-content-between align-items-end">
                <h3 class="mb-0"><b>New Patient Register</b></h3>
              </div>

              <!-- Name -->
              <div class="form-group mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control" placeholder="Name" required>
              </div>

              <!-- Email -->
              <div class="form-group mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" placeholder="Email">
              </div>

              <!-- Password -->
              <div class="form-group mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter password" required>
              </div>

              <!-- Gender -->
              <div class="form-group mb-3">
                <label class="form-label">Gender</label>
                <select class="form-control" name="gender" required>
                  <option value="">-- Select --</option>
                  <option value="Male">Male</option>
                  <option value="Female">Female</option>
                  <option value="Other">Other</option>
                </select>
              </div>

              <!-- Age -->
              <div class="form-group mb-3">
                <label class="form-label">Age</label>
                <input type="number" class="form-control" name="age" placeholder="Age">
              </div>

              <!-- Phone -->
              <div class="form-group mb-3">
                <label class="form-label">Phone</label>
                <input type="text" class="form-control" name="phone" placeholder="Phone number">
              </div>

              <!-- Address -->
              <div class="form-group mb-3">
                <label class="form-label">Address</label>
                <textarea class="form-control" name="address" rows="3" placeholder="Patient Address"></textarea>
              </div>

              <!-- Submit -->
              <div class="d-grid mt-4">
                <button type="submit" class="btn btn-primary">Register</button>
              </div>
            </form>
          </div>
        </div>
       

        <!-- Footer -->
        <div class="auth-footer row">
          <div class="col my-1">
            <p class="m-0">© <a href="#">CodedThemes</a></p>
          </div>
          <div class="col-auto my-1">
            <ul class="list-inline footer-link mb-0">
              <li class="list-inline-item"><a href="#">Home</a></li>
              <li class="list-inline-item"><a href="#">Privacy Policy</a></li>
              <li class="list-inline-item"><a href="#">Contact Us</a></li>
            </ul>
          </div>
        </div>

      </div> <!-- /.auth-form -->
    </div> <!-- /.auth-wrapper -->
  </div> <!-- /.auth-main -->

  <!-- Required JS -->
  <script src="../assets/js/plugins/popper.min.js"></script>
  <script src="../assets/js/plugins/simplebar.min.js"></script>
  <script src="../assets/js/plugins/bootstrap.min.js"></script>
  <script src="../assets/js/fonts/custom-font.js"></script>
  <script src="../assets/js/pcoded.js"></script>
  <script src="../assets/js/plugins/feather.min.js"></script>

  <!-- Custom Config -->
  <script>layout_change('light');</script>
  <script>change_box_container('false');</script>
  <script>layout_rtl_change('false');</script>
  <script>preset_change("preset-1");</script>
  <script>font_change("Public-Sans");</script>

</body>
</html>
