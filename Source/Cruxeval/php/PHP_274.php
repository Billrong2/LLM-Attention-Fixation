<?php
function f($nums, $target) {
    $count = 0;
    foreach($nums as $n1){
        foreach($nums as $n2){
            $count += ($n1 + $n2 == $target) ? 1 : 0;
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3), 4) !== 3) { throw new Exception("Test failed!"); }
}

test();
