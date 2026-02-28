<?php
function f($string) {
    if (ctype_alnum($string)) {
        return "ascii encoded is allowed for this language";
    }
    return "more than ASCII";
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Str zahrnuje anglo-ameriæske vasi piscina and kuca!") !== "more than ASCII") { throw new Exception("Test failed!"); }
}

test();
