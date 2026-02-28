<?php
function f($char_freq) {
    $result = array();
    foreach ($char_freq as $k => $v) {
        $result[$k] = intval($v / 2);
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("u" => 20, "v" => 5, "b" => 7, "w" => 3, "x" => 3)) !== array("u" => 10, "v" => 2, "b" => 3, "w" => 1, "x" => 1)) { throw new Exception("Test failed!"); }
}

test();
