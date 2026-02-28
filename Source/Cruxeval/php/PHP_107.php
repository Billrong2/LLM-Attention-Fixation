<?php
function f($text) {
    $result = [];
    for ($i=0; $i < strlen($text); $i++) { 
        if (!ctype_print($text[$i])) {
            return false;
        } elseif (ctype_alnum($text[$i])) {
            array_push($result, strtoupper($text[$i]));
        } else {
            array_push($result, $text[$i]);
        }
    }
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ua6hajq") !== "UA6HAJQ") { throw new Exception("Test failed!"); }
}

test();
