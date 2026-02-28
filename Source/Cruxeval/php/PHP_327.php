<?php
function f($lst) {
    $new = array();
    $i = count($lst) - 1;
    foreach ($lst as $item) {
        if ($i % 2 == 0) {
            $new[] = -$lst[$i];
        } else {
            $new[] = $lst[$i];
        }
        $i--;
    }
    return $new;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 7, -1, -3)) !== array(-3, 1, 7, -1)) { throw new Exception("Test failed!"); }
}

test();
