<?php
function f($d) {
    $keys = [];
    foreach ($d as $k => $v) {
        $keys[] = $k . ' => ' . $v;
    }
    return $keys;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("-4" => "4", "1" => "2", "-" => "-3")) !== array("-4 => 4", "1 => 2", "- => -3")) { throw new Exception("Test failed!"); }
}

test();
