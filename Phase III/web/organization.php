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
        <title>CTD Database: Organization</title>
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
                    <li class="nav-item">
                        <a class="nav-link" href="equipment.php">Equipment</a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="organization.php">Organization</a>
                    </li>
                </ul>
                <a class="navbar-brand">Miguel Veasna Makai Sunny</a>
            </div>
        </nav>
        <!-- END -- Add HTML code for the top menu section (navigation bar) -->
        <div class="jumbotron">
            <p class="lead">Select a Organization<p>
            <hr class="my-4">
            <form method="GET" action="organization.php">
                <select name="org" onchange='this.form.submit()'>
                    <option selected>Select a name</option>
                    <!-- START -- PHP code for taking user input -->
                    <?php
                    $connection = mysqli_connect(DBHOST, DBUSER, DBPASS, DBNAME);
                    if ( mysqli_connect_errno() )
                    {
                        die( mysqli_connect_error() );
                    }
                    // select name of the organization from the ORGANIZATION relation and group them so they one appear once.
                    $sql = "SELECT Oname FROM ORGANIZATION GROUP by Oname";
                    if ($result = mysqli_query($connection, $sql))
                    {
                        // loop through the data
                        while($row = mysqli_fetch_assoc($result))
                        {
                            // Map the "Oname" orgainzation name to the selected option display in the dropdown.
                            echo '<option value="' . $row['Oname'] . '">';
                            echo  $row['Oname'];
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
                    if (isset($_GET['org']) )
                    {
                ?>
                <p>&nbsp;</p>
                <table class="table table-hover">
                    <thead>
                        <tr class="table-success">
                            <th scope="col">Organization Name</th>
                            <th scope="col">Website</th>
                            <th scope="col">Contact Phone Number</th>
                            <th scope="col">Contact Email</th>
                            <th scope="col">Number of Employee</th>
                        </tr>
                    </thead>
                    <?php
                        if ( mysqli_connect_errno() )
                        {
                            die( mysqli_connect_error() );
                        }
                            // This SQL query retrieves information about an organization and the number of operators employed by the organization.
                            // It includes the organization name, website, phone, email, and the count of operators.
                            // The query utilizes a LEFT JOIN between the ORGANIZATION and EMPLOY tables, linking them via the Email and Organization columns, respectively.
                            // The COALESCE function is employed to handle potential NULL values in the organization's website, phone, and email, replacing them with the string 'NULL'.
                            // The result is grouped by the organization's email.
                            // Users can specify the organization name through the GET parameter {$_GET['org']}.
                        $sql = "SELECT O.Oname, COALESCE(O.Website, 'NULL') AS Website, COALESCE(O.Phone, 'NULL') AS Phone,
                                COALESCE(O.Email, 'NULL') AS Email, COUNT(E.Operator) AS 'Count'
                                FROM ORGANIZATION O
                                LEFT JOIN EMPLOY E ON O.Email = E.Organization
                                WHERE O.Oname = '{$_GET['org']}'
                                GROUP BY O.Email;";

                        if ($result = mysqli_query($connection, $sql))
                        {
                            while($row = mysqli_fetch_assoc($result))
                            {
                    ?>
                        <tr>
                            <td><?php echo $row['Oname'] ?></td>
                            <td>
                                <?php
                                if ($row['Website'] !== 'NULL') {
                                    echo '<a href="' . 'http://' . $row['Website'] . '" target="_blank">' . $row['Website'] . '</a>';
                                } else {
                                    echo 'NULL';
                                }
                                ?>
                                
                            </td>
                            <td><?php echo $row['Phone'] ?></td>
                            <td><?php echo $row['Email'] ?></td>
                            <td><?php echo $row['Count'] ?></td>
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
