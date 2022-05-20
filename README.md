# Pizza Order Management System


## Video Demonstration

https://user-images.githubusercontent.com/41316490/166720063-19bc863b-ee86-4403-9ace-519b8f8e20ff.mp4

## Technology:

### Frontend:
1. HTML & CSS
2. JavaScript
3. AJAX
4. Thymeleaf

### Backend:
1. Spring Boot
2. JDBC
3. Maven

### Database:
1. PostgreSQL

## Task Description:

### Programming:
The program consists of <br/>
1. PostgreSQL-database with the program logic implemented in PL/pgSQL and <br/>
2. Frontend for interaction with the data from the database.

### Database:
1. The database is provided by PostgreSQL. <br/>
2. Most of the program logic is implemented directly in the database using PL/pgSQL as
main programming language. <br/>
3. All the pizza data (and related information) is stored in the database. <br/>

### Frontend:
1. There are two different mutual exclusive views: pizza baker and customer <br/>
a) it can be switched easily between both and there is no need for complex user management <br/>
2. The pizza baker view includes options to: <br/>
a) list of all pizzas that were recently ordered <br/>
b) manage ingredients (add, change, hide/show, remove and restock) <br/>
&nbsp;&nbsp;• restocking performs by ordering from different available suppliers (hidden suppliers are not available) <br/>
&nbsp;&nbsp;• it takes place immediately (suppliers have no delivery time) <br/>
&nbsp;&nbsp;• base pizzas in all their different sizes are available in an infinite number, so there is no need to restock <br/>
c) manage suppliers (add, change, hide/show and remove) <br/>
3. The customer view includes the options to: <br/>
a) list all available ingredients along with their name, regional provenance and price <br/>
&nbsp;&nbsp;• ingredients that are hidden or run out of stock must not be shown <br/>
b) create a pizza composition by selecting a base pizza in a certain size and all available ingredients <br/>
c) order a pizza in accordance with the previously created composition <br/>
4. For demonstration purposes there are available at least: <br/>
a) 2 different recently ordered pizzas <br/>
b) 3 different base pizza sizes <br/>
c) 5 different suppliers with only partly overlapping assortment <br/>
d) 10 different ingredients with various regional provenances and prices, whereof at least <br/>
&nbsp;&nbsp;i. 3 have only 1 regional provenance and price <br/>
&nbsp;&nbsp;ii. 5 have at least 3 different regional provenances and prices <br/>




