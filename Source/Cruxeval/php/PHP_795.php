<?php
function f($text) {
    return ucwords(preg_replace_callback('/(\b\w)/', function($m) {
        return strtoupper($m[0]);
    }, str_replace('Io', 'io', $text)));
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Fu,ux zfujijabji pfu.") !== "Fu,Ux Zfujijabji Pfu.") { throw new Exception("Test failed!"); }
}

test();
