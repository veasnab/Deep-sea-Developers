-- Start of SQL Script
/* 
********************************
    Project: Phase II
    Group: Deep-sea Developers (XAMPP)
    This SQL Script was tested on web software stacks XAMPP using the Apache and MySQL module. 
    To import your script.sql file into XAMPP, you can follow these steps:
        1. Open XAMPP and start the Apache and MySQL services.
        2. Open your web browser and navigate to `http://localhost/phpmyadmin`.
        3. Log in to phpMyAdmin using your username and password.
        4. Create a new database where you want to import the script.sql file. Click on "New" in the left sidebar, enter a database name, and click "Create".
        5. Select the newly created database from the left sidebar.
        6. Click on the "Import" tab at the top of the page.
        7. Click on the "Choose File" button and locate your script.sql file on your computer.
        8. Make sure the "SQL" format is selected.
        9. Click the "Import" button to import the script.sql file into the selected database.
    Please note that the import process may take some time depending on the size of your script.sql file. 
********************************
*/


-- ***************************
-- Part A: Start
-- ***************************
-- ADDRESS: stores information about different addresses, including the country or region, state or province, and street address.
CREATE TABLE ADDRESSES 
(
    country_or_region   VARCHAR(50)     NOT NULL,
    state_or_province   VARCHAR(50)     NOT NULL,
    street_address      VARCHAR(100)    DEFAULT NULL,
    address_id          INT             PRIMARY KEY NOT NULL,
    UNIQUE (country_or_region, state_or_province, street_address)
);

-- ORGANIZATION: stores information about different organizations, including their address, website, contact number, and contact email.
CREATE TABLE ORGANIZATION 
(
    address_id          INT             DEFAULT NULL,
    website             VARCHAR(100),
    contact_number      VARCHAR(20)     UNIQUE,
    contact_email       VARCHAR(50)     UNIQUE,
    organization_id     INT             PRIMARY KEY NOT NULL,
    UNIQUE(address_id, website, contact_number, contact_email),
    FOREIGN KEY (address_id) REFERENCES ADDRESSES(address_id) ON DELETE SET NULL
);

-- MANUFACTURER: stores data about different manufacturers, including their name, contact information, and the address they are associated with.
CREATE TABLE MANUFACTURER 
(
    address_id          INT             DEFAULT NULL,
    manufacturer_name   VARCHAR(100)    NOT NULL,
    contact_number      VARCHAR(20)     UNIQUE,
    contact_email       VARCHAR(50)     UNIQUE,
    manufacturer_id     INT             PRIMARY KEY NOT NULL,
    UNIQUE (address_id, manufacturer_name, contact_number, contact_email),
    FOREIGN KEY (address_id) REFERENCES ADDRESSES(address_id) ON DELETE SET NULL
);

-- CTD_GPS: stores data about GPS coordinates and location information for CTD (Conductivity, Temperature, and Depth) measurements.
CREATE TABLE CTD_GPS 
(
    address_id          INT             DEFAULT NULL,
    latitude            DECIMAL(9,6)    CHECK (latitude >= -90 AND latitude <= 90),
    longitude           DECIMAL(9,6)    CHECK (longitude >= -180 AND longitude <= 180),
    location_name       VARCHAR(100),
    gps_id              INT             PRIMARY KEY NOT NULL,
    UNIQUE (latitude, longitude),
    FOREIGN KEY (address_id) REFERENCES ADDRESSES(address_id) ON DELETE SET NULL
);

-- CTD_DATA: stores various measurements related to oceanographic data, such as temperature, transmissivity, salinity, oxygen saturation, fluorescence, density, and pressure.
CREATE TABLE CTD_DATA 
(
    temperature         DECIMAL(10,2)   CHECK (temperature >= -50.00 AND temperature <= 100.00),
    transmissivity      DECIMAL(10,2)   CHECK (transmissivity >= 0.00 AND transmissivity <= 100.00),
    salinity            DECIMAL(10,2)   CHECK (salinity >= 0.00 AND salinity <= 50.00),
    oxygen_saturation   DECIMAL(10,2)   CHECK (oxygen_saturation >= 0.00 AND oxygen_saturation <= 100.00),
    florescence         DECIMAL(10,2)   CHECK (florescence >= 0.00 AND florescence <= 10.00),
    density             DECIMAL(10,2)   CHECK (density >= 1000.00 AND density <= 1100.00),
    pressure            DECIMAL(10,2)   CHECK (pressure >= 0.00 AND pressure <= 2000.00), 
    data_id             INT             PRIMARY KEY NOT NULL
);

