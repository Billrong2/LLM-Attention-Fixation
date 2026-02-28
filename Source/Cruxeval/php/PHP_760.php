<?php
function f($d) {
    $l = array();
    while (count($d) > 0) {
        $key = array_key_last($d);
        array_push($l, $key);
        unset($d[$key]);
    }
    return $l;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("f" => 1, "h" => 2, "j" => 3, "k" => 4)) !== array("k", "j", "h", "f")) { throw new Exception("Test failed!"); }
}

test();
