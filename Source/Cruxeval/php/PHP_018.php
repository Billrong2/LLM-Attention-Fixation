<?php
function f($array, $elem) {
    $k = 0;
    $l = array_values($array);
    foreach ($l as $i) {
        if ($i > $elem) {
            array_splice($array, $k, 0, $elem);
            break;
        }
        $k++;
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, 4, 3, 2, 1, 0), 3) !== array(3, 5, 4, 3, 2, 1, 0)) { throw new Exception("Test failed!"); }
}

test();
