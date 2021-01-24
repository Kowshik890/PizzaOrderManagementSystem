<?php require_once '../conn.php';?>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <title>Pizza Ordering System</title>
    </head>
    <body> 

    <?php
        $single_row = null;

        //fetching all pizza for showing base pizza in user UI
        $sql = "SELECT * FROM fetch_all_pizza()";
        $pizza_list = pg_query($db, $sql);

        //fetching all available ingredients to show the ingredients detail in user UI
        $sql_ing = "SELECT * FROM fetch_available_ingredient()";
        $ava_ingredient_list = pg_query($db, $sql_ing);

    ?>
        <div class="container">
            <h1 style="text-align: center">Welcome To Pizza Ordering System</h1>
            <div class="col-md-12" style="margin: 10px; width: 100%; height: 340px; border: 2px solid black; float: left">
                <div class="col-md-5" style="float: left;">
                    <div class="row" style="text-align: center"><h3><u>List of Base Pizza</u></h3></div>
                    <table class="table table-striped">
                        <tr>
                            <th> <font face="Arial">Checked</font> </th>
                            <th> <font face="Arial">Pizza Size</font> </th>
                            <th> <font face="Arial">Price</font> </th>
                        </tr>
                        <?php while ($row = pg_fetch_assoc($pizza_list)) { ?>
                        <form method="post">
                            <tr>
                                <td><input type="checkbox" id="checked_pizza" name="checked_pizza"
                                    value="<?php echo $row["id"]; ?>"></td>
                                <td><?php echo $row["size"]; ?></td>
                                <td><?php echo $row["price"]; ?></td>
                            </tr>
                        </form>
                        <?php } ?>
                    </table>
                </div>
                <div class="col-md-7" style="float: left; border-left: 2px solid black; padding: 2px">
                    <div class="row" style="text-align: center"><h3><u>List of Ingredients</u></h3></div>
                    <table class="table table-striped">
                        <tr>
                            <th> <font face="Arial">Checked</font> </th>
                            <th> <font face="Arial">Ingredient Name</font> </th>
                            <th> <font face="Arial">Regional Provenance</font> </th>
                            <th> <font face="Arial">Price per Quantity</font> </th>
                            <th> <font face="Arial">Quantity</font> </th>
                            <th> <font face="Arial">Summation</font> </th>
                        </tr>
                        <?php while ($row = pg_fetch_assoc($ava_ingredient_list)) { ?>
                        <form method="post">
                            <tr>
                                <td><input type="checkbox" id="checked_ingredient" name="checked_ingredient"
                                    value="<?php echo $row["id"]; ?>"></td>
                                <td><?php echo $row["name"]; ?></td>
                                <td><?php echo $row["province"]; ?></td>
                                <td><?php echo $row["price"]; ?></td>
                                <td><input type="text" class="form-control" id="quantity" name="quantity"
                                     placeholder="Enter Quantity"></td>
                                <td><input type="text" class="form-control" id="quantity" name="quantity" readonly></td>
                            </tr>
                        </form>
                        <?php } ?>
                    </table>
                </div>
                <div class="col-md-12" style="margin: 10px; float: left; text-align: center">
                    <button type="submit" class="btn btn-primary"
                        name="submit">Order Now</button>
            </div>
            </div>
        </div>
    </body>

</html>