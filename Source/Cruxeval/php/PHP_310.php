<?php
function f($strands) {
    $subs = $strands;
    foreach ($subs as $i => $j) {
        $len = strlen($j);
        $halfLen = intdiv($len, 2);
        for ($_ = 0; $_ < $halfLen; $_++) {
            $subs[$i] = $j[-1] . substr($j, 1, -1) . $j[0];
        }
    }
    return implode('', $subs);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("__", "1", ".", "0", "r0", "__", "a_j", "6", "__", "6")) !== "__1.00r__j_a6__6") { throw new Exception("Test failed!"); }
}

test();
