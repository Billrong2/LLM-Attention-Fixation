<?php
function f($text) {
    $result = "";
    for ($i = 0; $i < strlen($text); $i++) {
        if ($i % 2 == 0) {
            $result .= strtoupper($text[$i]);
        } else {
            $result .= $text[$i];
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("vsnlygltaw") !== "VsNlYgLtAw") { throw new Exception("Test failed!"); }
}

test();