-- CTD_OPERATOR: stores information about operators involved in CTD operations. It also includes a foreign key reference to the organization they belong to.
CREATE TABLE CTD_OPERATOR 
(
    organization_id     INT             NOT NULL,
    first_name          VARCHAR(50),
    middle_name         VARCHAR(50)     NULL,
    last_name           VARCHAR(50),
    operator_email      VARCHAR(100)    UNIQUE,
    operator_id         INT             PRIMARY KEY NOT NULL,
    UNIQUE (first_name , middle_name, last_name, operator_email),
    FOREIGN KEY (organization_id) REFERENCES ORGANIZATION(organization_id) ON UPDATE CASCADE
);

-- CTD_EQUIPMENT: stores information about equipment used in CTD operations.
CREATE TABLE CTD_EQUIPMENT 
(
    manufacturer_id             INT             NOT NULL,
    registered_organization     INT             NOT NULL,
    equipment_name              VARCHAR(100)    UNIQUE,
    equipment_id                INT             PRIMARY KEY NOT NULL,
    FOREIGN KEY (manufacturer_id) REFERENCES MANUFACTURER(manufacturer_id) ON UPDATE CASCADE,
    FOREIGN KEY (registered_organization) REFERENCES ORGANIZATION(organization_id) ON UPDATE CASCADE
);

-- CTD_LOG: stores log data related to CTD operations.
CREATE TABLE CTD_LOG 
(
    gps_id          INT                         NOT NULL,
    equipment_id    INT                         NOT NULL,
    operator_id     INT                         NOT NULL,
    data_id         INT                         NOT NULL,
    date_and_time   TIMESTAMP                   NOT NULL,
    log_id          INT                         PRIMARY KEY NOT NULL,
    FOREIGN KEY (gps_id) REFERENCES CTD_GPS(gps_id) ON DELETE CASCADE,
    FOREIGN KEY (equipment_id) REFERENCES CTD_EQUIPMENT(equipment_id) ON UPDATE CASCADE,
    FOREIGN KEY (operator_id) REFERENCES CTD_OPERATOR(operator_id) ON UPDATE CASCADE,
    FOREIGN KEY (data_id) REFERENCES CTD_DATA(data_id) ON DELETE CASCADE
);

-- ***************************
-- Part A: End
-- ***************************


