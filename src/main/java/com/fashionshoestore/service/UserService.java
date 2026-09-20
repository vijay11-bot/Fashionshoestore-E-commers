package com.fashionshoestore.service;

import com.fashionshoestore.dao.UserDAO;
import com.fashionshoestore.model.User;

public class UserService {

    private UserDAO userDAO = new UserDAO();

    public boolean registerUser(User user) {
        return userDAO.registerUser(user);
    }

    public User loginUser(String email, String password) {
        return userDAO.loginUser(email, password);
    }

    public boolean emailExists(String email) {
        return userDAO.emailExists(email);
    }

    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }
}
