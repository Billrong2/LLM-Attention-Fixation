<?php
function f($s, $c1, $c2) {
    if ($s === '') {
        return $s;
    }
    $ls = explode($c1, $s);
    foreach ($ls as $index => $item) {
        if (strpos($item, $c1) !== false) {
            $ls[$index] = str_replace($c1, $c2, $item);
        }
    }
    return implode($c1, $ls);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("", "mi", "siast") !== "") { throw new Exception("Test failed!"); }
}

test();
