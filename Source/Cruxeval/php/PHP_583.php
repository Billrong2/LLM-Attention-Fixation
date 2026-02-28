<?php
function f($text, $ch) {
    $result = [];
    foreach (explode("\n", $text) as $line) {
        if (strlen($line) > 0 && $line[0] == $ch) {
            $result[] = strtolower($line);
        } else {
            $result[] = strtoupper($line);
        }
    }
    return implode("\n", $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("t\nza\na", "t") !== "t\nZA\nA") { throw new Exception("Test failed!"); }
}

test();
