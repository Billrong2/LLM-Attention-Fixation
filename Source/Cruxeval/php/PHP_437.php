<?php
function f($tap_hierarchy) {
    $hierarchy = [];
    foreach ($tap_hierarchy as $gift) {
        $hierarchy = array_fill_keys(str_split($gift), null);
    }
    return $hierarchy;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("john", "doe", "the", "john", "doe")) !== array("d" => null, "o" => null, "e" => null)) { throw new Exception("Test failed!"); }
}

test();
