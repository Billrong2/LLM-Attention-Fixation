<?php
function f($s) {
    $words = explode(" ", $s);
    $count = 0;
    foreach ($words as $word) {
        if (ctype_upper($word[0]) && ctype_lower(substr($word, 1))) {
            $count += 1;
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("SOME OF THIS Is uknowN!") !== 1) { throw new Exception("Test failed!"); }
}

test();
