<?php
function f($text, $tab_size) {
    $res = '';
    $text = str_replace("\t", str_repeat(' ', $tab_size-1), $text);
    for ($i = 0; $i < strlen($text); $i++) {
        if ($text[$i] == ' ') {
            $res .= '|';
        } else {
            $res .= $text[$i];
        }
    }
    return $res;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("	a", 3) !== "||a") { throw new Exception("Test failed!"); }
}

test();
