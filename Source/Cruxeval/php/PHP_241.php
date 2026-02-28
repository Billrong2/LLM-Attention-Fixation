<?php
function f($postcode) {
    return substr($postcode, strpos($postcode, 'C'));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ED20 CW") !== "CW") { throw new Exception("Test failed!"); }
}

test();
