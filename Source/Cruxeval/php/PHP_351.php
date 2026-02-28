<?php
function f($text) {
    try {
        while (strpos($text, 'nnet lloP') !== false) {
            $text = str_replace('nnet lloP', 'nnet loLp', $text);
        }
    } finally {
        return $text;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a_A_b_B3 ") !== "a_A_b_B3 ") { throw new Exception("Test failed!"); }
}

test();
