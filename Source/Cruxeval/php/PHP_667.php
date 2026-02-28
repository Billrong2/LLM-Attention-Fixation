<?php
function f($text) {
    $new_text = [];
    for ($i = 0; $i < floor(strlen($text) / 3); $i++) {
        $new_text[] = "< " . substr($text, $i * 3, 3) . " level=$i >";
    }
    $last_item = substr($text, floor(strlen($text) / 3) * 3);
    $new_text[] = "< $last_item level=" . floor(strlen($text) / 3) . " >";
    return $new_text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("C7") !== array("< C7 level=0 >")) { throw new Exception("Test failed!"); }
}

test();
