# Vehicle Rental Database System

## Overview

This is a SQL database project for managing a vehicle rental system. It includes tables for users, vehicles, and bookings, along with sample data and SQL queries demonstrating various database concepts.

## Database Schema

### Tables

#### 1. Users Table

Stores customer and admin information.

```sql
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    role user_role NOT NULL
);
```

#### 2. Vehicles Table

Stores information about available vehicles for rent.

```sql
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type vehicle_type NOT NULL,
    model VARCHAR(20),
    registration_number VARCHAR(50) UNIQUE NOT NULL,
    rental_price DECIMAL(10,2) NOT NULL,
    status vehicle_status NOT NULL
);
```

#### 3. Bookings Table

Stores rental booking information with foreign key relationships.

```sql
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    vehicle_id INT NOT NULL REFERENCES vehicles(vehicle_id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status booking_status NOT NULL,
    total_cost DECIMAL(10,2) NOT NULL
);
```

## Sample Data

### Insert Users

```sql
INSERT INTO users (user_id, name, email, phone, role) VALUES
(1, 'Alice', 'alice@example.com', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', '1122334455', 'Customer');
```

### Insert Vehicles

```sql
INSERT INTO vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) VALUES
(1, 'Toyota Corolla', 'car', '2022', 'ABC-123', 50, 'available'),
(2, 'Honda Civic', 'car', '2021', 'DEF-456', 60, 'rented'),
(3, 'Yamaha R15', 'bike', '2023', 'GHI-789', 30, 'available'),
(4, 'Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');
```

### Insert Bookings

```sql
INSERT INTO bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', 100);
```

## SQL Queries

### Query 1: JOIN

**Objective:** Retrieve booking information along with customer name and vehicle name.

**Concepts:** INNER JOIN

### Query 2: EXISTS

**Objective:** Find all vehicles that have never been booked.

**Concepts:** NOT EXISTS

### Query 3: WHERE

**Objective:** Retrieve all available vehicles of a specific type (e.g., cars).

**Concepts:** SELECT, WHERE

### Query 4: GROUP BY and HAVING

**Objective:** Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

**Concepts:** GROUP BY, HAVING, COUNT

## Key Concepts Demonstrated

1. **Database Design**

   - Primary Keys (SERIAL)
   - Foreign Key Constraints
   - Data Types (VARCHAR, DECIMAL, DATE, ENUM types)

2. **SQL Operations**

   - INNER JOIN - Combining data from multiple tables
   - NOT EXISTS - Subquery for finding non-matching records
   - WHERE - Filtering data based on conditions
   - GROUP BY - Aggregating data
   - HAVING - Filtering aggregated results

3. **Relationships**
   - One-to-Many: Users → Bookings
   - One-to-Many: Vehicles → Bookings

## Setup Instructions

1. Ensure PostgreSQL is installed on your system
2. Create a new database
3. Run the CREATE TABLE statements to set up the schema
4. Insert the sample data using the INSERT statements
5. Execute the queries to test functionality

## Notes

- The database uses custom ENUM types: `user_role`, `vehicle_type`, `vehicle_status`, and `booking_status`
- These ENUM types need to be created before creating the tables
- All prices are stored as DECIMAL(10,2) for precise monetary calculations
