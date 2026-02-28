<?php
function f($total, $arg) {
    if (gettype($arg) === 'array') {
        foreach ($arg as $e) {
            $total = array_merge($total, str_split($e));
        }
    } else {
        $total = array_merge($total, str_split($arg));
    }
    return $total;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("1", "2", "3"), "nammo") !== array("1", "2", "3", "n", "a", "m", "m", "o")) { throw new Exception("Test failed!"); }
}

test();
