<?php
function f($list_, $num) {
    $temp = [];
    foreach ($list_ as $i) {
        $i = str_repeat($i.',', $num / 2);
        array_push($temp, $i);
    }
    return $temp;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("v"), 1) !== array("")) { throw new Exception("Test failed!"); }
}

test();
