<?php
function f($input_string, $spaces) {
    $result = '';
    for ($i = 0; $i < strlen($input_string); $i++) {
        if ($input_string[$i] == '\t') {
            $result .= str_repeat(' ', $spaces);
        } else {
            $result .= $input_string[$i];
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a\tb", 4) !== "a\tb") { throw new Exception("Test failed!"); }
}

test();
