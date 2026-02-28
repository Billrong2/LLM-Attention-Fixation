<?php
function f($keys, $value) {
    $d = array_fill_keys($keys, $value);
    foreach (array_keys($d) as $i) {
        if ($d[$i] == $d[$i]) {
            unset($d[$i]);
        }
    }
    return $d;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 1, 1), 3) !== array()) { throw new Exception("Test failed!"); }
}

test();
