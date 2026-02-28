<?php
function f($text, $splitter) {
    return join($splitter, explode(' ', strtolower($text)));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("LlTHH sAfLAPkPhtsWP", "#") !== "llthh#saflapkphtswp") { throw new Exception("Test failed!"); }
}

test();
