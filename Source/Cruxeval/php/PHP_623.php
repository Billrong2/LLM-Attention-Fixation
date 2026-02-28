<?php
function f($text, $rules) {
    foreach ($rules as $rule) {
        if ($rule == '@') {
            $text = strrev($text);
        } elseif ($rule == '~') {
            $text = strtoupper($text);
        } elseif ($text && $text[strlen($text)-1] == $rule) {
            $text = substr($text, 0, strlen($text)-1);
        }
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hi~!", array("~", "`", "!", "&")) !== "HI~") { throw new Exception("Test failed!"); }
}

test();
