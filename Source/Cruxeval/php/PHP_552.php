<?php
function f($d) {
    $result = [];
    foreach ($d as $k => $v) {
        if (is_float($k)) {
            foreach ($v as $i) {
                $result[$i] = $k;
            }
        } else {
            $result[$k] = $v;
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2 => 0.76, 5 => array(3, 6, 9, 12))) !== array(2 => 0.76, 5 => array(3, 6, 9, 12))) { throw new Exception("Test failed!"); }
}

test();
