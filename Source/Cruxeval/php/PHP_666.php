<?php
function f($d1, $d2) {
    $mmax = 0;
    foreach ($d1 as $k1 => $value) {
        if ($p = count($d1[$k1]) + count($d2[$k1] ?? [])) {
            if ($p > $mmax) {
                $mmax = $p;
            }
        }
    }
    return $mmax;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0 => array(), 1 => array()), array(0 => array(0, 0, 0, 0), 2 => array(2, 2, 2))) !== 4) { throw new Exception("Test failed!"); }
}

test();