-- ***************************
-- Part B: Start
-- ***************************
-- Sample data for ADDRESSES
-- Summary: store data for the ADDRESSES relation will store data about the country/region, state/province, and street address
--  for organizations, manufacturers, and GPS coordinates.
--      INSERT data for ORGANIZATION ADDRESS
INSERT INTO ADDRESSES VALUES ('United States', 'Washington, D.C', '1401 Constitution Avenue NW, Room 5128', 1001);
INSERT INTO ADDRESSES VALUES ('United States', 'Massachusetts', '266 Woods Hole Road, Woods Hole', 1002);
INSERT INTO ADDRESSES VALUES ('United States', 'California', '9500 Gilman Drive, La Jolla', 1003);
INSERT INTO ADDRESSES VALUES ('United Kingdom', 'Southampton', 'SO14 3ZH', 1004);
INSERT INTO ADDRESSES VALUES ('Australia', 'QLD', '1526 Cape Cleveland Road, Cape Cleveland', 1005);
INSERT INTO ADDRESSES VALUES ('China', 'Qingdao', '7 Nanhai Road', 1006);
INSERT INTO ADDRESSES VALUES ('United Kingdom', 'Devon', 'Citadel Hill Plymouth', 1007);
INSERT INTO ADDRESSES VALUES ('Norway', 'Bergen', 'Nordnesgaten 50', 1008);
INSERT INTO ADDRESSES VALUES ('Japan', 'Kanagawa', '2-15 Natsushimachō, Yokosuka', 1009);
INSERT INTO ADDRESSES VALUES ('United Kingdom', 'Southampton', 'European Way', 1010);
--      INSERT data for MANUFACTURER ADDRESS
INSERT INTO ADDRESSES VALUES ('United States', 'California', '123 Main St', 1011);
INSERT INTO ADDRESSES VALUES ('Australia', 'Sydney', '555 Beach Rd', 1012);
INSERT INTO ADDRESSES VALUES ('China', 'Beijing', '456 Great Wall St', 1013);
INSERT INTO ADDRESSES VALUES ('United Kingdom', 'London', '10 Downing Street', 1014);
INSERT INTO ADDRESSES VALUES ('Norway', 'Oslo', '123 Fjord Lane', 1015);
--      INSERT data for CTD_GPS ADDRESS
INSERT INTO ADDRESSES VALUES ('Japan', 'Hiroshima', NULL, 1016);
INSERT INTO ADDRESSES VALUES ('Norway', 'Oslo', NULL, 1017);
INSERT INTO ADDRESSES VALUES ('United States', 'California', NULL, 1018);
INSERT INTO ADDRESSES VALUES ('China', 'Beijing', 'Fangshan District', 1019);
INSERT INTO ADDRESSES VALUES ('Australia', 'Sydney', NULL, 1020);

-- Sample data for ORGANIZATION
-- Summary: store data for the ORGANIZATION relation will store the contact information for organizations involved in oceanography research. 
-- Along with a foreign key linking to the corresponding address.
INSERT INTO ORGANIZATION VALUES (1001, 'www.noaa.gov', '301-713-1208', 'outreach@noaa.gov', 2001);
INSERT INTO ORGANIZATION VALUES (1002, 'www.whoi.edu', '508-289-2252', 'information@whoi.edu', 2002);
INSERT INTO ORGANIZATION VALUES (1003, 'scripps.ucsd.edu', '858-246-5511', 'scrippsnews@ucsd.edu', 2003);
INSERT INTO ORGANIZATION VALUES (1004, 'www.bodc.ac.uk', '44-0-782-512-0946', 'enquiries@bodc.ac.uk', 2004);
INSERT INTO ORGANIZATION VALUES (1005, 'www.aims.gov.au', '61-7-4753-4444', 'reception@aims.gov.au', 2005);
INSERT INTO ORGANIZATION VALUES (1006, 'english.qdio.cas.cn', '86-532-82898611', 'iocas@qdio.ac.cn', 2006);
INSERT INTO ORGANIZATION VALUES (1007, 'www.mba.ac.uk', '44-0-1752-426493', 'info@mba.ac.uk', 2007);
INSERT INTO ORGANIZATION VALUES (1008, 'www.hi.no/en', '47-55-23-85-00', 'post@hi.no', 2008);
INSERT INTO ORGANIZATION VALUES (1009, 'www.jamstec.go.jp/e/', '81-46-866-3811', 'library@jamstec.go.jp', 2009);
INSERT INTO ORGANIZATION VALUES (1010, 'noc.ac.uk', '44-0-23-8059-6666', 'giving@noc.ac.uk', 2010);

