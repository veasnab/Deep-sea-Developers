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
        <title>CTD Database</title>
        <!-- add a reference to the external stylesheet -->
        <link rel="stylesheet" href="https://bootswatch.com/4/solar/bootstrap.min.css">
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
                        <a class="nav-link" href="operator.php">Operators</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="locations.php">Locations</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="organizations.php">Organizations</a>
                    </li>

                </ul>
                <a class="navbar-brand">Miguel Veasna Makai Sunny</a>
            </div>
        </nav>
        <!-- END -- Add HTML code for the top menu section (navigation bar) -->
        <div class="jumbotron">
            <p class="lead">We're going ocean!<p>
            <hr class="my-4">
        </div>
    </body>