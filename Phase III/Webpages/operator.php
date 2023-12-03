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
        <title>CTD Database: Operator</title>
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
                    <!-- set operators tab to active -->
                    <li class="nav-item active">
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
                </ul>
                <a class="navbar-brand">Miguel Veasna Makai Sunny</a>
            </div>
        </nav>
        <!-- END -- Add HTML code for the top menu section (navigation bar) -->
        <div class="jumbotron">
            <p class="lead">Select an operator<p>
            <hr class="my-4">
            <form method="GET" action="operator.php">
                <select name="op" onchange='this.form.submit()'>
                    <option selected>Select a name</option>
                    <!-- START -- PHP code for taking user input -->
                    <?php
                    $connection = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
                    if ( mysqli_connect_errno() )
                    {
                        die( mysqli_connect_error() );
                    }
                    // select all column from the OPERATOR relation
                    $sql = "SELECT * FROM OPERATOR";
                    if ($result = mysqli_query($connection, $sql))
                    {
                        // loop through the data
                        while($row = mysqli_fetch_assoc($result))
                        {
                            // Map the Primary key "email" to the selected option display in the dropdown: first name, middle inits last name.
                            echo '<option value="' . $row['Email'] . '">';
                            echo $row['Fname']. ', '. $row['Minit']. ' '. $row['Lname'];
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
                    if (isset($_GET['op']) )
                    {
                ?>
                <p>&nbsp;</p>
                <table class="table table-hover">
                    <thead>
                        <tr class="table-success">
                            <th scope="col">Operator Name</th>
                            <th scope="col">Employer</th>
                            <th scope="col">Start Date</th>
                            <th scope="col">Year of Employment</th>
                        </tr>
                    </thead>
                    <?php
                        if ( mysqli_connect_errno() )
                        {
                            die( mysqli_connect_error() );
                        }
                        // This SQL query retrieves information about an operator and their employment details,
                        // including the organization name, operator's full name, employment start date, and
                        // the number of years they have been employed.
                        // It JOIN three relation: ORGANIZATION, EMPLOY, AND OPERATOR.
                        // Using the foreign key from the EMPLOY relation to their respect PRIMARY KEY in the ORGRANIZATION and OPERATOR relation.
                        // The number of year an operator of employment is calculated by YEAR(CURDATE()) - YEAR(E.Edate).
                        // The recieve data is base on the select operator name,
                        // where the user have the option to select: WHERE OP.Email = '{$_GET['op']}'"
                        $sql = "SELECT O.Oname AS 'Organization',
                                CONCAT(OP.Fname, ' ', COALESCE(OP.Minit, ''), ' ', OP.Lname) AS 'Operator',
                                E.Edate AS 'Date',
                                YEAR(CURDATE()) - YEAR(E.Edate) AS 'Year'
                                FROM EMPLOY E
                                JOIN ORGANIZATION O ON O.Email = E.Organization
                                JOIN OPERATOR OP ON E.Operator = OP.Email
                                WHERE OP.Email = '{$_GET['op']}';";

                        if ($result = mysqli_query($connection, $sql))
                        {
                            while($row = mysqli_fetch_assoc($result))
                            {
                    ?>
                    <tr>
                        <td><?php echo $row['Operator'] ?></td>
                        <td><?php echo $row['Organization'] ?></td>
                        <td><?php echo $row['Date'] ?></td>
                        <td><?php echo $row['Year'] ?></td>
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
    </body>
</html>
