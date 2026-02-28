<?php
function f($text) {
    $new_text = str_split($text);
    foreach (['+'] as $i) {
        if (in_array($i, $new_text)) {
            $key = array_search($i, $new_text);
            unset($new_text[$key]);
        }
    }
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hbtofdeiequ") !== "hbtofdeiequ") { throw new Exception("Test failed!"); }
}

test();
