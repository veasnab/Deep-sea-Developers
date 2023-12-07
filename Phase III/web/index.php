<!-- TCSS445 : Autumn 2023 -->
<!-- @author: Miguel Ramos, Veasna Bun
@date 11-26-23
@last revised date: 12-02-2023

This webpage serves as the frontend for a database that compiles CTD data across organizations. It's
purpose is to serve as a homepage for this frontend website.

-->
<?php require_once('config.php');?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CTD Database: Home</title>
        <!-- add a reference to the external stylesheet -->
        <link rel="stylesheet" href="https://bootswatch.com/4/solar/bootstrap.min.css">
        <link rel="icon" href="logo.png" type="image/x-icon">
        <style>
            .team {
                max-width: 100%;
                background: #073642;
                text-align: center;
            }
            img {
                border-radius: 50%;
                max-width: 150px;
                margin-bottom: 10px;
            }
            .content-container p {
                margin-left: 23%;
                margin-right: 23%;
            }
            h2 {
                text-align: center;
            }
            table {
                display: flex;
                justify-content: center;
            }
            td {
                padding-right: 10px;
                padding-left: 10px;
            }
        </style>
    </head>
    <body>
        <!-- START -- Add HTML code for the top menu section (navigation bar) -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand">Deep Sea Developers</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-
                    controls="navbarColor02" aria-expanded="true" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor02">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="index.php">Home
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="operator.php">Operator</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="location.php">Location</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="equipment.php">Equipment</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="organization.php">Organization</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="manufacturer.php">Manufacturer</a>
                     </li>
                </ul>
                <a class="navbar-brand">Miguel Veasna Makai Sunny</a>
            </div>
        </nav>
        <!-- END -- Add HTML code for the top menu section (navigation bar) -->
        <div class="team">
            <h1>Deep Sea Developers</h1>
            <img src="logo.png" alt="logo">
            <p> "A CTD Database. We're going ocean!" </p>
        </div>
        <div class="content-container">
            <div class = "overview">
                <h2>Overview</h2>
                <p>
                    Welcome to the Deep Sea Developer webpage! This project was created by students enrolled in the 
                    TCSS445 Database and System class of Fall 2023 at the University of Washington Tacoma. We were motivated 
                    by our passion for oceanography and the desire to contribute to the field. Our goal is to address the 
                    challenges faced by oceanographers in accessing and managing Conductivity, Temperature, Depth (CTD) data. 
                    With our knowledge of database implementation and theory, we aim to provide a scalable and user-friendly solution.
                </p>
            </div>
            <div class = "description">
                <h2>Description</h2>
                <p>
                    In this project, we deployed and hosted the webpage on the Google Cloud Platform using a Linux VM. 
                    We also connected it to a CTD (MySQL) database. The web interface, crafted using PHP, interacts with the CTD database. 
                    You can explore the different tabs on our website - Operator, Location, Equipment, Organization, and Manufacturer. 
                    Each tab provides a unique way for users to engage with our CTD database.
                </p>
            </div>
            <div class = "contact">
                <h2>Team Members' Contact Information</h2>
                <table>
                    <tr>
                        <td>Sunny Ali</td>
                        <td>hassanli@uw.edu</td>
                    </tr>
                    <tr>
                        <td>Makai Martinez</td>
                        <td>mlm1738@uw.edu</td>
                    </tr>
                    <tr>
                        <td>Miguel Ramos</td>
                        <td>ramosmig@uw.edu</td>
                    </tr>
                    <tr>
                        <td>Veasna Bun</td>
                        <td>veasnab@uw.edu</td>
                    </tr>
                </table>
            </div>
            <!-- jQuery and Popper.js -->
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
            <!-- Bootstrap JS -->
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
            </body>
