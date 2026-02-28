<?php
function f($text) {
    $new_text = '';
    $text = trim(strtolower($text));
    for ($i = 0; $i < strlen($text); $i++) {
        $ch = $text[$i];
        if (is_numeric($ch) || strpos('ÄäÏïÖöÜü', $ch) !== false) {
            $new_text .= $ch;
        }
    }
    return $new_text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("") !== "") { throw new Exception("Test failed!"); }
}

test();
