<?php
function f($d, $count) {
    for($i = 0; $i < $count; $i++) {
        if(empty($d)) {
            break;
        }
        array_pop($d);
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), 200) !== array()) { throw new Exception("Test failed!"); }
}

test();
