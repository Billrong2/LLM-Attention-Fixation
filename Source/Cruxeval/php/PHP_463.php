<?php
function f($dict) {
    $result = $dict;
    $remove_keys = [];
    foreach ($dict as $k => $v) {
        if (array_key_exists($v, $dict)) {
            unset($result[$k]);
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1 => -1, 5 => 5, 3 => 6, -4 => -4)) !== array(3 => 6)) { throw new Exception("Test failed!"); }
}

test();
