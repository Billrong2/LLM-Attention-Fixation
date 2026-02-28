<?php
function f($names) {
    $count = count($names);
    $numberOfNames = 0;
    foreach ($names as $name) {
        if (ctype_alpha($name)) {
            $numberOfNames++;
        }
    }
    return $numberOfNames;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("sharron", "Savannah", "Mike Cherokee")) !== 2) { throw new Exception("Test failed!"); }
}

test();
