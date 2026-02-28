<?php
function f($s, $n) {
    $ls = explode(" ", $s);
    $out = [];
    while (count($ls) >= $n) {
        $out = array_merge(array_slice($ls, -$n), $out);
        $ls = array_slice($ls, 0, -$n);
    }
    return array_merge($ls, [implode('_', $out)]);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("one two three four five", 3) !== array("one", "two", "three_four_five")) { throw new Exception("Test failed!"); }
}

test();
