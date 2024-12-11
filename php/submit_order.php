<?php
session_start();

// Enable error reporting for debugging
ini_set('display_errors', 1);
error_reporting(E_ALL);

// Replace with your RDS database credentials
$servername = "csicg4.czptxhzjxjrt.us-east-1.rds.amazonaws.com";
$username = "group4";
$password = "Groupfour";
$dbname = "ice_shop";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    echo json_encode(['success' => false, 'message' => 'Database connection failed: ' . $conn->connect_error]);
    exit;
}

// Validate input
if (isset($_POST['name'], $_POST['phone'], $_POST['cart'], $_POST['grandTotal'])) {
    $name = $conn->real_escape_string($_POST['name']);
    $phone = $conn->real_escape_string($_POST['phone']);
    $cart = json_decode($_POST['cart'], true);
    $grandTotal = (float)$_POST['grandTotal']; // Ensure it's a float

    if (!$cart || !is_array($cart)) {
        echo json_encode(['success' => false, 'message' => 'Invalid cart data.']);
        exit;
    }

    try {
        // Start transaction
        $conn->begin_transaction();

        // Insert customer details
        $stmt = $conn->prepare("INSERT INTO customers (name, contact) VALUES (?, ?)");
        $stmt->bind_param("ss", $name, $phone);
        $stmt->execute();
        $customer_id = $stmt->insert_id;

        // Insert order details
        $stmt = $conn->prepare("INSERT INTO orders (customer_id, order_date, total_price) VALUES (?, NOW(), ?)");
        $stmt->bind_param("id", $customer_id, $grandTotal);
        $stmt->execute();
        $order_id = $stmt->insert_id;

        // Insert order items and toppings
        foreach ($cart as $item) {
            $total_topping_price = 0;
            $toppings = [];

            foreach ($item['selectedToppings'] as $topping) {
                $stmt = $conn->prepare("SELECT price FROM toppings WHERE topping_name = ?");
                $stmt->bind_param("s", $topping);
                $stmt->execute();
                $result = $stmt->get_result();
                if ($row = $result->fetch_assoc()) {
                    $topping_price = (float)$row['price'];
                    $total_topping_price += $topping_price;
                    $toppings[] = $topping;
                }
            }

            $total_price = ($item['productPrice'] + $total_topping_price) * $item['quantity'];
            $toppings_str = implode(", ", $toppings);

            $stmt = $conn->prepare("INSERT INTO order_details (order_id, product_name, quantity, price, toppings) 
                                    VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("isids", $order_id, $item['productName'], $item['quantity'], $total_price, $toppings_str);
            $stmt->execute();
        }

        // Commit transaction
        $conn->commit();

        // Return order ID in the response
        echo json_encode(['success' => true, 'order_id' => $order_id]);
    } catch (Exception $e) {
        $conn->rollback();
        echo json_encode(['success' => false, 'message' => 'Error processing order: ' . $e->getMessage()]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Required fields are missing.']);
}
?>
