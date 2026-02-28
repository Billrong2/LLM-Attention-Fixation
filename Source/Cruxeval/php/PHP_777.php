<?php
function f($names, $excluded) {
    $excluded = $excluded;
    for ($i = 0; $i < count($names); $i++) {
        if (strpos($names[$i], $excluded) !== false) {
            $names[$i] = str_replace($excluded, "", $names[$i]);
        }
    }
    return $names;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("avc  a .d e"), "") !== array("avc  a .d e")) { throw new Exception("Test failed!"); }
}

test();
