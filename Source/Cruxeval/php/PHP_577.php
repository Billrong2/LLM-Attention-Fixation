<?php
function f($items) {
    $result = array();
    foreach ($items as $number) {
        $d = array_combine(array_keys($items), array_values($items)); // converting array to dictionary
        array_pop($d);
        $result[] = $d;
        sort($d);
        $items = $d;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(1, "pos"))) !== array(array())) { throw new Exception("Test failed!"); }
}

test();