-- Sample data for MANUFACTURER
-- Summary: store data for the MANUFACTURER relation will store the contact information for manufacturers involved in CTD manufacturing, 
-- Along with a foreign key linking to the corresponding address.
INSERT INTO MANUFACTURER VALUES (1011, 'ABC Manufacturing', '123-456-7890', 'abc@example.com', 3001);
INSERT INTO MANUFACTURER VALUES (NULL, 'XYZ Corporation', '987-654-3210', 'xyz@example.com', 3002);
INSERT INTO MANUFACTURER VALUES (1012, 'Ocean Tech', '555-123-4567', 'ocean@example.com', 3003);
INSERT INTO MANUFACTURER VALUES (NULL, 'Marine Instruments', '888-999-0000', 'marine@example.com', 3004);
INSERT INTO MANUFACTURER VALUES (1013, 'Deep Sea Technologies', '111-222-3333', 'deepsea@example.com', 3005);
INSERT INTO MANUFACTURER VALUES (NULL, 'Aqua Research', '444-555-6666', 'aqua@example.com', 3006);
INSERT INTO MANUFACTURER VALUES (1014, 'Sea Explorers', '777-888-9999', 'sea@example.com', 3007);
INSERT INTO MANUFACTURER VALUES (NULL, 'TechMar', '222-333-4444', 'techmar@example.com', 3008);
INSERT INTO MANUFACTURER VALUES (1015, 'Oceanic Solutions', '666-777-8888', 'oceanic@example.com', 3009);
INSERT INTO MANUFACTURER VALUES (NULL, 'Maritime Innovations', '999-000-1111', 'maritime@example.com', 3010);

-- Sample data for CTD_GPS
-- Summary: store data for CTD_GPS relation will store information about different GPS coordinate locations of where the data pointer were collected.
-- Along with a foreign key linking to the corresponding address. 
INSERT INTO CTD_GPS VALUES (1016, 34.343, 132.422, 'Minami Ward', 4001);
INSERT INTO CTD_GPS VALUES (1017, 59.9025, 10.7242, 'Kavringen naturreservat', 4002);
INSERT INTO CTD_GPS VALUES (1018, 33.945, -118.4719, 'Santa Monica Bay', 4003);
INSERT INTO CTD_GPS VALUES (1018, 33.9514, -118.5184, 'Santa Monica Bay', 4004);
INSERT INTO CTD_GPS VALUES (1018, 33.9432, -118.5439, 'Santa Monica Bay', 4005);
INSERT INTO CTD_GPS VALUES (1019, 39.789, 116.2324, 'Beijing River, Fangshan', 4006);
INSERT INTO CTD_GPS VALUES (1020, -33.8601, 151.2417, 'Sydney Harbor', 4007);
INSERT INTO CTD_GPS VALUES (1020, -33.8567, 151.2363, 'Sydney Harbor', 4008);
INSERT INTO CTD_GPS VALUES (1020, -33.8626, 151.2357, 'Sydney Harbor', 4009);
INSERT INTO CTD_GPS VALUES (1020, -33.8627, 151.2448, 'Sydney Harbor', 4010);

-- Sample data for CTD_DATA
-- Summary: store data for CTD_DATA relation will store the collected data points from a CTD (Conductivity, Temperature, and Depth) instrument.  
INSERT INTO CTD_DATA VALUES (15.20, 85.40, 35.60, 90.20, 5.80, 1020.40, 150.20, 5001);
INSERT INTO CTD_DATA VALUES (17.80, 80.20, 33.70, 92.50, 6.40, 1019.80, 160.70, 5002);
INSERT INTO CTD_DATA VALUES (18.50, 75.60, 34.20, 91.80, 5.50, 1021.00, 155.30, 5003);
INSERT INTO CTD_DATA VALUES (14.30, 88.00, 36.20, 89.70, 6.80, 1018.50, 140.80, 5004);
INSERT INTO CTD_DATA VALUES (16.70, 82.10, 34.90, 91.20, 5.90, 1020.10, 148.60, 5005);
INSERT INTO CTD_DATA VALUES (15.90, 85.00, 35.10, 90.60, 6.20, 1019.60, 157.20, 5006);
INSERT INTO CTD_DATA VALUES (16.80, 83.40, 34.50, 92.10, 5.30, 1021.30, 145.70, 5007);
INSERT INTO CTD_DATA VALUES (17.50, 79.80, 33.90, 91.60, 6.60, 1019.00, 152.40, 5008);
INSERT INTO CTD_DATA VALUES (18.20, 76.20, 35.80, 90.90, 5.40, 1020.80, 158.90, 5009);
INSERT INTO CTD_DATA VALUES (14.70, 87.50, 36.40, 89.50, 6.40, 1018.20, 143.90, 5010);

