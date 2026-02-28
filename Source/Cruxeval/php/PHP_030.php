<?php
function f($array) {
    $result = [];
    foreach ($array as $elem) {
        if (ctype_print($elem) || (is_int($elem) && !ctype_print(strval(abs($elem))))) {
            $result[] = $elem;
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a", "b", "c")) !== array("a", "b", "c")) { throw new Exception("Test failed!"); }
}

test();
