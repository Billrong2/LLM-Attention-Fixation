<?php
function f($multi_string) {
    $cond_string = array_map('ctype_print', explode(' ', $multi_string));
    if (in_array(true, $cond_string)) {
        return join(', ', array_filter(explode(' ', $multi_string), 'ctype_print'));
    }
    return '';
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("I am hungry! eat food.") !== "I, am, hungry!, eat, food.") { throw new Exception("Test failed!"); }
}

test();