-- Sample data for CTD_OPERATOR
-- Summary: store data for CTD_OPERATOR relation will store data about the operator's name, email, and a foreign key referencing their organization.
INSERT INTO CTD_OPERATOR VALUES (2001, 'John', 'A.', 'Smith', 'john.smith@noaa.gov', 6001);
INSERT INTO CTD_OPERATOR VALUES (2002, 'Emily', NULL, 'Johnson', 'emily.johnson@whoi.edu', 6002);
INSERT INTO CTD_OPERATOR VALUES (2001, 'Michael', 'B.', 'Davis', 'michael.davis@noaa.gov', 6003);
INSERT INTO CTD_OPERATOR VALUES (2003, 'Sophia', NULL, 'Lee', 'sophia.lee@ucsd.edu', 6004);
INSERT INTO CTD_OPERATOR VALUES (2002, 'William', 'C.', 'Wilson', 'william.wilson@whoi.edu', 6005);
INSERT INTO CTD_OPERATOR VALUES (2004, 'Olivia', NULL, 'White', 'olivia.white@bodc.ac.u', 6006);
INSERT INTO CTD_OPERATOR VALUES (2003, 'James', 'D.', 'Brown', 'james.brown@ucsd.edu', 6007);
INSERT INTO CTD_OPERATOR VALUES (2001, 'Emma', NULL, 'Martinez', 'emma.martinez@noaa.gov', 6008);
INSERT INTO CTD_OPERATOR VALUES (2002, 'Alexander', 'E.', 'Lopez', 'alexander.lopez@whoi.edu', 6009);
INSERT INTO CTD_OPERATOR VALUES (2004, 'Mia', NULL, 'Garcia', 'mia.garcia@bodc.ac.u', 6010);

-- Sample data for CTD_EQUIPMENT
-- Summary: store data for CTD_EQUIPMENT relation will store data about the CTD equipment's name, along with two foreign keys. 
-- One will reference the manufacturer who made it, and the other will reference the organization it is registered with.
INSERT INTO CTD_EQUIPMENT VALUES (3001, 2001, 'CTD Sensor 1', 7001);
INSERT INTO CTD_EQUIPMENT VALUES (3002, 2002, 'CTD Sensor 2', 7002);
INSERT INTO CTD_EQUIPMENT VALUES (3003, 2001, 'CTD Sensor 3', 7003);
INSERT INTO CTD_EQUIPMENT VALUES (3004, 2003, 'CTD Sensor 4', 7004);
INSERT INTO CTD_EQUIPMENT VALUES (3005, 2002, 'CTD Sensor 5', 7005);
INSERT INTO CTD_EQUIPMENT VALUES (3006, 2004, 'CTD Sensor 6', 7006);
INSERT INTO CTD_EQUIPMENT VALUES (3007, 2003, 'CTD Sensor 7', 7007);
INSERT INTO CTD_EQUIPMENT VALUES (3008, 2003, 'CTD Sensor 8', 7008);
INSERT INTO CTD_EQUIPMENT VALUES (3009, 2001, 'CTD Sensor 9', 7009);
INSERT INTO CTD_EQUIPMENT VALUES (3010, 2004, 'CTD Sensor 10', 7010);

-- Sample data for CTD_LOG
-- Summary: store data for CTD_LOG relation will store the timestamp log of when the data points were collected. 
-- It will also have four foreign keys: 
-- one linking to the organization where the data was collected, 
-- one linking to the CTD operator who operated the CTD at that time, 
-- one linking to the GPS coordinates of where the data was collected, 
-- and one linking to the CTD equipment that was being used.
INSERT INTO CTD_LOG VALUES (4001, 7002, 6002, 5002, '2023-11-04 11:00:00+00', 8001);
INSERT INTO CTD_LOG VALUES (4002, 7002, 6002, 5002, '2023-11-04 11:15:00+00', 8002);
INSERT INTO CTD_LOG VALUES (4003, 7004, 6007, 5003, '2023-11-04 12:45:00+00', 8003);
INSERT INTO CTD_LOG VALUES (4004, 7005, 6002, 5004, '2023-11-04 13:20:00+00', 8004);
INSERT INTO CTD_LOG VALUES (4005, 7006, 6010, 5005, '2023-11-04 14:05:00+00', 8005);
INSERT INTO CTD_LOG VALUES (4006, 7004, 6007, 5006, '2023-11-04 15:30:00+00', 8006);
INSERT INTO CTD_LOG VALUES (4007, 7007, 6007, 5007, '2023-11-04 16:45:00+00', 8007);
INSERT INTO CTD_LOG VALUES (4008, 7008, 6007, 5008, '2023-11-04 17:10:00+00', 8008);
INSERT INTO CTD_LOG VALUES (4009, 7009, 6008, 5009, '2023-11-04 18:25:00+00', 8009);
INSERT INTO CTD_LOG VALUES (4010, 7010, 6010, 5010, '2023-11-04 19:40:00+00', 8010);

