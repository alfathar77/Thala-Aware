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
include 'koneksi.php';
$id = $_POST['id'];
$query = $connect->query("DELETE FROM logs WHERE id='$id'");
if($query){ echo json_encode(["message" => "Deleted"]); }
?>