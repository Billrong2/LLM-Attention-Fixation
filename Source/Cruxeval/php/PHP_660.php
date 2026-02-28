<?php
function f($num) {
    $initial = [1];
    $total = $initial;
    for ($i = 0; $i < $num; $i++) {
        $temp = [1];
        foreach (array_map(null, $total, array_slice($total, 1)) as [$x, $y]) {
            $temp[] = $x + $y;
        }
        $total = $temp;
        $initial[] = end($total);
    }
    return array_sum($initial);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(3) !== 4) { throw new Exception("Test failed!"); }
}

test();