-- ***************************
-- Part B: End
-- ***************************


-- ***************************
-- Part C: Start
-- ***************************
-- SQL Query 1 
-- Purpose: To organize data logs by the location they were taken In order to analyze data by region. 
-- Expected Result: A table that contains ctd data and the gps coordinates of where it was taken.  
SELECT ctd_gps.latitude, ctd_gps.longitude, ctd_data.temperature, ctd_data.transmissivity, ctd_data.salinity, ctd_data.oxygen_saturation, ctd_data.florescence, ctd_data.density, ctd_data.pressure 
FROM ctd_data 
JOIN ctd_log ON ctd_data.data_id = ctd_log.data_id 
JOIN ctd_gps ON ctd_log.gps_id = ctd_gps.gps_id 
GROUP BY ctd_gps.latitude, ctd_gps.longitude; 

--  SQL QUERY 2 
--  Purpose: Organize ctd data by the equipment used to gather it, in order to verify the source of ctd_data 
--  Expected: A table that contains ctd data and the name of the equipment used to gather it. 
SELECT CTD.Name, ctd_data.temperature, ctd_data.transmissivity, ctd_data.salinity, ctd_data.oxygen_saturation, ctd_data.florescence, ctd_data.density, ctd_data.pressure 
FROM (SELECT ctd_equipment.equipment_name AS Name, ctd_log.equipment_id, ctd_log.data_id 
     FROM ctd_log 
     JOIN ctd_equipment ON ctd_log.equipment_id = ctd_equipment.equipment_id) 
     AS CTD, ctd_data
WHERE ctd_data.data_id IN (CTD.data_id) 
GROUP BY CTD.Name ASC; 

-- SQL QUERY 3 
-- Purpose: Identify locations that have anomalous/outlier temperature readings in the ocean. 
-- Expected: A table of locations where above average water temperature was recorded. Included in the result set is a name of the location and the temperature recorded. 
SELECT ctd_gps.location_name, ctd_data.temperature 
FROM ctd_data 
JOIN ctd_log ON ctd_data.data_id=ctd_log.data_id 
JOIN ctd_gps ON ctd_log.gps_id=ctd_gps.gps_id 
WHERE temperature > (SELECT AVG(ctd_data.temperature) FROM ctd_data); 

-- SQL Query 4 
-- Purpose: is to show the equipment that have gather CTD data, it also display the equipment that have not gather data (NULL). 
-- Expected: A set that includes all the columns from both the "CTD_EQUIPMENT" and -- "CTD_LOG" tables. It will show the equipment being used in CTD operations along with  
-- the, along with any equipment that is not being used.   
SELECT * 
FROM CTD_EQUIPMENT 
LEFT JOIN CTD_LOG ON CTD_EQUIPMENT.equipment_id = CTD_LOG.equipment_id 
UNION 
SELECT * 
FROM CTD_EQUIPMENT 
RIGHT JOIN CTD_LOG ON CTD_EQUIPMENT.equipment_id = CTD_LOG.equipment_id 
WHERE CTD_EQUIPMENT.equipment_id IS NULL; 

