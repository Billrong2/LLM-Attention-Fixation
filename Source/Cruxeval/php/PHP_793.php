<?php
function f($lst, $start, $end) {
    $count = 0;
    for ($i = $start; $i < $end; $i++) {
        for ($j = $i; $j < $end; $j++) {
            if ($lst[$i] != $lst[$j]) {
                $count++;
            }
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 4, 3, 2, 1), 0, 3) !== 3) { throw new Exception("Test failed!"); }
}

test();
