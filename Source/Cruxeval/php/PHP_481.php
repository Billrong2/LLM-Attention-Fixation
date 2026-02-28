<?php
function f($values, $item1, $item2) {
    if (end($values) == $item2) {
        if (!in_array($values[0], array_slice($values, 1))) {
            $values[] = $values[0];
        }
    } elseif (end($values) == $item1) {
        if ($values[0] == $item2) {
            $values[] = $values[0];
        }
    }
    return $values;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1), 2, 3) !== array(1, 1)) { throw new Exception("Test failed!"); }
}

test();
