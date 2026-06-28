<?php
$connect = new mysqli("localhost", "root", "", "thala_db");
if($connect->connect_error){
    die("Koneksi gagal");
}
?>