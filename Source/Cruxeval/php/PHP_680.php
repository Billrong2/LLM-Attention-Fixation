<?php
function f($text) {
    $letters = '';
    for($i = 0; $i < strlen($text); $i++) {
        if(ctype_alnum($text[$i])) {
            $letters .= $text[$i];
        }
    }
    return $letters;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("we@32r71g72ug94=(823658*!@324") !== "we32r71g72ug94823658324") { throw new Exception("Test failed!"); }
}

test();
