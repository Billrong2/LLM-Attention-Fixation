<?php
function f($array) {
    $just_ns = array_map(function($num) {
        return str_repeat('n', $num);
    }, $array);

    $final_output = array();
    foreach ($just_ns as $wipe) {
        array_push($final_output, $wipe);
    }
    return $final_output;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
