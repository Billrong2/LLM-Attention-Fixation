<?php
function f($var) {
    if (is_numeric($var)) {
        if (strpos($var, '.') !== false) {
            return "float";
        } else {
            return "int";
        }
    } elseif (str_word_count($var) == 1 && strlen($var) > 1) {
        return "str";
    } elseif (strlen($var) == 1) {
        return "char";
    } else {
        return "tuple";
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(" 99 777") !== "tuple") { throw new Exception("Test failed!"); }
}

test();
