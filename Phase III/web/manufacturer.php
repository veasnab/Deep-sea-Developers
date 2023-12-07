<!-- TCSS445 : Autumn 2023 -->
<!-- @author: Makai Martinez
12-6-2023

This webpage serves as a piece of the frontend for a database that compiles CTD data across organizations. It's
purpose is to list data about all registered CTD Manufacturers.
-->
<?php require_once('config.php');?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CTD Database: Manufacturer</title>
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
                        <a class="nav-link" href="index.php">Home</a>
                    </li>
                    <!-- set Manufacturers tab to active -->
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
                    <li class="nav-item active">
                        <a class="nav-link" href="manufacturer.php">Manufacturer
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>

                </ul>
                <a class="navbar-brand">Miguel Veasna Makai Sunny</a>
            </div>
        </nav>
        <!-- END -- Add HTML code for the top menu section (navigation bar) -->
        <!-- START -- code for listing info-->
        <div class="jumbotron">
            <p class="lead">Select a manufacturer's Email<p>
            <hr class="my-4">
            <form method="GET" action="manufacturer.php">
                <select name="mu" onchange='this.form.submit()'>
                    <option selected>Select an Email</option>
                    <!-- START -- PHP code for taking user input -->
                    <?php
                    $connection = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
                    if ( mysqli_connect_errno() )
                    {
                        die( mysqli_connect_error() );
                    }
                    // select the manufacturer Email from the MANUFACTURER relation
                    $sql = "SELECT Email FROM MANUFACTURER";
                    if ($result = mysqli_query($connection, $sql))
                    {
                        // loop through the data
                        while($row = mysqli_fetch_assoc($result))
                        {
                            // Map the Primary key "email" to the selected option display in the dropdown.
                            echo '<option value="' . $row['Email'] . '">';
                            echo  $row['Email'];
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
                    if (isset($_GET['mu']) )
                    {
                ?>
                <p>&nbsp;</p>
                <table class="table table-hover">
                    <thead>
                        <tr class="table-success">
                            <th scope="col">Manufacturer Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Active CTD's</th>
                        </tr>
                    </thead>
                    <?php
                        if ( mysqli_connect_errno() )
                        {
                            die( mysqli_connect_error() );
                        }
                        // This SQL query retrieves details about manufacturer and their number of active CTDs.
                        // It calculates the count of SKU's linked to a manufacturer based on the manufacturer Email.
                        // The details of the manufacturer include name, phone, and email.
                        // The query uses a LEFT JOIN between the MANUFACTURER and EQUIPMENT tables, linking them via the 'Email' and 'produce' columns, respectively.
                        // The result is grouped by the manufacturer Email. Used a left join because some manufacturers dont have active equipment.
                        // Users can specify the manufacturer Email through the GET parameter {$_GET['mu']}.
                        $sql = "SELECT Mname, Email, COALESCE(Phone, 'NULL')  AS 'phonenum', COUNT(SKU) AS ActiveCTD
                                FROM MANUFACTURER Left JOIN EQUIPMENT ON MANUFACTURER.Email = EQUIPMENT.Produce
                                WHERE Email = '{$_GET['mu']}'
                                GROUP BY Email";

                        if ($result = mysqli_query($connection, $sql))
                        {
                            while($row = mysqli_fetch_assoc($result))
                            {
                    ?>
                    <tr>
                        <td><?php echo $row['Mname'] ?></td>
                        <td><?php echo $row['Email'] ?></td>
                        <td><?php echo $row['phonenum'] ?></td>
                        <td><?php echo $row['ActiveCTD'] ?></td>
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
