-- Start of SQL Script

/* 
********************************
    Project: Phase III
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

-- MANUFACTURER: store data about various manufacturers who are involved in the production of oceanography CTD instruments. 
CREATE TABLE MANUFACTURER
(
    Mname           VARCHAR(100)     NOT NULL,
    Phone           VARCHAR(20)      DEFAULT NULL,
    Email           VARCHAR(100)     PRIMARY KEY NOT NULL
);

-- ORGANIZATION: stores data about various organizations who are involved in the oceanography research/study.
CREATE TABLE ORGANIZATION
(
    Website         VARCHAR(100)     DEFAULT NULL,
    Oname           VARCHAR(100)     NOT NULL,
    Phone           VARCHAR(20)      DEFAULT NULL,
    Email           VARCHAR(100)     PRIMARY KEY NOT NULL
);

-- OPERATOR: stores data about the individual operators who are involved in CTD operations. 
CREATE TABLE OPERATOR
(
    Fname           VARCHAR(100)     NOT NULL,
    Minit           CHAR(50)         DEFAULT NULL,
    Lname           VARCHAR(100)     NOT NULL,
    Email           VARCHAR(100)     PRIMARY KEY NOT NULL
);

-- GPS: stores data about GPS coordinates, specifically latitude and longitude, and map them to a name.  
CREATE TABLE GPS
(   
    Gname           VARCHAR(100)     NOT NULL,
    Latitude        DECIMAL(9,6)     CHECK (Latitude >= -90 AND Latitude <= 90),
    Longitude       DECIMAL(9,6)     CHECK (Longitude >= -180 AND Longitude <= 180),
    PRIMARY KEY (Latitude, Longitude)
);

-- EQUIPMENT: store data about individual CTD instruments. 
-- It includes information about which organization the equipment is registered to and the manufacturer that produced it. 
CREATE TABLE EQUIPMENT
(
    Produce         VARCHAR(100)     DEFAULT NULL,
    Register        VARCHAR(100)     DEFAULT NULL, 
    Ename           VARCHAR(100)     NOT NULL,
    SKU             INT              PRIMARY KEY NOT NULL,
    FOREIGN KEY (Produce)   REFERENCES MANUFACTURER(Email)  ON DELETE SET NULL ON UPDATE CASCADE, 
    FOREIGN KEY (Register)  REFERENCES ORGANIZATION(Email)  ON DELETE SET NULL ON UPDATE CASCADE
);

-- EMPLOY: stores data about start date of individual operators with an organization.
CREATE TABLE EMPLOY
(
    Edate           DATE             NOT NULL,
    Organization    VARCHAR(100)     NOT NULL,
    Operator        VARCHAR(100)     NOT NULL,
    PRIMARY KEY (Organization, Operator), 
    FOREIGN KEY (Organization)  REFERENCES ORGANIZATION (Email) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Operator)      REFERENCES OPERATOR (Email)     ON DELETE CASCADE ON UPDATE CASCADE
);   


-- MEASUREMENT: stores data related to oceanography, such as temperature, transmissivity, salinity, oxygen saturation, fluorescence, density, and pressure.
-- It also includes information about the date and time, the GPS coordinates, the operator who collect the data, and the equipment used to collect the data. 
CREATE TABLE MEASUREMENT 
(
    temperature     DECIMAL(10,2)   CHECK (temperature >= -50.00 AND temperature <= 100.00),
    transmissivity  DECIMAL(10,2)   CHECK (transmissivity >= 0.00 AND transmissivity <= 100.00),
    salinity        DECIMAL(10,2)   CHECK (salinity >= 0.00 AND salinity <= 50.00),
    saturation      DECIMAL(10,2)   CHECK (saturation >= 0.00 AND saturation <= 100.00),
    florescence     DECIMAL(10,2)   CHECK (florescence >= 0.00 AND florescence <= 10.00),
    density         DECIMAL(10,2)   CHECK (density >= 1000.00 AND density <= 1100.00),
    pressure        DECIMAL(10,2)   CHECK (pressure >= 0.00 AND pressure <= 2000.00), 
    LocateLati      DECIMAL(9,6)    CHECK (LocateLati >= -90 AND LocateLati <= 90),
    LocateLong      DECIMAL(9,6)    CHECK (LocateLong >= -180 AND LocateLong <= 180),
    Mlog            VARCHAR(100)    NOT NULL,
    Utilize         INT             NOT NULL,
    Mtime           TIMESTAMP       NOT NULL,
    PRIMARY KEY (LocateLati, LocateLong, Mlog, Utilize, Mtime),
    FOREIGN KEY (LocateLati, LocateLong) REFERENCES GPS (Latitude, Longitude) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Mlog) REFERENCES OPERATOR (Email) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Utilize) REFERENCES EQUIPMENT (SKU) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ***************************
-- Part A: End
-- ***************************


-- ***************************
-- Part B: Start
-- ***************************

-- Sample data for MANUFACTURER
-- Summary: store data for the MANUFACTURER relation. It will store data about various manufacturers who are involved in the production of oceanography CTD instruments.
INSERT INTO MANUFACTURER VALUES ('ABC Manufacturing', '123-456-7890', 'abc@example.com');
INSERT INTO MANUFACTURER VALUES ('XYZ Corporation', '987-654-3210', 'xyz@example.com');
INSERT INTO MANUFACTURER VALUES ('Ocean Tech', '555-123-4567', 'ocean@example.com');
INSERT INTO MANUFACTURER VALUES ('Marine Instruments', '888-999-0000', 'marine@example.com');
INSERT INTO MANUFACTURER VALUES ('Deep Sea Technologies', NULL, 'deepsea@example.com');
INSERT INTO MANUFACTURER VALUES ('Aqua Research', '444-555-6666', 'aqua@example.com');
INSERT INTO MANUFACTURER VALUES ('Sea Explorers', '777-888-9999', 'sea@example.com');
INSERT INTO MANUFACTURER VALUES ('Ocean Tech', NULL, 'oceantech@example.com');
INSERT INTO MANUFACTURER VALUES ('Oceanic Solutions', '666-777-8888', 'oceanic@example.com');
INSERT INTO MANUFACTURER VALUES ('Maritime Innovations', '999-000-1111', 'maritime@example.com');

-- Sample data for ORGANIZATION
-- Summary: store data for the ORGANIZATION relation. It will store data about various organizations who are involved in the oceanography research/study. 
INSERT INTO ORGANIZATION VALUES ('www.bodc.ac.uk', 'UK Oceanographic Data', NULL, 'enquiries@bodc.ac.uk');
INSERT INTO ORGANIZATION VALUES ('www.aims.gov.au', 'Ausralian Marine Science' , NULL, 'reception@aims.gov.au');
INSERT INTO ORGANIZATION VALUES ('www.noaa.gov', 'NOAA', '301-713-1208', 'outreach@noaa.gov');
INSERT INTO ORGANIZATION VALUES ('www.whoi.edu', 'WHOI', '508-289-2252', 'information@whoi.edu');
INSERT INTO ORGANIZATION VALUES ('scripps.ucsd.edu', 'SCRIPPS', '858-246-5511', 'scrippsnews@ucsd.edu');
INSERT INTO ORGANIZATION VALUES ('english.qdio.cas.cn', 'IOCAS', NULL, 'iocas@qdio.ac.cn');
INSERT INTO ORGANIZATION VALUES ('www.mba.ac.uk', 'UK Oceanographic Data', NULL, 'info@mba.ac.uk');
INSERT INTO ORGANIZATION VALUES (NULL, 'Marine Research', NULL, 'post@hi.no');
INSERT INTO ORGANIZATION VALUES (NULL, 'Marine Research', '102-201-1020', 'postIO@hi.no');
INSERT INTO ORGANIZATION VALUES ('noc.ac.uk', 'National Ocean', NULL, 'giving@noc.ac.uk');

-- Sample data for OPERATOR
-- Summary: store data for OPERATOR relation. It will store data about the individual operators who are involved in CTD operations.
INSERT INTO OPERATOR VALUES ('John', 'A.', 'Smith', 'john.smith@noaa.gov');
INSERT INTO OPERATOR VALUES ('Emily', NULL, 'Johnson', 'emily.johnson@whoi.edu');
INSERT INTO OPERATOR VALUES ('Michael', 'B.', 'Davis', 'michael.davis@noaa.gov');
INSERT INTO OPERATOR VALUES ('Emily', NULL, 'Lee', 'emily.johnson@ucsd.edu');
INSERT INTO OPERATOR VALUES ('William', 'C.', 'Johnson', 'william.wilson@whoi.edu');
INSERT INTO OPERATOR VALUES ('Olivia', NULL, 'White', 'olivia.white@bodc.ac.uk');
INSERT INTO OPERATOR VALUES ('James', 'D.', 'Brown', 'james.brown@ucsd.edu');
INSERT INTO OPERATOR VALUES ('Emma', NULL, 'Martinez', 'emma.martinez@noaa.gov');
INSERT INTO OPERATOR VALUES ('Alexander', 'E.', 'Lopez', 'alexander.lopez@whoi.edu');
INSERT INTO OPERATOR VALUES ('Mia', NULL, 'Garcia', 'mia.garcia@bodc.ac.uk');

-- Sample data for GPS
-- Summary: store data for GPS relation. It will store information about coordinates, specifically latitude and longitude, and map them to a name.
INSERT INTO GPS VALUES ('Minami Ward', 34.343, 132.422);
INSERT INTO GPS VALUES ('Kavringen', 59.9025, 10.7242);
INSERT INTO GPS VALUES ('Santa Monica Bay', 33.945, -118.4719);
INSERT INTO GPS VALUES ('Santa Monica Bay', 33.9514, -118.5184);
INSERT INTO GPS VALUES ('Santa Monica Bay', 33.9432, -118.5439);
INSERT INTO GPS VALUES ('Beijing River', 39.789, 116.2324);
INSERT INTO GPS VALUES ('Sydney Harbor', -33.8601, 151.2417);
INSERT INTO GPS VALUES ('Sydney Harbor', -33.8567, 151.2363);
INSERT INTO GPS VALUES ('Sydney Harbor', -33.8626, 151.2357);
INSERT INTO GPS VALUES ('Sydney Harbor', -33.8627, 151.2448);

-- Sample data for EQUIPMENT
-- Summary: store data for EQUIPMENT relation. It will store data of individual CTD instruments. 
-- It will also store information about which organization the equipment is registered to and the manufacturer that produced it. 
INSERT INTO EQUIPMENT VALUES ('xyz@example.com', NULL, 'DeepBlue Voyager', 1001);
INSERT INTO EQUIPMENT VALUES ('xyz@example.com', 'outreach@noaa.gov', 'DeepBlue Voyager', 1002);
INSERT INTO EQUIPMENT VALUES ('xyz@example.com', 'outreach@noaa.gov', 'AquaVortex', 1003);
INSERT INTO EQUIPMENT VALUES ('oceantech@example.com', 'outreach@noaa.gov', 'Dynamo', 1004);
INSERT INTO EQUIPMENT VALUES ('sea@example.com', NULL, 'Dynamo', 1005);
INSERT INTO EQUIPMENT VALUES ('sea@example.com', 'outreach@noaa.gov', 'Nexus', 1006);
INSERT INTO EQUIPMENT VALUES ('aqua@example.com', 'outreach@noaa.gov', 'Nexus', 1008);
INSERT INTO EQUIPMENT VALUES ('aqua@example.com', NULL, 'Nexus', 1009);
INSERT INTO EQUIPMENT VALUES ('aqua@example.com', 'outreach@noaa.gov', 'HydroMystique Elite', 1010);
INSERT INTO EQUIPMENT VALUES (NULL, NULL, 'Equipment', 1007);

-- Sample data for EMPLOY
-- Summary: store data for EMPLOYT relation. It will store data on the start date of individual operators with an organization. 
-- It will also store information about organization and operator they relate too.
INSERT INTO EMPLOY VALUES ('2022-01-15', 'outreach@noaa.gov', 'john.smith@noaa.gov');
INSERT INTO EMPLOY VALUES ('2021-08-22', 'information@whoi.edu', 'emily.johnson@whoi.edu');
INSERT INTO EMPLOY VALUES ('2022-03-10', 'outreach@noaa.gov', 'michael.davis@noaa.gov');
INSERT INTO EMPLOY VALUES ('2021-12-05', 'scrippsnews@ucsd.edu', 'emily.johnson@ucsd.edu');
INSERT INTO EMPLOY VALUES ('2022-02-28', 'information@whoi.edu', 'william.wilson@whoi.edu');
INSERT INTO EMPLOY VALUES ('2021-11-19', 'enquiries@bodc.ac.uk', 'olivia.white@bodc.ac.uk');
INSERT INTO EMPLOY VALUES ('2022-04-03', 'scrippsnews@ucsd.edu', 'james.brown@ucsd.edu');
INSERT INTO EMPLOY VALUES ('2021-09-18', 'outreach@noaa.gov', 'emma.martinez@noaa.gov');
INSERT INTO EMPLOY VALUES ('2022-05-12', 'information@whoi.edu', 'alexander.lopez@whoi.edu');
INSERT INTO EMPLOY VALUES ('2021-10-01', 'enquiries@bodc.ac.uk', 'mia.garcia@bodc.ac.uk');

-- Sample data for MEASUREMENT
-- Summary: store data for MEASUREMENT relation. It will store data related to oceanography, such as temperature, transmissivity, salinity, oxygen saturation, fluorescence, density, and pressure.
-- It also includes information about the date and time, the GPS coordinates, the operator who collect the data, and the equipment used to collect the data.  
-- Sample data for MEASUREMENT table
-- Sample data for MEASUREMENT table
INSERT INTO MEASUREMENT VALUES (15.20, 85.40, 35.60, 90.20, 5.80, 1020.40, 150.20, 34.343, 132.422, 'john.smith@noaa.gov', 1002, '2022-01-15 08:30:00');
INSERT INTO MEASUREMENT VALUES (17.80, 80.20, 33.70, 92.50, 6.40, 1019.80, 160.70, 59.9025, 10.7242, 'michael.davis@noaa.gov', 1002, '2022-02-20 12:45:00');
INSERT INTO MEASUREMENT VALUES (18.50, 75.60, 34.20, 91.80, 5.50, 1021.00, 155.30, 33.945, -118.4719, 'michael.davis@noaa.gov', 1003, '2022-03-10 14:15:00');
INSERT INTO MEASUREMENT VALUES (14.30, 88.00, 36.20, 89.70, 6.80, 1018.50, 140.80, 33.9514, -118.5184, 'emma.martinez@noaa.gov', 1004, '2022-04-05 10:00:00');
INSERT INTO MEASUREMENT VALUES (16.70, 82.10, 34.90, 91.20, 5.90, 1020.10, 148.60, 33.9432, -118.5439, 'john.smith@noaa.gov', 1004, '2022-05-12 16:30:00');
INSERT INTO MEASUREMENT VALUES (15.90, 85.00, 35.10, 90.60, 6.20, 1019.60, 157.20, 39.789, 116.2324, 'john.smith@noaa.gov', 1006, '2022-06-20 09:45:00');
INSERT INTO MEASUREMENT VALUES (16.80, 83.40, 34.50, 92.10, 5.30, 1021.30, 145.70, -33.8601, 151.2417, 'michael.davis@noaa.gov', 1008, '2022-07-03 11:20:00');
INSERT INTO MEASUREMENT VALUES (17.50, 79.80, 33.90, 91.60, 6.60, 1019.00, 152.40, -33.8567, 151.2363, 'emma.martinez@noaa.gov', 1008, '2022-08-15 13:10:00');
INSERT INTO MEASUREMENT VALUES (18.20, 76.20, 35.80, 90.90, 5.40, 1020.80, 158.90, -33.8626, 151.2357, 'emma.martinez@noaa.gov', 1008, '2022-09-22 08:00:00');
INSERT INTO MEASUREMENT VALUES (14.70, 87.50, 36.40, 89.50, 6.40, 1018.20, 143.90, -33.8627, 151.2448, 'emma.martinez@noaa.gov', 1010, '2022-10-10 15:45:00');

-- ***************************
-- Part B: End
-- ***************************


-- ***************************
-- Part C: Start
-- ***************************

-- SQL Query 1 
-- Purpose: Retrieve a list of all measurements, including the capturing operator and the equipment used.
-- Expected: A list of operators ordered by their first name in ascending order, 
-- along with details of the CTD equipment used for each measurement, and the corresponding GPS coordinates.
SELECT O.Fname, O.Minit, O.Lname,
       E.Ename AS 'Equipment Name', 
       M.Mtime AS 'Date Time', 
       M.LocateLati AS 'Latitude', M.LocateLong AS 'Longitude', 
       M.temperature, M.transmissivity, M.salinity, M.saturation, 
       M.florescence, M.density, M.pressure 
FROM MEASUREMENT M
JOIN OPERATOR O ON M.Mlog = O.Email
JOIN EQUIPMENT E ON M.Utilize = E.SKU
ORDER BY O.Fname;

-- SQL Query 2
-- Purpose: Retrieve the average CTD measurements for each equipment used in capturing CTD data points.
-- Expected: A list showing the average measurements for each equipment.
SELECT E.Ename AS 'Equipment Name',
       AVG(M.temperature) AS 'Average Temperature',
       AVG(M.transmissivity) AS 'Average Transmissivity',
       AVG(M.salinity) AS 'Average Salinity',
       AVG(M.saturation) AS 'Average Saturation',
       AVG(M.florescence) AS 'Average Florescence',
       AVG(M.density) AS 'Average Density',
       AVG(M.pressure) AS 'Average Pressure'
FROM MEASUREMENT M
JOIN EQUIPMENT E ON M.Utilize = E.SKU
GROUP BY E.Ename;

-- SQL Query 3
-- Purpose: Retrieve operators who have captured measurements with multiple equipment.
-- Expected: A list of operators along with the count of distinct equipment used by each operator.
SELECT CONCAT(O.Fname, ', ', O.Minit, ', ', O.Lname) AS 'Operator Name',
       (SELECT COUNT(DISTINCT M.Utilize)
        FROM MEASUREMENT M
        WHERE M.Mlog = O.Email) AS 'Distinct Equipment Count'
FROM OPERATOR O;

-- SQL Query 4
-- Purpose: Retrieve a list of all operators and their associated measurements, including those with no measurements and those with no associated operators.
-- Expected: A list showing all operators and their measurements, filling in NULLs where there are no matches.
SELECT O.Fname, O.Minit, O.Lname,
       M.Mtime, M.LocateLati, M.LocateLong,
       M.temperature, M.transmissivity, M.salinity, M.saturation,
       M.florescence, M.density, M.pressure
FROM OPERATOR O
LEFT JOIN MEASUREMENT M ON O.Email = M.Mlog
UNION
SELECT O.Fname, O.Minit, O.Lname,
       M.Mtime, M.LocateLati, M.LocateLong,
       M.temperature, M.transmissivity, M.salinity, M.saturation,
       M.florescence, M.density, M.pressure
FROM MEASUREMENT M
RIGHT JOIN OPERATOR O ON O.Email = M.Mlog
WHERE M.Mlog IS NULL;

-- SQL Query 5
-- Purpose: Retrieve a combined list of distinct emails and the corresponding names from the OPERATOR, ORGANIZATION, and MANUFACTURER relations.
-- Expected: A unified list of distinct emails with its corresponding associated name.
SELECT CONCAT(Fname, ', ', COALESCE(Minit, ''), ' ', Lname) AS 'Name', Email
FROM OPERATOR
UNION
SELECT Oname AS 'Name', Email
FROM ORGANIZATION
UNION
SELECT Mname AS 'Name', Email
FROM MANUFACTURER;

-- SQL Query 6
-- Purpose: Retrieve a list of organizations, operators, and their corresponding employed start dates.
-- Expected: A relation with columns for organization name, operator name, and the start date of employment.
SELECT O.Oname AS 'Organization Name', 
	   CONCAT(OP.Fname, ' ', COALESCE(OP.Minit, ''), ' ', OP.Lname) AS 'Operator Name',
       E.Edate AS 'Start Date'
FROM EMPLOY E 
JOIN ORGANIZATION O ON O.Email = E.Organization
JOIN OPERATOR OP ON E.Operator = OP.Email;

-- SQL Query 7
-- Purpose: Retrieve information about equipment and their corresponding manufacturers.
-- Expected: A relation with columns for equipment details and the associated manufacturer information.
SELECT 
    E.Ename AS 'Equipment Name',
    E.SKU AS 'Equipment SKU',
    M.Mname AS 'Manufacturer Name',
    M.Phone AS 'Manufacturer Phone',
    M.Email AS 'Manufacturer Email'
FROM EQUIPMENT E
JOIN MANUFACTURER M ON E.Produce = M.Email;

-- SQL Query 8
-- Purpose: Count the number of equipment produced by each manufacturer.
-- Expected: A relation with columns for manufacturer details and the count of equipment produced.
SELECT 
    M.Mname AS 'Manufacturer Name',
    M.Phone AS 'Manufacturer Phone',
    M.Email AS 'Manufacturer Email',
    COUNT(E.SKU) AS 'Number of Equipment Produced'
FROM MANUFACTURER M
LEFT JOIN EQUIPMENT E ON M.Email = E.Produce
GROUP BY M.Email;

-- SQL Query 9
-- Purpose: Count the number of employees working for each organization using three relations.
-- Expected: A relation with columns for organization details and the count of employees.
SELECT 
    O.Oname AS 'Organization Name',
    O.Website AS 'Organization Website',
    O.Email AS 'Organization Email',
    COUNT(E.Operator) AS 'Number of Employees'
FROM ORGANIZATION O
JOIN EMPLOY E ON O.Email = E.Organization
JOIN OPERATOR OP ON E.Operator = OP.Email
GROUP BY O.Email;

-- SQL Query 10
-- Purpose: Retrieve a list of operators who have experience in operating CTD equipment, 
-- along with details about the equipment manufacturer and the organization they are associated with.
-- Expected: A relation with columns for the manufacturer's name, organization name, 
-- and the names of operators who have experience in operating CTD equipment. 
-- Each operator is listed only once, even if they have operated multiple pieces of equipment.
SELECT MN.Mname AS 'Manufacturer Name',
       OGR.Oname AS 'Organization Name',
       CONCAT(Fname, ', ', COALESCE(Minit, ''), ' ', Lname) AS 'Operator Name'
FROM MEASUREMENT M
JOIN EQUIPMENT E ON M.Utilize = E.SKU
LEFT JOIN MANUFACTURER MN ON E.Produce = MN.Email
LEFT JOIN EMPLOY EM ON M.Mlog = EM.Operator
LEFT JOIN ORGANIZATION OGR ON EM.Organization = OGR.Email
LEFT JOIN OPERATOR O ON EM.Operator = O.Email
GROUP By O.Email;

-- ***************************
-- Part C: End
-- ***************************


-- End of Script (Nov 26, 2023)