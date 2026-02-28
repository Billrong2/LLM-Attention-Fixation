<?php
function f($text) {
    $odd = '';
    $even = '';
    for ($i = 0; $i < strlen($text); $i++) {
        if ($i % 2 == 0) {
            $even .= $text[$i];
        } else {
            $odd .= $text[$i];
        }
    }
    return $even . strtolower($odd);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Mammoth") !== "Mmohamt") { throw new Exception("Test failed!"); }
}

test();
