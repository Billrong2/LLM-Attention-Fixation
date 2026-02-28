<?php
function f($text, $to_remove) {
    $new_text = str_split($text);
    if (in_array($to_remove, $new_text)) {
        $index = array_search($to_remove, $new_text);
        unset($new_text[$index]);
        array_splice($new_text, $index, 0, '?');
        array_splice($new_text, $index, 1);
    }
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("sjbrlfqmw", "l") !== "sjbrfqmw") { throw new Exception("Test failed!"); }
}

test();
