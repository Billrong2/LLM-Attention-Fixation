<?php
function f($char_map, $text) {
    $new_text = '';
    foreach (str_split($text) as $ch) {
        $val = $char_map[$ch] ?? null;
        if ($val === null) {
            $new_text .= $ch;
        } else {
            $new_text .= $val;
        }
    }
    return $new_text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), "hbd") !== "hbd") { throw new Exception("Test failed!"); }
}

test();
