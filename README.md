## Sole Mate – Fashion Shoe Store

Sole Mate is a full-stack Java-based e-commerce web application developed for an online fashion shoe store.

The application provides a complete shopping experience where users can register, log in, browse shoes, search and filter products, view product details, select sizes, manage their cart and wishlist, checkout, place orders, and view their order history.

---
## images
<img width="1884" height="916" alt="image" src="https://github.com/user-attachments/assets/3c5807b1-1078-40c0-8fb1-866fc11511f9" />


## Technologies Used

## Frontend

- HTML5
- CSS3
- JavaScript
- JSP (JavaServer Pages)
- Responsive Web Design

## Backend

- Java
- Jakarta Servlet
- JSP
- JDBC
- MVC Architecture
- Apache Tomcat

## Database

- MySQL
- SQL
- Relational Database Design
- JDBC Database Connectivity

## Build & Development Tools

- Apache Maven
- VS Code
- Eclipse
- Git
- GitHub
- Apache Tomcat

---

# 2. Architecture

The application follows a Servlet MVC architecture with a JDBC-based DAO layer.

``text
                    USER
                     |
                     v
              Web Browser
                     |
                     v
              JSP / Frontend
                     |
                     v
           Servlet Controller
                     |
                     v
              Service Layer
                     |
                     v
                DAO Layer
                     |
                     v
                  JDBC
                     |
                     v
              MySQL Database
