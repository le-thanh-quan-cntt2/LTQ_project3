<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.XeMay" %>
<%@ page import="model.QuanTri" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Website Bán Xe Máy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .carousel-inner img {
            width: 90%;
            height: 300px;
        }
        .product-card {
            margin-bottom: 30px;
        }
        .product-title {
            font-size: 16px;
            font-weight: bold;
        }
        .product-price {
            color: red;
            font-size: 18px;
            font-weight: bold;
        }
        .navbar-custom {
            background-color: #f00;
        }
        .navbar-custom a {
            color: #fff;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">MUAXEMAY.VN</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Trang Chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Hãng Xe</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Dòng Xe</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Tin Tức</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Liên Hệ</a></li>

                <%-- Kiểm tra người dùng đã đăng nhập chưa --%>
                <%
                    QuanTri user = (QuanTri) session.getAttribute("user");
                    if (user != null) {
                %>
                <li class="nav-item"><a class="nav-link" href="#">Chào mừng, <%= user.getTaiKhoan() %></a></li>
                <li class="nav-item"><a class="nav-link" href="logoutServlet">Đăng Xuất</a></li>
                <% } else { %>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng Nhập</a></li>
                <li class="nav-item"><a class="nav-link" href="signup.jsp">Đăng Ký</a></li>
                <% } %>

                <li class="nav-item"><a class="nav-link" href="viewCart.jsp"><i class="bi bi-cart"></i> Giỏ Hàng</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Carousel (Banner) -->
<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel" data-bs-interval="2000">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="images/images1.jpg" class="d-block w-100" alt="Image 1">
        </div>
        <div class="carousel-item">
            <img src="images/images2.jpg" class="d-block w-100" alt="Image 2">
        </div>
        <div class="carousel-item">
            <img src="images/images3.jpg" class="d-block w-100" alt="Image 3">
        </div>
        <div class="carousel-item">
            <img src="images/images4.jpg" class="d-block w-100" alt="Image 4">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>

<div class="container mt-5">
    <h2 class="text-center mb-4">Danh Sách Xe Máy</h2>
    <div class="row">
        <% 
            List<XeMay> list = (List<XeMay>) request.getAttribute("listXeMay");
            if (list != null && !list.isEmpty()) {
                for (XeMay xeMay : list) { 
        %>
        <div class="col-md-4 mb-4">
            <div class="card">
                <img src="<%= xeMay.getHinhAnh() %>" class="card-img-top" alt="Hình ảnh xe máy">
                <div class="card-body">
                    <h5 class="card-title"><%= xeMay.getTenXe() %></h5>
                    <p class="card-text"><strong>Loại Xe:</strong> <%= xeMay.getLoaiXe() %></p>
                    <p class="card-text"><strong>Giá:</strong> <%= xeMay.getGiaBan() %> VNĐ</p>
                    <div class="action-buttons">
                        <% if (session.getAttribute("user") == null) { %>
                        <a href="login.jsp" class="btn btn-primary btn-sm">Mua Ngay</a>
                        <a href="login.jsp" class="btn btn-info btn-sm">Thêm vào Giỏ Hàng</a>
                        <% } else { %>
                        <a href="XeMayServlet?action=buyNow&id=<%= xeMay.getMaXe() %>" class="btn btn-primary btn-sm">Mua Ngay</a>
                        <a href="XeMayServlet?action=addToCart&id=<%= xeMay.getMaXe() %>" class="btn btn-info btn-sm">Thêm vào Giỏ Hàng</a>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <% 
                }
            } else { 
        %>
        <div class="col-12 text-center">
            <p class="text-muted">Không có xe máy nào trong danh sách.</p>
        </div>
        <% 
            } 
        %>
    </div>
</div>

<!-- Footer -->
<footer class="text-center py-3 mt-5" style="background-color: #333; color: white;">
    <p>&copy; 2025 MUAXEMAY.VN. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
