<?php
function f($string) {
    if (substr($string, 0, 4) !== 'Nuva') {
        return 'no';
    } else {
        return rtrim($string);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Nuva?dlfuyjys") !== "Nuva?dlfuyjys") { throw new Exception("Test failed!"); }
}

test();
