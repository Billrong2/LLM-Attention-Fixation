<?php
function f($a, $b) {
    sort($a);
    rsort($b);
    return array_merge($a, $b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(666), array()) !== array(666)) { throw new Exception("Test failed!"); }
}

test();
