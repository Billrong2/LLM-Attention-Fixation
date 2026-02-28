<?php
function f($temp, $timeLimit) {
    $s = (int)($timeLimit / $temp);
    $e = $timeLimit % $temp;
    return ($s > 1) ? $s . " " . $e : $e . " oC";
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(1, 1234567890) !== "1234567890 0") { throw new Exception("Test failed!"); }
}

test();
