<?php
function f($array) {
    $prev = $array[0];
    $newArray = $array;
    for ($i = 1; $i < count($array); $i++) {
        if ($prev !== $array[$i]) {
            $newArray[$i] = $array[$i];
        } else {
            unset($newArray[$i]);
        }
        $prev = $array[$i];
    }
    return array_values($newArray);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3)) !== array(1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();
