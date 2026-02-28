<?php
function f($d, $k) {
    $new_d = array();
    foreach ($d as $key => $val) {
        if ($key < $k) {
            $new_d[$key] = $val;
        }
    }
    return $new_d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1 => 2, 2 => 4, 3 => 3), 3) !== array(1 => 2, 2 => 4)) { throw new Exception("Test failed!"); }
}

test();
