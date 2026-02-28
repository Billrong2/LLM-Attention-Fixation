<?php
function f($text) {
    $out = "";
    for ($i = 0; $i < strlen($text); $i++) {
        if (ctype_upper($text[$i])) {
            $out .= strtolower($text[$i]);
        } else {
            $out .= strtoupper($text[$i]);
        }
    }
    return $out;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(",wPzPppdl/") !== ",WpZpPPDL/") { throw new Exception("Test failed!"); }
}

test();
