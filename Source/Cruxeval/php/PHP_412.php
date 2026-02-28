<?php
function f($start, $end, $interval) {
    $steps = range($start, $end, $interval);
    if (in_array(1, $steps)) {
        $steps[count($steps) - 1] = $end + 1;
    }
    return count($steps);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(3, 10, 1) !== 8) { throw new Exception("Test failed!"); }
}

test();
