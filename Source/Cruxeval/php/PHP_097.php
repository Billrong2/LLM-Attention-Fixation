<?php
function f($lst) {
    $lst = array();
    foreach ($lst as $i) {
        if ($i == 3) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 0)) !== true) { throw new Exception("Test failed!"); }
}

test();
