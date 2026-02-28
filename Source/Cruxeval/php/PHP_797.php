<?php
function f($dct) {
    $lst = [];
    foreach (array_keys($dct) as $key) {
        $lst[] = [$key, $dct[$key]];
    }
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a" => 1, "b" => 2, "c" => 3)) !== array(array("a", 1), array("b", 2), array("c", 3))) { throw new Exception("Test failed!"); }
}

test();
