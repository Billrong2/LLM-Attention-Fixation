<?php
function f($nums) {
    foreach ($nums as $key => $odd) {
        if ($odd % 2 != 0) {
            unset($nums[$key]);
        }
    }
    
    $sum = 0;
    foreach ($nums as $num) {
        $sum += $num;
    }
    
    return $sum;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(11, 21, 0, 11)) !== 0) { throw new Exception("Test failed!"); }
}

test();
