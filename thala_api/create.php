<?php
// --- TAMBAHKAN HEADER INI DI BAGIAN PALING ATAS ---
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

// Jika browser mengirim request 'OPTIONS' (Pre-flight check), langsung stop.
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    http_response_code(200);
    exit();
}
// --------------------------------------------------

include 'koneksi.php';
$username = $_POST['username']; 
// ---------------------

$date = $_POST['date'];
$location = $_POST['location'];
$result = $_POST['result'];
$notes = $_POST['notes'];

// Update query INSERT untuk memasukkan username
$query = $connect->query("INSERT INTO logs (username, date, location, result, notes) VALUES ('$username', '$date','$location','$result','$notes')");

if($query){ echo json_encode(["message" => "Success"]); }
include 'koneksi.php';
$date = $_POST['date'];
$location = $_POST['location'];
$result = $_POST['result'];
$notes = $_POST['notes'];

$query = $connect->query("INSERT INTO logs (date, location, result, notes) VALUES ('$date','$location','$result','$notes')");
if($query){ echo json_encode(["message" => "Success"]); }
?>