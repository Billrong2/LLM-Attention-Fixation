<?php
function f($ints) {
    $counts = array_fill(0, 301, 0);

    foreach ($ints as $i) {
        $counts[$i]++;
    }

    $r = [];
    for ($i = 0; $i < count($counts); $i++) {
        if ($counts[$i] >= 3) {
            $r[] = strval($i);
        }
    }
    $counts = [];
    return implode(' ', $r);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 3, 5, 2, 4, 5, 2, 89)) !== "2") { throw new Exception("Test failed!"); }
}

test();
