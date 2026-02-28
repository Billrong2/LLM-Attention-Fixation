<?php
function f($numbers) {
    $new_numbers = [];
    foreach (array_reverse($numbers) as $value) {
        $new_numbers[] = $value;
    }
    return $new_numbers;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(11, 3)) !== array(3, 11)) { throw new Exception("Test failed!"); }
}

test();
