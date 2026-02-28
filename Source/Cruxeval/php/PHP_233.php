<?php
function f($xs) {
    for ($idx = count($xs)-1; $idx >= 0; $idx--) {
        array_push($xs, array_shift($xs));
    }
    return $xs;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3)) !== array(1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();
