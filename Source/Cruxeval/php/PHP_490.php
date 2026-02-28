<?php
function f($s) {
    return implode('', array_filter(str_split($s), function($c) {
        return ctype_space($c);
    }));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("\ngiyixjkvu\n rgjuo") !== "\n\n ") { throw new Exception("Test failed!"); }
}

test();
