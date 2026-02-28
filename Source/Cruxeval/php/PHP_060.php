<?php
function f($doc) {
    for($i = 0; $i < strlen($doc); $i++) {
        $x = $doc[$i];
        if(ctype_alpha($x)) {
            return ucfirst($x);
        }
    }
    return '-';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("raruwa") !== "R") { throw new Exception("Test failed!"); }
}

test();
