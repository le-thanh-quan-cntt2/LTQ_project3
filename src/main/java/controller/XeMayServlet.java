package controller;

import java.io.IOException;
import java.util.List;

import dao.XeMayDA;
import dao.DonHangDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.XeMay;
import model.Cart;

@WebServlet("/XeMayServlet")
public class XeMayServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private XeMayDA xeMayDAO;

    public void init() {
        xeMayDAO = new XeMayDA();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "buyNow":
                buyNow(request, response);
                break;
            case "addToCart":
                addToCart(request, response);
                break;
            case "viewCart":
                viewCart(request, response);
                break;
            case "checkout":
                checkout(request, response);
                break;
            case "removeItem":
                removeItem(request, response);
                break;
            default:
                listXeMay(request, response);
                break;
        }
    }

    private void listXeMay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<XeMay> listXeMay = xeMayDAO.selectAll();
        request.setAttribute("listXeMay", listXeMay);
        RequestDispatcher dispatcher = request.getRequestDispatcher("listXeMay.jsp");
        dispatcher.forward(request, response);
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        XeMay xeMay = xeMayDAO.selectById(id);
        int quantity = 1; // Default quantity

        // Add the item to the session cart
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            request.getSession().setAttribute("cart", cart);
        }
        cart.addItem(xeMay, quantity);

        response.sendRedirect("XeMayServlet?action=viewCart");
    }

    private void buyNow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        XeMay xeMay = xeMayDAO.selectById(id);

        // Add to cart temporarily for immediate purchase
        Cart cart = new Cart();
        cart.addItem(xeMay, 1);
        request.getSession().setAttribute("cart", cart);

        // Redirect to checkout page to fill out personal information
        response.sendRedirect("checkout.jsp");
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        request.setAttribute("cart", cart);
        RequestDispatcher dispatcher = request.getRequestDispatcher("viewCart.jsp");
        dispatcher.forward(request, response);
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Kiểm tra xem giỏ hàng có tồn tại và có sản phẩm hay không
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            // Nếu giỏ hàng trống, chuyển về trang giỏ hàng
            response.sendRedirect("XeMayServlet?action=viewCart");
            return;
        }

        // Tiến hành thanh toán và xử lý đơn hàng nếu giỏ hàng không trống
        // Thực hiện các bước thanh toán tiếp theo...
        response.sendRedirect("checkout.jsp"); // Chuyển tới trang thanh toán
    }
 

    private void removeItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if (cart != null) {
            cart.removeItem(id);
        }
        response.sendRedirect("XeMayServlet?action=viewCart");
    }
}
