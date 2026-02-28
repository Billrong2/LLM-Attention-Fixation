<?php
function f($letters) {
$letters_only = trim($letters, "., !?*");
return implode("....", explode(" ", $letters_only));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("h,e,l,l,o,wo,r,ld,") !== "h,e,l,l,o,wo,r,ld") { throw new Exception("Test failed!"); }
}

test();
