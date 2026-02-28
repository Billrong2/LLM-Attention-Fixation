<?php
function f($n, $m, $num) {
    $x_list = range($n, $m);
    $j = 0;
    while (true) {
        $j = ($j + $num) % count($x_list);
        if ($x_list[$j] % 2 == 0) {
            return $x_list[$j];
        }
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(46, 48, 21) !== 46) { throw new Exception("Test failed!"); }
}

test();
