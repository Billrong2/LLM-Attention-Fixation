<?php
function f($a) {
    if ($a == 0) {
        return [0];
    }
    $result = [];
    while ($a > 0) {
        $result[] = $a % 10;
        $a = (int)($a / 10);
    }
    $result = array_reverse($result);
    return (int)implode('', array_map('strval', $result));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(0) !== array(0)) { throw new Exception("Test failed!"); }
}

test();
