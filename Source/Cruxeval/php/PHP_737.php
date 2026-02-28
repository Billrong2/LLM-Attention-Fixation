<?php
function f($nums) {
    $counts = 0;
    foreach ($nums as $i) {
        if (is_numeric($i)) {
            if ($counts == 0) {
                $counts += 1;
            }
        }
    }
    return $counts;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 6, 2, -1, -2)) !== 1) { throw new Exception("Test failed!"); }
}

test();
