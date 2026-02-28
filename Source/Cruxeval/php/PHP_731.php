<?php
function f($text, $use) {
    return str_replace($use, '', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Chris requires a ride to the airport on Friday.", "a") !== "Chris requires  ride to the irport on Fridy.") { throw new Exception("Test failed!"); }
}

test();
