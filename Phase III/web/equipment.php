<!-- TCSS445 : Autumn 2023 -->
<!-- @author: Miguel Ramos, Veasna Bun
date: 11-22-23
@last revised date: 12-02-2023

This webpage serves as a piece of the frontend for a database that compiles CTD data across organizations. It's
purpose is to list data about all registered CTD operators.
-->
<?php require_once('config.php');?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CTD Database: Equipment</title>
        <!-- add a reference to the external stylesheet -->
        <link rel="stylesheet" href="https://bootswatch.com/4/solar/bootstrap.min.css">
        <link rel="icon" href="logo.png" type="image/x-icon">
    </head>
    <body>
        <!-- START -- Add HTML code for the top menu section (navigation bar) -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">Deep Sea Developers</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor02" aria-
                    controls="navbarColor02" aria-expanded="true" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarColor02">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="index.php">Home
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <!-- set operators tab to active -->
                    <li class="nav-item">
                        <a class="nav-link" href="operator.php">Operator</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="location.php">Location</a>
                    </li>
                    <li class="nav-item active">
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
            <p class="lead">Select an equipment sku#<p>
            <hr class="my-4">
            <form method="GET" action="equipment.php">
                <select name="eq" onchange='this.form.submit()'>
                    <option selected>Select a name</option>
                    <!-- START -- PHP code for taking user input -->
                    <?php
                    $connection = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
                    if ( mysqli_connect_errno() )
                    {
                        die( mysqli_connect_error() );
                    }
                    // select the equipment and its sku from the EQUIPMENT relation
                    $sql = "SELECT Ename, SKU FROM EQUIPMENT";
                    if ($result = mysqli_query($connection, $sql))
                    {
                        // loop through the data
                        while($row = mysqli_fetch_assoc($result))
                        {
                            // Map the Primary key "SKU" to the selected option display in the dropdown.
                            echo '<option value="' . $row['SKU'] . '">';
                            echo  $row['SKU'];
                            echo "</option>";
                        }
                        // release the memory used by the result set
                        mysqli_free_result($result);
                    }
                    ?>
                    <!-- END -- PHP code for taking user input -->
                </select>
                <!-- START -- PHP code for fetching and displaying result of user input -->
                <?php
                if ($_SERVER["REQUEST_METHOD"] == "GET")
                {
                    if (isset($_GET['eq']) )
                    {
                ?>
                <p>&nbsp;</p>
                <table class="table table-hover">
                    <thead>
                        <tr class="table-success">
                            <th scope="col">Equipment Name</th>
                            <th scope="col">Average Temperature</th>
                            <th scope="col">Average Transmissivity</th>
                            <th scope="col">Average Salinity</th>
                            <th scope="col">Average Saturation</th>
                            <th scope="col">Average Florescence</th>
                            <th scope="col">Average Density</th>
                            <th scope="col">Average Pressure</th>
                        </tr>
                    </thead>
                    <?php
                        if ( mysqli_connect_errno() )
                        {
                            die( mysqli_connect_error() );
                        }
                        // This SQL query retrieves information about equipment and their associated measurement details.
                        // It calculates the average values of various measurements for a specific equipment based on the equipment SKU.
                        // The measurements include temperature, transmissivity, salinity, saturation, florescence, density, and pressure.
                        // The query uses a LEFT JOIN between the EQUIPMENT and MEASUREMENT tables, linking them via the Utilize and SKU columns, respectively.
                        // The COALESCE function is used to handle potential NULL values in the average calculations and replaces them with the string 'NULL'.
                        // The result is grouped by the equipment SKU.
                        // Users can specify the equipment SKU through the GET parameter {$_GET['op']}.
                        $sql = "SELECT E.Ename,
                                COALESCE(AVG(M.temperature), 'NULL') AS 'avgtemp',
                                COALESCE(AVG(M.transmissivity), 'NULL') AS 'avgtran',
                                COALESCE(AVG(M.salinity), 'NULL') AS 'avgsal',
                                COALESCE(AVG(M.saturation), 'NULL') AS 'avgsat',
                                COALESCE(AVG(M.florescence), 'NULL') AS 'avgflo',
                                COALESCE(AVG(M.density), 'NULL') AS 'avgden',
                                COALESCE(AVG(M.pressure), 'NULL') AS 'avgpre'
                                FROM EQUIPMENT E
                                LEFT JOIN MEASUREMENT M ON M.Utilize = E.SKU
                                WHERE E.SKU = {$_GET['eq']}
                                GROUP BY E.SKU;";

                        if ($result = mysqli_query($connection, $sql))
                        {
                            while($row = mysqli_fetch_assoc($result))
                            {
                    ?>
                    <tr>
                        <td><?php echo $row['Ename'] ?></td>
                        <td><?php echo $row['avgtemp'] ?></td>
                        <td><?php echo $row['avgtran'] ?></td>
                        <td><?php echo $row['avgsal'] ?></td>
                        <td><?php echo $row['avgsat'] ?></td>
                        <td><?php echo $row['avgflo'] ?></td>
                        <td><?php echo $row['avgden'] ?></td>
                        <td><?php echo $row['avgpre'] ?></td>
                    </tr>
                    <?php
                            }
                            // release the memory used by the result set
                            mysqli_free_result($result);
                        }
                    } // end if (isset)
                } // end if ($_SERVER)
                    ?>
                    <!-- END -- PHP code for fetching and displaying result of user input -->
                </table>
            </form>
        </div>
        <!-- jQuery and Popper.js -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <!-- Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </body>
</html>
