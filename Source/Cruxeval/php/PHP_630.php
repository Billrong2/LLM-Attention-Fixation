<?php
function f($original, $string) {
    $temp = $original;
    foreach ($string as $a => $b) {
        $temp[$b] = $a;
    }
    return $temp;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1 => -9, 0 => -7), array(1 => 2, 0 => 3)) !== array(1 => -9, 0 => -7, 2 => 1, 3 => 0)) { throw new Exception("Test failed!"); }
}

test();
