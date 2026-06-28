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
$query = $connect->query("SELECT * FROM logs ORDER BY id DESC");
$result = array();
while($row = $query->fetch_assoc()){
    $result[] = $row;
}
echo json_encode($result);
?>