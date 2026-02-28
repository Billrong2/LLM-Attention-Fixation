<?php
function f($dic, $inx) {
    $keys = array_keys($dic);
    if (in_array($inx, $keys)) {
        $dic[$inx] = strtolower($inx);
    }
    return array_map(null, $keys, array_values($dic));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("Bulls" => 23, "White Sox" => 45), "Bulls") !== array(array("Bulls", "bulls"), array("White Sox", 45))) { throw new Exception("Test failed!"); }
}

test();
