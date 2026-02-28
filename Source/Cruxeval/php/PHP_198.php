<?php
function f($text, $strip_chars) {
    return strrev(ltrim(strrev(trim($text)), $strip_chars));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("tcmfsmj", "cfj") !== "tcmfsm") { throw new Exception("Test failed!"); }
}

test();
