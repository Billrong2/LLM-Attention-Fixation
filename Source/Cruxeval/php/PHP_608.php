<?php
function f($aDict) {
    $result = array();
    foreach ($aDict as $key => $value) {
        $result[$value] = $key;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1 => 1, 2 => 2, 3 => 3)) !== array(1 => 1, 2 => 2, 3 => 3)) { throw new Exception("Test failed!"); }
}

test();
