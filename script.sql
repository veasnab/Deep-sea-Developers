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
        9. Click the "Go" button to import the script.sql file into the selected database.
    Please note that the import process may take some time depending on the size of your script.sql file. 
********************************
*/


-- ***************************
-- Part A: Start
-- ***************************
-- ADDRESS: stores information about different addresses, including the country or region, state or province, and street address.
CREATE TABLE ADDRESSES (
    country_or_region VARCHAR(50) NOT NULL,
    state_or_province VARCHAR(50) NOT NULL,
    street_address VARCHAR(100) DEFAULT NULL,
    address_id INT PRIMARY KEY NOT NULL
);
-- ORGANIZATION: stores information about different organizations, including their address, website, contact number, and contact email.
CREATE TABLE ORGANIZATION (
    address_id INT DEFAULT NULL,
    website VARCHAR(100),
    contact_number VARCHAR(20),
    contact_email VARCHAR(50),
    organization_id INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (address_id) REFERENCES ADDRESSES(address_id) ON DELETE SET DEFAULT
);
-- MANUFACTURER: stores data about different manufacturers, including their name, contact information, and the address they are associated with.
CREATE TABLE MANUFACTURER (
    address_id INT DEFAULT NULL,
    manufacturer_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    contact_email VARCHAR(50),
    manufacturer_id INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (address_id) REFERENCES ADDRESSES(address_id) ON DELETE SET DEFAULT
);
-- CTD_GPS: stores data about GPS coordinates and location information for CTD (Conductivity, Temperature, and Depth) measurements.
CREATE TABLE CTD_GPS (
    address_id INT DEFAULT NULL,
    latitude DECIMAL(9,6) CHECK (latitude >= -90 AND latitude <= 90),
    longitude DECIMAL(9,6) CHECK (longitude >= -180 AND longitude <= 180),
    location_name VARCHAR(100),
    gps_id INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (address_id) REFERENCES ADDRESSES(address_id) ON DELETE SET DEFAULT
);
-- CTD_DATA: stores various measurements related to oceanographic data, such as temperature, transmissivity, salinity, oxygen saturation, fluorescence, density, and pressure.
CREATE TABLE CTD_DATA (
    temperature DECIMAL(10,2),
    transmissivity DECIMAL(10,2),
    salinity DECIMAL(10,2),
    oxygen_saturation DECIMAL(10,2),
    florescence DECIMAL(10,2),
    density DECIMAL(10,2),
    pressure DECIMAL(10,2), 
    data_id INT PRIMARY KEY NOT NULL
);
-- CTD_OPERATOR: stores information about operators involved in CTD operations. It also includes a foreign key reference to the organization they belong to.
CREATE TABLE CTD_OPERATOR (
    organization_id INT NOT NULL,
    first_name VARCHAR(50),
    middle_name VARCHAR(50) NULL,
    last_name VARCHAR(50),
    operator_email VARCHAR(100),
    operator_id INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (organization_id) REFERENCES ORGANIZATION(organization_id) ON UPDATE CASCADE
);
-- CTD_EQUIPMENT: stores information about equipment used in CTD operations.
CREATE TABLE CTD_EQUIPMENT (
    manufacturer_id INT NOT NULL,
    registered_organization INT NOT NULL,
    equipment_name VARCHAR(100),
    equipment_id INT PRIMARY KEY NOT NULL,
    FOREIGN KEY (manufacturer_id) REFERENCES MANUFACTURER(manufacturer_id) ON UPDATE CASCADE,
    FOREIGN KEY (registered_organization) REFERENCES ORGANIZATION(organization_id) ON UPDATE CASCADE
);
-- CTD_LOG: stores log data related to CTD operations.
CREATE TABLE CTD_LOG (
    gps_id INT NOT NULL,
    equipment_id INT NOT NULL,
    operator_id INT NOT NULL,
    data_id INT NOT NULL,
    date_and_time TIMESTAMP WITH TIME ZONE NOT NULL,
    log_id INT PRIMARY KEY NOT NULL,
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
-- Sample data for Table_A
-- Summary: store data about A
-- INSERT INTO Table_A VALUES (...);
-- INSERT INTO Table_A VALUES (...);
-- Sample data for Table_B
-- Summary: store data about B
-- INSERT INTO Table_B VALUES (...);
-- INSERT INTO Table_B VALUES (...);
-- ***************************
-- Part B: End
-- ***************************


-- ***************************
-- Part C: Start
-- ***************************
-- Query 1
-- Purpose: determines the average
-- salary of engineers in TCSS Inc.
-- Expected: a table containing details for every engineer
-- in TCSS Inc. including difference of an
-- employee’s salary from average salary
-- SELECT A, B, C from A, B, C WHERE ...
-- ***************************
-- Query 2
-- Purpose: ...
-- Expected: ...
-- ...
-- ...
-- ***************************
-- Part C: End
-- ***************************


-- End of Script (Nov 2, 2023)
delete */