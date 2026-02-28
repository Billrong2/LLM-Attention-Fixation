<?php
function f($c, $st, $ed) {
    $d = [];
    $a = 0;
    $b = 0;
    foreach ($c as $x => $y) {
        $d[$y] = $x;
        if ($y == $st) {
            $a = $x;
        }
        if ($y == $ed) {
            $b = $x;
        }
    }
    $w = $d[$st];
    return $a > $b ? [$w, $b] : [$b, $w];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("TEXT" => 7, "CODE" => 3), 7, 3) !== array("TEXT", "CODE")) { throw new Exception("Test failed!"); }
}

test();
