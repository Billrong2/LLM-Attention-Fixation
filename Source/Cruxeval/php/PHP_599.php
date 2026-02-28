<?php
function f($a, $b) {
    $a = implode($b, $a);
    $lst = [];
    for ($i = 1; $i <= strlen($a); $i += 2) {
        $lst[] = substr($a, $i - 1, $i);
        $lst[] = substr($a, $i - 1 + $i);
    }
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a", "b", "c"), " ") !== array("a", " b c", "b c", "", "c", "")) { throw new Exception("Test failed!"); }
}

test();
