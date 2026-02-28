<?php
function f($text) {
    $m = 0;
    $cnt = 0;
    $words = explode(' ', $text);
    foreach ($words as $word) {
        if (strlen($word) > $m) {
            $cnt++;
            $m = strlen($word);
        }
    }
    return $cnt;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wys silak v5 e4fi rotbi fwj 78 wigf t8s lcl") !== 2) { throw new Exception("Test failed!"); }
}

test();
