## Sole Mate – Fashion Shoe Store

Sole Mate is a full-stack Java-based e-commerce web application developed for an online fashion shoe store.

The application provides a complete shopping experience where users can register, log in, browse shoes, search and filter products, view product details, select sizes, manage their cart and wishlist, checkout, place orders, and view their order history.

---
## images
<img width="1884" height="916" alt="image" src="https://github.com/user-attachments/assets/3c5807b1-1078-40c0-8fb1-866fc11511f9" />
<img width="558" height="584" alt="image" src="https://github.com/user-attachments/assets/964ab33d-b1cb-4493-b49b-63fb1866f157" />
<img width="553" height="693" alt="image" src="https://github.com/user-attachments/assets/ecf61620-dff2-4288-bdeb-37b48ab17af5" />
<img width="1546" height="841" alt="image" src="https://github.com/user-attachments/assets/8fa482c7-802c-4b98-a9c5-bf1c8b723022" />
<img width="957" height="324" alt="image" src="https://github.com/user-attachments/assets/9b29ba84-5c2c-4ef9-8fae-c32403acf4ce" />
<img width="835" height="705" alt="image" src="https://github.com/user-attachments/assets/81355ca9-a5df-4819-be3e-a2ba68a5192f" />




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
