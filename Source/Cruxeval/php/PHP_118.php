<?php
function f($text, $chars) {
    $num_applies = 2;
    $extra_chars = '';
    for($i = 0; $i < $num_applies; $i++) {
        $extra_chars .= $chars;
        $text = str_replace($extra_chars, '', $text);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("zbzquiuqnmfkx", "mk") !== "zbzquiuqnmfkx") { throw new Exception("Test failed!"); }
}

test();
