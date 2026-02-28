<?php
function f($text) {
    $maxPosition = -1;
    $vowels = ['a', 'e', 'i', 'o', 'u'];
    foreach ($vowels as $ch) {
        $position = strpos($text, $ch);
        if ($position !== false && $position > $maxPosition) {
            $maxPosition = $position;
        }
    }
    return $maxPosition;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qsqgijwmmhbchoj") !== 13) { throw new Exception("Test failed!"); }
}

test();
