package com.fashionshoestore.service;

import java.util.List;

import com.fashionshoestore.dao.OrderItemDAO;
import com.fashionshoestore.model.OrderItem;

public class OrderItemService {

    private OrderItemDAO orderItemDAO = new OrderItemDAO();

    public boolean addOrderItem(OrderItem item) {
        return orderItemDAO.addOrderItem(item);
    }

    public List<OrderItem> getOrderItems(int orderId) {
        return orderItemDAO.getOrderItems(orderId);
    }
}