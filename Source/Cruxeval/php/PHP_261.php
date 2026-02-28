<?php
function f($nums, $target) {
    $lows = [];
    $higgs = [];
    foreach ($nums as $i) {
        if ($i < $target) {
            $lows[] = $i;
        } else {
            $higgs[] = $i;
        }
    }
    $lows = [];
    return [$lows, $higgs];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(12, 516, 5, 2, 3, 214, 51), 5) !== array(array(), array(12, 516, 5, 214, 51))) { throw new Exception("Test failed!"); }
}

test();
