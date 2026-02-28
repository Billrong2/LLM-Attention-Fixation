<?php
function f($values) {
    $names = ['Pete', 'Linda', 'Angela'];
    array_push($names, ...$values);
    sort($names);
    return $names;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("Dan", "Joe", "Dusty")) !== array("Angela", "Dan", "Dusty", "Joe", "Linda", "Pete")) { throw new Exception("Test failed!"); }
}

test();
