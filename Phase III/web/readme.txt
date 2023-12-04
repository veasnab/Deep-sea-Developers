- Getting Started:
    These instructions will help you set up and run the project on your local machine.

- Prerequisites:
    Before you begin, ensure you have the following installed on your machine:

    XAMPP - A free and open-source cross-platform web server solution stack package.
    XAMPP: is a software stack that is supported by multiple operating systems (Windows, Linux, and OS X) for running a web development environment locally on your laptops/PCs. 
    This software stack contains all the necessary tools such as PHP, phpMyAdmin, Apache web server, MySQL, among others.

    Part A - Installation: XAMPP

        1. Go to the official XAMPP website: [https://www.apachefriends.org/index.html]
        2. Download the appropriate version for your operating system (Windows, macOS, or Linux).
        3. Once the download is complete, run the installer.
        4. Follow the installation wizard, selecting the components you want to install (e.g., Apache, MySQL, PHP, etc.).
        5. Choose the installation directory and complete the installation process (My chosen directory is the root of my C drive, i.e., "C:").
        6. After installation, you can start XAMPP and access the control panel to manage your web server and database.

    Part B - Download the appropriate file from our GitHub: [https://github.com/veasnab/Deep-sea-Developers]

        1. In the window, open up the terminal and navigate to the directory using the "cd" command you wish to download the repo from our GitHub.
           (Example: cd \Users\'username'\Downloads) This will take me to the download folder on my C: drive.
        2. Once you are in the desired directory, use the following command in the terminal: git clone https://github.com/veasnab/Deep-sea-Developers.git
           The downloaded files should now be in the chosen directory with the folder name "Deep-sea-Developers".
        3. Navigate through the "Deep-sea-Developers" and find the "Phase III". Everything in this folder will be needed later to run the project.

    Part C - Setting Up: MySQL Database (You will need the queries.sql file for this part. This is found in the "Phase III" folder that was downloaded.)

        1. Open XAMPP and start the Apache and MySQL services.
        2. Open your web browser and navigate to [http://localhost/phpmyadmin].
        3. Log in to phpMyAdmin using your username and password (if needed).
        4. Create a new database where you want to import the queries.sql file. Click on "New" in the left sidebar, enter a database name, and click "Create".
        5. Select the newly created database from the left sidebar.
        6. Click on the "Import" tab at the top of the page.
        7. Click on the "Choose File" button and locate your script.sql file on your computer.
        8. Make sure the "SQL" format is selected.
        9. Click the "Import"/"Go" button to import the queries.sql file into the selected database.

    Part D - Setting Up: User Account Database

        1. On the web browser [http://localhost/phpmyadmin], on the top menu, click on the tab "User accounts".
        2. Locate and click on the hyperlink "Add user account".
        3. In the "Login Information" section fill in the following with:
           - User name: testuser
           - Password: mypassword
           - Re-type: mypassword
        4. Locate the "Global privileges" section and check the box "Check all".
        5. Click the "Go" button at the bottom of the web browser.

    Part E - Setting Up: Web Application on XAMPP

        1. Locate the directory where you installed XAMPP (My chosen directory is the root of my C drive, i.e., "C:").
        2. Navigate to the "xampp" folder and open up the folder.
        3. Once the xampp directory is located, find the "htdocs" folder and open up this folder (The following is the directory I am in: C:\xampp\htdocs).
        4. Locate the file that was downloaded from our GitHub with the folder name "Phase III".
        5. In the "Phase III" folder, locate and move the folder called "web" to the "htdocs" folder.

    Part F: Project

        1. Once parts A - E are completed, you should now be able to view our project locally on a web browser.
        2. Open up a web browser and navigate to the user [http://localhost/web/].
