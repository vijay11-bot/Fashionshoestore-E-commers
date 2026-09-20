package com.fashionshoestore.service;

import java.util.List;
import com.fashionshoestore.dao.OrderDAO;
import com.fashionshoestore.model.Order;

public class OrderService {

    private OrderDAO orderDAO = new OrderDAO();

    public int placeOrder(Order order) {
        return orderDAO.placeOrder(order);
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
        return orderDAO.getOrdersByUser(userId);
    }
}