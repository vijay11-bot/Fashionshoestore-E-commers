package com.fashionshoestore.service;

import java.util.List;
import com.fashionshoestore.dao.OrderDAO;
import com.fashionshoestore.model.CartItem;
import com.fashionshoestore.model.Order;
import com.fashionshoestore.model.OrderItem;

public class OrderService {

    private OrderDAO orderDAO = new OrderDAO();

    public int createOrder(Order order, List<CartItem> items, int cartId) {
        return orderDAO.createOrder(order, items, cartId);
    }

    public Order getOrderById(int orderId) {
        return orderDAO.getOrderById(orderId);
    }

    public Order getOrderByIdAndUser(int orderId, int userId) {
        Order order = orderDAO.getOrderById(orderId);
        if (order != null && order.getUserId() == userId) {
            return order;
        }
        return null;
    }

    public List<Order> getOrdersByUser(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    public List<OrderItem> getOrderItems(int orderId) {
        return orderDAO.getOrderItems(orderId);
    }
}