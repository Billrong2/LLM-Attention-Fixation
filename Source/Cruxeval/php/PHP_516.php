<?php
function f($strings, $substr) {
    $list = array_filter($strings, function($s) use ($substr) {
        return strpos($s, $substr) === 0;
    });
    usort($list, function($a, $b) {
        return strlen($a) - strlen($b);
    });

    return $list;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("condor", "eyes", "gay", "isa"), "d") !== array()) { throw new Exception("Test failed!"); }
}

test();
