<?php
function f($xs) {
    $new_x = $xs[0] - 1;
    array_shift($xs);
    while ($new_x <= $xs[0]) {
        array_shift($xs);
        $new_x -= 1;
    }
    array_unshift($xs, $new_x);
    return $xs;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6, 3, 4, 1, 2, 3, 5)) !== array(5, 3, 4, 1, 2, 3, 5)) { throw new Exception("Test failed!"); }
}

test();
