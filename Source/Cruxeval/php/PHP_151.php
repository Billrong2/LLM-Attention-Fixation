<?php
function f($text) {
    foreach(str_split($text) as $key => $c) {
        if (is_numeric($c)) {
            if ($c == '0') {
                $c = '.';
            } else {
                $c = '0';
            }
        }
    }
    return str_replace('.', '0', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("697 this is the ultimate 7 address to attack") !== "697 this is the ultimate 7 address to attack") { throw new Exception("Test failed!"); }
}

test();
