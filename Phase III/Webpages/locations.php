<!-- TCSS445 : Autumn 2023 -->
<!-- @author: Miguel Ramos
@date 11-26-23

This webpage serves as the frontend for a database that compiles CTD data across organizations. It's
purpose is to list all CTD data points taken at a chosen location.

-->
<?php require_once('config.php');?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assignment 4 Demo</title>
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
            <p class="lead">Select a location<p>
            <hr class="my-4">
            <form method="GET" action="locations.php">
                <select name="loc" onchange='this.form.submit()'>
                    <option selected>location name</option>
                    <?php
                    $connection = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
                    if ( mysqli_connect_errno() )
                    {
                        die( mysqli_connect_error() );
                    }
                    $sql = "SELECT * From CTD.CTD_GPS GROUP BY location_name";
                    if ($result = mysqli_query($connection, $sql))
                    {
                        // loop through the data
                        while($row = mysqli_fetch_assoc($result))
                        {
                            echo '<option value="' . $row['location_name'] . '">';
                            echo $row['location_name'];
                            echo "</option>";
                        }
                        // release the memory used by the result set
                        mysqli_free_result($result);
                    }
                    ?>
                </select>
                <?php
                if ($_SERVER["REQUEST_METHOD"] == "GET")
                {
                    if (isset($_GET['loc']) )
                    {
                ?>
                <p>&nbsp;</p>
                <table class="table table-hover">
                    <thead>
                        <tr class="table-success">
                            <th scope="col">Latitude</th>
                            <th scope="col">Longitude</th>
                            <th scope="col">Timestamp</th>
                            <th scope="col">Temperature</th>
                            <th scope="col">Transmissivity</th>
                            <th scope="col">Salinity</th>
                            <th scope="col">O. Saturation</th>
                            <th scope="col">Fluorescence</th>
                            <th scope="col">Density</th>
                            <th scope="col">Pressure</th>
                        </tr>
                    </thead>
                    <?php
                        if ( mysqli_connect_errno() )
                        {
                            die( mysqli_connect_error() );
                        }
                        //query the database
                        $sql = "SELECT CTD_GPS.latitude,
		                        CTD_GPS.longitude,
                                CTD_LOG.date_and_time,
                                CTD_DATA.temperature,
                                CTD_DATA.transmissivity,
                                CTD_DATA.salinity,
                                CTD_DATA.oxygen_saturation,
                                CTD_DATA.florescence,
                                CTD_DATA.density,
                                CTD_DATA.pressure
                                FROM CTD_LOG JOIN CTD_DATA ON CTD_LOG.data_id = CTD_DATA.data_id
                                JOIN CTD_GPS ON (CTD_GPS.gps_id = CTD_LOG.gps_id AND CTD_GPS.location_name = '{$_GET['loc']}');";
                        if ($result = mysqli_query($connection, $sql))
                        {
                            while($row = mysqli_fetch_assoc($result))
                            {
                    ?>
                    <tr>
                        <td><?php echo $row['latitude'] ?></td>
                        <td><?php echo $row['longitude'] ?></td>
                        <td><?php echo $row['date_and_time'] ?></td>
                        <td><?php echo $row['temperature'] ?></td>
                        <td><?php echo $row['transmissivity'] ?></td>
                        <td><?php echo $row['salinity'] ?></td>
                        <td><?php echo $row['oxygen_saturation'] ?></td>
                        <td><?php echo $row['florescence'] ?></td>
                        <td><?php echo $row['density'] ?></td>
                        <td><?php echo $row['pressure'] ?></td>
                    </tr>
                    <?php
                            }
                            // release the memory used by the result set
                            mysqli_free_result($result);
                        }
                    } // end if (isset)
                } // end if ($_SERVER)
                    ?>
                </table>
            </form>

        </div>
    </body>
</html>