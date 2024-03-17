-- Datasets by Datayolk --
-- Pacticer : Kritsada Saenkot(New)
-- Date: 2024-03-01
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('available', 'occupied'))
);

CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY,
    room_id INT,
    customer_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

-- Inserting data into the Rooms table
INSERT INTO Rooms (room_id, room_type, status) VALUES
(1, 'Deluxe', 'available'),
(2, 'Deluxe', 'available'),
(3, 'Executive Suite', 'available'),
(4, 'Presidential Suite', 'available'),
(5, 'Deluxe', 'occupied'),
(6, 'Presidential Suite', 'occupied'),
(7, 'Executive Suite', 'occupied'),
(8, 'Deluxe', 'available'),
(9, 'Presidential Suite', 'available');

-- Inserting data into the Reservations table
INSERT INTO Reservations (reservation_id, room_id, customer_id, check_in_date, check_out_date, amount_paid) VALUES
(1, 1, 101, '2024-02-01', '2024-02-05', 500),
(2, 2, 102, '2024-02-02', '2024-02-07', 800),
(3, 3, 103, '2024-02-03', '2024-02-10', 1200),
(4, 4, 104, '2024-02-04', '2024-02-06', 1000),
(5, 5, 105, '2024-02-05', '2024-02-09', 1500),
(6, 6, 106, '2024-02-06', '2024-02-08', 2000),
(7, 7, 107, '2024-02-07', '2024-02-11', 1800),
(8, 8, 108, '2024-02-08', '2024-02-12', 1600),
(9, 9, 109, '2024-02-09', '2024-02-13', 1400);

.print #######################
.print #### SQL Challenge ####
.print #######################

.print \n Rooms table
.mode box
select * from Rooms limit 5;

.print \n Reservations table
.mode box
select * from Reservations limit 5;

-- 1.หาประเภทห้องที่โรงแรมมีและจำนวนห้องที่ว่างในแต่ละปะเภท
.print \n 1.ประเภทห้องที่โรงแรมมีและจำนวนห้องที่ว่างในแต่ละปะเภท
.mode box
select room_type, count(status) AS status_room,status
from Rooms
where status = 'available'
group by room_type;

--2. คำนวณราคาเฉลี่ยที่ลูกค้าจ่ายต่อครั้ง
.print \n 2.ราคาเฉลี่ยที่ลูกค้าจ่ายต่อครั้ง
select avg(amount_paid) as avg_price
from Reservations;

--3.;วันไหน(จ.-อา.)ที่ลูกค้าที่มียอดการใช้จ่ายสูงสุด และจองห้องไปกี่ครั้ง
.print \n 3.วันที่ลูกค้ามียอดการใช้จ่ายสูงสุด และจองห้องไปกี่ครั้ง
--select customer_id, sum(amount_paid) as total_price
--from Reservations
--group by customer_id
--order by total_price desc limit 1;
SELECT
CASE
WHEN strftime('%w', check_in_date) = '0' THEN 'Sunday'
WHEN strftime('%w', check_in_date) = '1' THEN 'Monday'
WHEN strftime('%w', check_in_date) = '2' THEN 'Tuesday'
WHEN strftime('%w', check_in_date) = '3' THEN 'Wednesday'
WHEN strftime('%w', check_in_date) = '4' THEN 'Thursday'
WHEN strftime('%w', check_in_date) = '5' THEN 'Friday'
WHEN strftime('%w', check_in_date) = '6' THEN 'Saturday'
END AS day_of_week,
COUNT(*) AS booking_count,sum(amount_paid) total_price
FROM reservations
GROUP BY day_of_week
ORDER BY booking_count desc ,total_price desc;

-- 4. หาลูกค้าคนใดที่มียอดการใช้จ่ายสูงสุด และจองห้องไปกี่ครั้ง
.print \n 4.ลูกค้าคนใดที่มียอดการใช้จ่ายสูงสุด และจองห้องไปกี่ครั้ง
select customer_id, sum(amount_paid) as total_price,
  count(*) as booking_count
from Reservations
group by customer_id
order by total_price desc limit 1;

-- 5.คำนวนอัตราการเข้าพัก (Occupancy Rate) ของโรงแรมนี้
.print \n 5.คำนวนอัตราการเข้าพัก (Occupancy Rate)
SELECT
COALESCE((SUM(CASE WHEN status = 'occupied' THEN 1 ELSE 0 END) * 100.0) / NULLIF(COUNT(*), 0), 0) AS occupancy_rate
FROM rooms;










