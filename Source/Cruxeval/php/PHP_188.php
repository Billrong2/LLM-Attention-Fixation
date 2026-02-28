<?php
function f($strings) {
    $new_strings = [];
    foreach ($strings as $string) {
        $first_two = substr($string, 0, 2);
        if (strpos('ap', $first_two[0]) !== false) {
            $new_strings[] = $first_two;
        }
    }

    return $new_strings;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a", "b", "car", "d")) !== array("a")) { throw new Exception("Test failed!"); }
}

test();
