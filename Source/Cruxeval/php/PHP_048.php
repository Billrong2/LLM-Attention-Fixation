<?php
function f($names) {
    if (empty($names)) {
        return "";
    }
    $smallest = $names[0];
    foreach ($names as $name) {
        if ($name < $smallest) {
            $smallest = $name;
        }
    }
    $key = array_search($smallest, $names);
    unset($names[$key]);
    return $smallest;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== "") { throw new Exception("Test failed!"); }
}

test();
