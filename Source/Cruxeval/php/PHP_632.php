<?php
function f($lst) {
    $n = count($lst);
    for ($i = $n - 1; $i > 0; $i--) {
        for ($j = 0; $j < $i; $j++) {
            if ($lst[$j] > $lst[$j + 1]) {
                list($lst[$j], $lst[$j + 1]) = array($lst[$j + 1], $lst[$j]);
                sort($lst);
            }
        }
    }
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(63, 0, 1, 5, 9, 87, 0, 7, 25, 4)) !== array(0, 0, 1, 4, 5, 7, 9, 25, 63, 87)) { throw new Exception("Test failed!"); }
}

test();
