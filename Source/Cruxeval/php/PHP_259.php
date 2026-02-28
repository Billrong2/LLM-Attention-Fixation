<?php
function f($text) {
    $new_text = [];
    for ($i = 0; $i < strlen($text); $i++) {
        $character = $text[$i];
        if (ctype_upper($character)) {
            array_splice($new_text, floor(count($new_text) / 2), 0, $character);
        }
    }
    if (empty($new_text)) {
        $new_text = ['-'];
    }
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("String matching is a big part of RexEx library.") !== "RES") { throw new Exception("Test failed!"); }
}

test();
