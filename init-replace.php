<?php
array_shift($argv);

if (count($argv) == 2) { // using pipe for single replacement
    $replace = file_get_contents("php://stdin");
    list($search, $destination) = $argv;
} else { //listing replacements
    $destination = array_pop($argv);
    $search = $replace = [];
    foreach ($argv as $index => $arg) {
        $part = $index % 2 ? 'replace' : 'search';
        array_push($$part, $arg);
    }
}
if (file_exists($destination)) {
    $content = str_replace($search, $replace, file_get_contents($destination));
    file_put_contents($destination, $content);
} else {
    $content = str_replace($search, $replace, $destination);
    echo $content;
}
