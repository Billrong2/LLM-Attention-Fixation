<?php
function f($nums) {
    $count = count($nums);
    $score = [0 => "F", 1 => "E", 2 => "D", 3 => "C", 4 => "B", 5 => "A", 6 => ""];
    $result = [];
    for ($i = 0; $i < $count; $i++) {
        $result[] = $score[$nums[$i]];
    }
    return implode("", $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(4, 5)) !== "BA") { throw new Exception("Test failed!"); }
}

test();
