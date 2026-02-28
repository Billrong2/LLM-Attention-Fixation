<?php
function f($array) {
    $result = [];
    $index = 0;
    while ($index < count($array)) {
        array_push($result, array_pop($array));
        $index += 2;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(8, 8, -4, -9, 2, 8, -1, 8)) !== array(8, -1, 8)) { throw new Exception("Test failed!"); }
}

test();
