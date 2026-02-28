<?php
function f($input_string) {
    $table = array_flip(array_combine(str_split('aioe'), str_split('ioua')));
    while (strpos($input_string, 'a') !== false || strpos($input_string, 'A') !== false) {
        $input_string = strtr($input_string, $table);
    }
    return $input_string;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("biec") !== "biec") { throw new Exception("Test failed!"); }
}

test();
