<?php
function f($title) {
    return strtolower($title);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("   Rock   Paper   SCISSORS  ") !== "   rock   paper   scissors  ") { throw new Exception("Test failed!"); }
}

test();
