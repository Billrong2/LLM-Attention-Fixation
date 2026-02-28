<?php
function f($num) {
    $letter = 1;
    foreach (str_split('1234567890') as $i) {
        $num = str_replace($i, '', $num);
        if (strlen($num) == 0) break;
        $num = substr($num, $letter) . substr($num, 0, $letter);
        $letter++;
    }
    return $num;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("bwmm7h") !== "mhbwm") { throw new Exception("Test failed!"); }
}

test();
