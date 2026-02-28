<?php
function f($value, $char) {
    $total = 0;
    for ($i = 0; $i < strlen($value); $i++) {
        $c = $value[$i];
        if ($c === $char || $c === strtolower($char)) {
            $total++;
        }
    }
    return $total;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("234rtccde", "e") !== 1) { throw new Exception("Test failed!"); }
}

test();
