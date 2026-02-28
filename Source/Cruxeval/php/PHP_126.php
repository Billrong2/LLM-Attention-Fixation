<?php
function f($text) {
    $s = strrpos($text, 'o');
    if ($s !== false) {
        $s = str_split($text, $s);
        $div = $s[0] === '' ? '-' : $s[0];
        $div2 = $s[1] === '' ? '-' : $s[1];
        return $s[2] . $div . $s[2] . $div2;
    } else {
        return '-' . $text;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("kkxkxxfck") !== "-kkxkxxfck") { throw new Exception("Test failed!"); }
}

test();
