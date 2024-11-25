<?php
// data_analysis.php

include 'database.php'; // Include your database connection
header('Content-Type: application/json');
$conn = getDatabaseConnection();

define('DEFAULT_MONTH', date('m'));
define('DEFAULT_YEAR', date('Y'));

$action = $_GET['action'] ?? '';

switch ($action) {
    case 'total_sales':
        fetchTotalSales($conn);
        break;
    case 'top_selling_products':
        fetchTopSellingProducts($conn);
        break;
    case 'sales_by_category':
        fetchSalesByCategory($conn);
        break;
    case 'daily_sales':
        fetchDailySales($conn);
        break;
    default:
        echo json_encode(['success' => false, 'message' => 'Invalid action']);
}

function fetchTotalSales($conn) {
    $month = $_GET['month'] ?? DEFAULT_MONTH;
    $year = $_GET['year'] ?? DEFAULT_YEAR;

    $stmt = $conn->prepare("SELECT SUM(total_price) AS total_sales FROM orders WHERE MONTH(order_date) = ? AND YEAR(order_date) = ?");
    $stmt->bind_param("ii", $month, $year);
    $stmt->execute();
    $result = $stmt->get_result();
    $data = $result->fetch_assoc();

    echo json_encode(['success' => true, 'data' => $data]);
}

function fetchTopSellingProducts($conn) {
    $stmt = $conn->prepare("SELECT product_name, SUM(quantity) AS total_quantity FROM order_details GROUP BY product_name ORDER BY total_quantity DESC LIMIT 5");
    $stmt->execute();
    $result = $stmt->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    echo json_encode(['success' => true, 'data' => $data]);
}

function fetchSalesByCategory($conn) {
    $stmt = $conn->prepare("SELECT p.product_category, SUM(od.quantity * od.price) AS total_sales FROM order_details od JOIN products p ON od.product_name = p.product_name GROUP BY p.product_category");
    $stmt->execute();
    $result = $stmt->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    echo json_encode(['success' => true, 'data' => $data]);
}

function fetchDailySales($conn) {
    $stmt = $conn->prepare("SELECT DATE(order_date) AS sale_date, SUM(total_price) AS total_sales FROM orders GROUP BY sale_date");
    $stmt->execute();
    $result = $stmt->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    echo json_encode(['success' => true, 'data' => $data]);
}
?>
