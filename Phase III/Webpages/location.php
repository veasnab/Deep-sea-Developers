<!-- TCSS445 : Autumn 2023 -->
<!-- @author: Miguel Ramos, Veasna Bun
@date: 11-22-23
@last revised date: 12-02-2023

This webpage serves as the frontend for a database that compiles CTD data across organizations. It's
purpose is to list all CTD data points taken at a chosen location.

-->
<?php require_once('config.php');?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CTD Database: Location</title>
        <!-- add a reference to the external stylesheet -->
        <link rel="stylesheet" href="https://bootswatch.com/4/solar/bootstrap.min.css">
        <link rel="icon" href="logo.png" type="image/x-icon">
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
                    <li class="nav-item">
                        <a class="nav-link" href="index.php">Home
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="operator.php">Operator</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="location.php">Location</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="equipment.php">Equipment</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="organization.php">Organization</a>
                    </li>
                </ul>
                <a class="navbar-brand">Miguel Veasna Makai Sunny</a>
            </div>
        </nav>
        <!-- END -- Add HTML code for the top menu section (navigation bar) -->
        <div class="jumbotron">
            <p class="lead">Select a location<p>
            <hr class="my-4">
            <form method="GET" action="location.php">
                <select name="loc" onchange='this.form.submit()'>
                    <option selected>location name</option>
                    <?php
                    $connection = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
                    if ( mysqli_connect_errno() )
                    {
                        die( mysqli_connect_error() );
                    }
                    // select all location name from the GPS relation and group them so they only show once.
                    $sql = "SELECT Gname FROM GPS GROUP BY Gname";
                    if ($result = mysqli_query($connection, $sql)) {
                        // loop through the data
                        while ($row = mysqli_fetch_assoc($result))
                        {
                            // Map the Gname as locations to the selected option display in the dropdown.
                            echo '<option value="' . $row['Gname'] . '">';
                            echo $row['Gname'];
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
                        // This SQL query retrieve measurement data and associated GPS information based on a specified location name.
                        // It join two relation: MEASUREMENT and GPS. Using the foreign key in MEASUREMENT relation {LocateLati, LocateLong}
                        // which map to the primary key in the GPS relation {Latitude, Longitude}.
                        // The recieve data is base on the selected location name,
                        // where the user have the option to select: WHERE G.Gname = '{$_GET['loc']}'"
                        $sql = "SELECT M.LocateLati, M.LocateLong, M.Mtime,
                                M.temperature, M.transmissivity, M.salinity, M.saturation,
                                M.florescence, M.density, M.pressure, G.Gname
                                FROM MEASUREMENT M
                                JOIN GPS G ON M.LocateLati = G.Latitude AND M.LocateLong = G.Longitude
                                WHERE G.Gname = '{$_GET['loc']}'";
                        if ($result = mysqli_query($connection, $sql))
                        {
                            while($row = mysqli_fetch_assoc($result))
                            {
                    ?>
                    <tr>
                        <td><?php echo $row['LocateLati'] ?></td>
                        <td><?php echo $row['LocateLong'] ?></td>
                        <td><?php echo $row['Mtime'] ?></td>
                        <td><?php echo $row['temperature'] ?></td>
                        <td><?php echo $row['transmissivity'] ?></td>
                        <td><?php echo $row['salinity'] ?></td>
                        <td><?php echo $row['saturation'] ?></td>
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
