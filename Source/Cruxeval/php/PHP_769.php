<?php
function f($text) {
    $text_list = str_split($text);
    foreach ($text_list as $i => $char) {
        $text_list[$i] = strtoupper($char) === $char ? strtolower($char) : strtoupper($char);
    }
    return implode('', $text_list);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("akA?riu") !== "AKa?RIU") { throw new Exception("Test failed!"); }
}

test();
