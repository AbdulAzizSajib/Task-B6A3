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

### Users
- Alice (Customer)
- Bob (Admin)
- Charlie (Customer)

### Vehicles
- Toyota Corolla (Car) - Available
- Honda Civic (Car) - Rented
- Yamaha R15 (Bike) - Available
- Ford F-150 (Truck) - Under Maintenance

### Bookings
- 4 sample bookings with various statuses (completed, confirmed, pending)

## SQL Queries

### Query 1: JOIN
**Objective:** Retrieve booking information along with customer name and vehicle name.

**Concepts:** INNER JOIN

```sql
SELECT 
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status,
    b.total_cost
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```

### Query 2: EXISTS
**Objective:** Find all vehicles that have never been booked.

**Concepts:** NOT EXISTS

```sql
SELECT 
    vehicle_id,
    name,
    type,
    registration_number,
    rental_price,
    status
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1 
    FROM bookings b 
    WHERE b.vehicle_id = v.vehicle_id
);
```

### Query 3: WHERE
**Objective:** Retrieve all available vehicles of a specific type (e.g., cars).

**Concepts:** SELECT, WHERE

```sql
SELECT 
    vehicle_id,
    name,
    model,
    registration_number,
    rental_price
FROM vehicles
WHERE type = 'car' 
    AND status = 'available';
```

### Query 4: GROUP BY and HAVING
**Objective:** Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

**Concepts:** GROUP BY, HAVING, COUNT

```sql
SELECT 
    v.vehicle_id,
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicles v
INNER JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING COUNT(b.booking_id) > 2;
```

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
