<?php
function f($text, $length) {
    $length = $length < 0 ? -$length : $length;
    $output = '';
    for ($idx = 0; $idx < $length; $idx++) {
        if ($text[$idx % strlen($text)] !== ' ') {
            $output .= $text[$idx % strlen($text)];
        } else {
            break;
        }
    }
    return $output;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("I got 1 and 0.", 5) !== "I") { throw new Exception("Test failed!"); }
}

test();