-- SQL Query 5
-- Purpose: Retrieve a list of unique contact emails from both the ORGANIZATION and MANUFACTURER tables. 
-- It combines the contact_email column from both tables using the UNION operator. 
-- Sending emails can be a useful way to communicate and share information. 
-- It allows you to reach out to individuals or groups conveniently. 
-- Expected: A set that consists of a single column named "contact_email" containing all the unique contact email addresses from the ORGANIZATION and MANUFACTURER tables. 
SELECT contact_email
FROM (SELECT contact_email
     FROM ORGANIZATION
     UNION
     SELECT contact_email
     FROM MANUFACTURER) 
     AS CombinedEmails;

-- SQL QUERY 6 
-- Purpose: To acknowledge scientists who go above and beyond collecting oceanographic data. 
-- Expected: A table that lists the names of all registered operators who have uploaded a ctd_log, ordered by number of ctd_logs they have uploaded. 
SELECT ctd_operator.first_name, ctd_operator.middle_name, ctd_operator.last_name, operatorEntries.RecordsLogged 
FROM ctd_operator 
JOIN (SELECT ctd_operator.operator_id, COUNT(ctd_log.log_id) AS RecordsLogged 
     FROM ctd_operator 
     JOIN ctd_log ON ctd_log.operator_id = ctd_operator.operator_id 
     GROUP BY ctd_operator.operator_id) 
     AS operatorEntries 
ON ctd_operator.operator_id = operatorEntries.operator_id   
ORDER BY RecordsLogged DESC; 

-- SQL QUERY 7
-- Pupose: Retrieve details of CTD operations, including equipment, organization, and operator information. 
-- Expected: A result set that combines data from CTD_LOG, CTD_EQUIPMENT, CTD_OPERATOR, and ORGANIZATION.  
SELECT O.organization_id, O.contact_email, O.contact_number, O.website, COALESCE(CONCAT(OO.first_name, ' ', OO.last_name), 'No Operators') AS operators 
FROM ORGANIZATION O 
LEFT JOIN CTD_OPERATOR OO ON O.organization_id = OO.organization_id; 

-- SQL QUERY 8 
-- Purpose: Retrieve the manufacturer data for all the equipment. 
-- Expected: A table that consists of the equipment name, manufacturer name, manufacturer number, manufacturer email, and address. 
SELECT E.equipment_name AS Equipment, 
       M. manufacturer_name AS Manufacturer, 
       M.contact_number AS Manufacturer_Phone_Contact, 
       M.contact_email AS Manufacturer_Email_Contact, 
       CONCAT(A.street_address, ', ', A.state_or_province, ', ', A.country_or_region) AS Manufacturer_Address 
FROM manufacturer M 
JOIN ctd_equipment E ON M.manufacturer_id = E.manufacturer_id 
JOIN addresses A ON M.address_id = A.address_id; 

-- SQL QUERY 9
-- Purpose: Retrieve the contact information for all the equipment. 
-- Expected: A table that combines the CTD equipment name with its organizations details and their address.  
SELECT E.equipment_name AS Equipment, 
       O.website AS Organization_Site, 
       O.contact_number AS Organization_Phone_Contact, 
       O.contact_email AS Organization_Email_Contact, 
       CONCAT(A.street_address, ', ', A.state_or_province, ', ', A.country_or_region) AS Organization_Address 
FROM organization O 
JOIN ctd_equipment E ON O.organization_id = E.registered_organization 
JOIN addresses A ON O.address_id = A.address_id; 

-- SQL QUERY 10
-- Purpose: Retrieve a list of organizations and their associated operators. 
-- Expected: A result set containing organizations and their operators. 
SELECT L.date_and_time AS operation_date, 
       E.equipment_name AS equipment_used, 
       O.organization_id AS organization_id, 
       O.contact_email AS organization_email, 
       CONCAT(OO.first_name, ' ', OO.last_name) AS operator_name, 
       OO.operator_email AS operator_email 
FROM CTD_LOG L 
JOIN CTD_EQUIPMENT E ON L.equipment_id = E.equipment_id 
JOIN CTD_OPERATOR OO ON L.operator_id = OO.operator_id 
LEFT JOIN ORGANIZATION O ON OO.organization_id = O.organization_id; 

-- ***************************
-- Part C: End
-- ***************************


-- End of Script (Nov 6, 2023)
