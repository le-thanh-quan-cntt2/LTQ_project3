package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dao.QuanTriDAO;
import model.QuanTri;

@WebServlet("/registerServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Kiểm tra xem tài khoản đã tồn tại chưa
        QuanTriDAO quanTriDAO = new QuanTriDAO();
        if (quanTriDAO.getUserByUsername(username) != null) {
            // Nếu tài khoản đã tồn tại
            response.sendRedirect("signup.jsp?error=Account already exists");
            return;
        }

        // Tạo đối tượng QuanTri mới
        QuanTri newUser = new QuanTri(0, username, password, true);

        // Lưu người dùng mới vào cơ sở dữ liệu
        quanTriDAO.addUser(newUser);

        // Chuyển hướng đến trang đăng nhập sau khi đăng ký thành công
        response.sendRedirect("login.jsp");
    }
}
