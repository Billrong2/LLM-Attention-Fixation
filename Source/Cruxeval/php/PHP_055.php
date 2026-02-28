<?php
function f($array) {
    $array_2 = [];
    foreach ($array as $i) {
        if ($i > 0) {
            $array_2[] = $i;
        }
    }
    rsort($array_2);
    return $array_2;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(4, 8, 17, 89, 43, 14)) !== array(89, 43, 17, 14, 8, 4)) { throw new Exception("Test failed!"); }
}

test();
