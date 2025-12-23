
SELECT users.name AS customer_name,
    vehicles.name AS vehicle_name
FROM bookings
INNER JOIN users 
    ON bookings.user_id = users.user_id
INNER JOIN vehicles 
    ON bookings.vehicle_id = vehicles.vehicle_id;





    SELECT *
FROM vehicles as v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings as b
    WHERE b.vehicle_id = v.vehicle_id
);



SELECT *
FROM vehicles
WHERE type = 'car'
  AND status = 'available';



SELECT 
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM vehicles v
INNER JOIN bookings b
    ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING COUNT(b.booking_id) > 2;



