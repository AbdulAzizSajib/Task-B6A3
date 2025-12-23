-- Q1
SELECT
  bookings.booking_id,
  users.name AS customer_name,
  vehicles.name AS vehicle_name,
  bookings.start_date,
  bookings.end_date,
  bookings.status
FROM
  bookings
  INNER JOIN users ON bookings.user_id = users.user_id
  INNER JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id;


-- Q2

SELECT *
FROM vehicles as v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings as b
    WHERE b.vehicle_id = v.vehicle_id
);

-- Q3

SELECT *
FROM vehicles
WHERE type = 'car'
  AND status = 'available';

--Q4

SELECT vehicles.name AS vehicle_name, COUNT(bookings.booking_id) AS total_bookings
FROM bookings
INNER JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id
GROUP BY vehicles.vehicle_id, vehicles.name
HAVING COUNT(bookings.booking_id) > 2;


