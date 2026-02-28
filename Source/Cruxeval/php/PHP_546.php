<?php
function f($text, $speaker) {
    while (substr($text, 0, strlen($speaker)) === $speaker) {
        $text = substr($text, strlen($speaker));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("[CHARRUNNERS]Do you know who the other was? [NEGMENDS]", "[CHARRUNNERS]") !== "Do you know who the other was? [NEGMENDS]") { throw new Exception("Test failed!"); }
}

test();
