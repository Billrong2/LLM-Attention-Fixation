<?php
function f($items) {
    $result = [];
    foreach ($items as $item) {
        foreach (str_split($item) as $d) {
            if (!ctype_digit($d)) {
                $result[] = $d;
            }
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("123", "cat", "d dee")) !== array("c", "a", "t", "d", " ", "d", "e", "e")) { throw new Exception("Test failed!"); }
}

test();
