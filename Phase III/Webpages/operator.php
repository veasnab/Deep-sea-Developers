<!-- TCSS445 : Autumn 2023 -->
<!-- @author: Miguel Ramos
@date 11-22-23

This webpage serves as a piece of the frontend for a database that compiles CTD data across organizations. It's
purpose is to list data about all registered CTD operators.
-->
<?php require_once('config.php');?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deep Sea Developers</title>
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
                    <li class="nav-item">
                        <a class="nav-link" href="index.php">Home
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    <!-- set operators tab to active -->
                    <li class="nav-item active">
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
                    $sql = "SELECT * From CTD.CTD_OPERATOR";
                    if ($result = mysqli_query($connection, $sql))
                    {
                        // loop through the data
                        while($row = mysqli_fetch_assoc($result))
                        {
                            echo '<option value="' . $row['operator_id'] . '">';
                            echo $row['last_name']. ', '. $row['first_name'];
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
                            <th scope="col">Last Name</th>
                            <th scope="col">Middle Initial</th>
                            <th scope="col">First Name</th>
                            <th scope="col">Registered Organization</th>
                            <th scope="col">Data Points Logged</th>
                        </tr>
                    </thead>
                    <?php
                        if ( mysqli_connect_errno() )
                        {
                            die( mysqli_connect_error() );
                        }
                        $sql = "SELECT CTD_OPERATOR.first_name,
                                       CASE WHEN CTD_OPERATOR.middle_name IS NULL THEN 'N/A'
                              		        ELSE CTD_OPERATOR.middle_name
                                       END AS middle_name,
	                                   CTD_OPERATOR.last_name,
	                                   ORGANIZATION.website,
                                       (SELECT COUNT(operator_id) FROM CTD_LOG WHERE operator_id = {$_GET['op']}) AS Records
                                FROM ORGANIZATION
                                JOIN CTD_OPERATOR ON ORGANIZATION.organization_id = CTD_OPERATOR.organization_id
                                WHERE CTD_OPERATOR.operator_id = {$_GET['op']}
                                GROUP BY first_name, last_name;";
                        if ($result = mysqli_query($connection, $sql))
                        {
                            while($row = mysqli_fetch_assoc($result))
                            {
                    ?>
                    <tr>
                        <td><?php echo $row['first_name'] ?></td>
                        <td><?php echo $row['middle_name'] ?></td>
                        <td><?php echo $row['last_name'] ?></td>
                        <td><?php echo $row['website'] ?></td>
                        <td><?php echo $row['Records'] ?></td>
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