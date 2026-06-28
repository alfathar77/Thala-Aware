<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: POST");

include 'koneksi.php';

$username = $_POST['username'];
$date = $_POST['date'];
$user_status = $_POST['user_status'];
$partner_status = $_POST['partner_status'];
$risk_result = $_POST['risk_result'];

$query = $connect->query("INSERT INTO history_calc (username, date, user_status, partner_status, risk_result) VALUES ('$username', '$date', '$user_status', '$partner_status', '$risk_result')");

if($query){ echo json_encode(["message" => "Success"]); }
?>