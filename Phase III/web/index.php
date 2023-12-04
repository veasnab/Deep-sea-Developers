<!-- TCSS445 : Autumn 2023 -->
<!-- @author: Miguel Ramos
@date 11-26-23

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
            .content-container {
                max-width: 100%;
                margin: 500px;
                margin-top: 20px;
                margin-bottom: 0px;
            }
            .team {
                max-width: 100%;
                background: #073642;
                text-align: center;
            }
            .contact {
                text-align: center;
            }
            img {
                border-radius: 50%;
                max-width: 150px;
                margin-bottom: 10px;
            }
        </style>
    </head>
    <body>
        <!-- START -- Add HTML code for the top menu section (navigation bar) -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Deep Sea Developers</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-
                    controls="navbarColor02" aria-expanded="false" aria-label="Toggle navigation">
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
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="organization.php">Organization</a>
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
                <h2>Project Overview</h2>
                <p>
                    
                </p>
            </div>
            <div class = "description">
                <h2>Project Description</h2>
                <p>
                    
                </p>
            </div>
            <div class = "contact">
                <hr>
                <h2>Team Members' Contact Information</h2>
                <p>Sunny Ali | hassanli@uw.edu <br>
                   Makai Martinez | mlm1738@uw.edu<br>
                   Miguel Ramos | ramosmig@uw.edu<br>
                   Veasna Bun | veasnab@uw.edu
                </p>
            </div>
        </hr>
    </body>
