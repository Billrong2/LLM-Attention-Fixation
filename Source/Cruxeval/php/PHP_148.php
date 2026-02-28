<?php
function f($forest, $animal) {
    $index = strpos($forest, $animal);
    $result = str_split($forest);
    while ($index < strlen($forest)-1) {
        $result[$index] = $forest[$index+1];
        $index++;
    }
    if ($index == strlen($forest)-1) {
        $result[$index] = '-';
    }
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("2imo 12 tfiqr.", "m") !== "2io 12 tfiqr.-") { throw new Exception("Test failed!"); }
}

test();
