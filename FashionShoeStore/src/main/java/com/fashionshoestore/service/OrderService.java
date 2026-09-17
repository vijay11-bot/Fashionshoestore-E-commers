package com.fashionshoestore.service;

import java.util.List;

import com.fashionshoestore.dao.OrderDAO;
import com.fashionshoestore.model.Order;

public class OrderService {

    private OrderDAO orderDAO = new OrderDAO();

    public int placeOrder(Order order) {
        return orderDAO.placeOrder(order);
    }

    public List<Order> getOrdersByUser(int userId) {
        return orderDAO.getOrdersByUser(userId);
    }

    public Order getOrderByIdAndUser(int orderId, int userId) {
        return orderDAO.getOrderByIdAndUser(orderId, userId);
    }
}