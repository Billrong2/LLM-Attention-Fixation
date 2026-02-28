<?php
function f($text, $lower, $upper) {
    $count = 0;
    $new_text = array();
    foreach(str_split($text) as $char) {
        $char = is_numeric($char) ? $lower : $upper;
        if ($char == 'p' || $char == 'C') {
            $count++;
        }
        $new_text[] = $char;
    }
    return array($count, implode($new_text));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("DSUWeqExTQdCMGpqur", "a", "x") !== array(0, "xxxxxxxxxxxxxxxxxx")) { throw new Exception("Test failed!"); }
}

test();
