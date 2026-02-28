<?php
function f($text) {
    $result = [];
    for ($i = 0; $i < strlen($text); $i++) {
        $ch = $text[$i];
        if ($ch === strtolower($ch)) {
            continue;
        }
        if (strlen($text) - 1 - $i < strrpos($text, strtolower($ch))) {
            $result[] = $ch;
        }
    }
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ru") !== "") { throw new Exception("Test failed!"); }
}

test();
