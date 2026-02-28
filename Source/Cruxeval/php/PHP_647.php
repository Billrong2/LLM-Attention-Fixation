<?php
function f($text, $chunks) {
    return explode("\n", $text);
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("/alcm@ an)t//eprw)/e!/d\nujv", 0) !== array("/alcm@ an)t//eprw)/e!/d", "ujv")) { throw new Exception("Test failed!"); }
}

test();
