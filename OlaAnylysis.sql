CREATE TABLE Rides (
    Date timestamp,
    Time TIME,
    Booking_ID VARCHAR(20),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(20),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INT,
    C_TAT INT,
    Canceled_Rides_by_Customer VARCHAR(255),
    Canceled_Rides_by_Driver VARCHAR(255),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value INT,
    Payment_Method VARCHAR(50),
    Ride_Distance FLOAT,
    Driver_Ratings FLOAT,
    Customer_Rating FLOAT
);


SELECT * FROM Rides;

-- Checking The Duplicates Data
SELECT 
    date, time, booking_id, booking_status, customer_id,
    vehicle_type, pickup_location, drop_location, v_tat, c_tat,
    canceled_rides_by_customer, canceled_rides_by_driver,
    incomplete_rides, incomplete_rides_reason, booking_value,
    payment_method, ride_distance, driver_ratings, customer_rating,
    COUNT(*) AS duplicate_count
FROM rides
GROUP BY 
    date, time, booking_id, booking_status, customer_id,
    vehicle_type, pickup_location, drop_location, v_tat, c_tat,
    canceled_rides_by_customer, canceled_rides_by_driver,
    incomplete_rides, incomplete_rides_reason, booking_value,
    payment_method, ride_distance, driver_ratings, customer_rating
HAVING COUNT(*) > 1;


-- 1. Retrieve all successful bookings:
-- 2. Find the average ride distance for each vehicle type:
-- 3. Get the total number of cancelled rides by customers:
-- 4. List the top 5 customers who booked the highest number of rides:
-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
-- 7. Retrieve all rides where payment was made using UPI:
-- 8. Find the average customer rating per vehicle type:
-- 9. Calculate the total booking value of rides completed successfully:
-- 10. List all incomplete rides along with the reason:


-- 1. Retrieve all successful bookings:
CREATE VIEW Successful_Bookings AS
SELECT * from Rides
WHERE booking_status ='Success';

SELECT * from Successful_Bookings


-- 2. Find the average ride distance for each vehicle type:
CREATE VIEW Avg_Ride_distance AS
SELECT vehicle_type,ROUND(AVG(ride_distance)::NUMERIC,2) AS AvgRideDistance FROM Rides
GROUP BY vehicle_type
ORDER BY AvgRideDistance ASC;

SELECT * FROM Avg_Ride_distance;

-- -- 3. Get the total number of cancelled rides by customers:
CREATE VIEW Cancelled_Rides_By_Customers AS
SELECT COUNT(*) AS NumberofCancelledRides from Rides
WHERE booking_status ='Canceled by Customer';

SELECT * FROM Cancelled_Rides_By_Customers

-- 4. List the top 5 customers who booked the highest number of rides:
CREATE VIEW Top_5_Customer AS
SELECT customer_id, COUNT(booking_id) AS countofBooking FROM Rides
GROUP BY customer_id
ORDER BY countofBooking DESC
LIMIT 5;

SELECT * FROM Top_5_Customer;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW Num_Personal_Car_Issue AS
SELECT COUNT(canceled_rides_by_driver) AS personalCarissue FROM Rides
WHERE canceled_rides_by_driver = 'Personal & Car related issue'

SELECT * FROM Num_Personal_Car_Issue;


-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW DriverMaxMinRating AS
SELECT vehicle_type,MAX(driver_ratings) AS maxrating , MIN(driver_ratings) AS minrating FROM Rides
WHERE vehicle_type = 'Prime Sedan'
GROUP BY vehicle_type;

SELECT * FROM DriverMaxMinRating;


-- 7. Retrieve all rides where payment was made using UPI:
CREATE VIEW UPIPayMode AS
SELECT * FROM Rides
WHERE payment_method = 'UPI';

SELECT * FROM UPIPayMode;


-- 8. Find the average customer rating per vehicle type:
CREATE VIEW AvgCustRatingPerVehicle AS
SELECT vehicle_type ,ROUND(AVG(customer_rating)::NUMERIC,2) AS avgcustrating
FROM Rides
GROUP BY vehicle_type
ORDER By avgCustrating;

SELECT * FROM AvgCustRatingPerVehicle;


-- 9. Calculate the total booking value of rides completed successfully:
CREATE VIEW Total_Amount AS
SELECT SUM(booking_value) AS totalvalue FROM Rides
WHERE booking_status = 'Success';


SELECT * FROM Total_Amount;


-- 10. List all incomplete rides along with the reason:
CREATE VIEW Incompete_Rides_Reason AS
SELECT booking_id,incomplete_rides_reason FROM Rides
WHERE incomplete_rides = 'Yes';

SELECT * FROM Incompete_Rides_Reason;





















