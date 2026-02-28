<?php
function f($pattern, $items) {
    $result = [];
    foreach ($items as $text) {
        $pos = strrpos($text, $pattern);
        if ($pos !== false) {
            $result[] = $pos;
        }
    }
    
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(" B ", array(" bBb ", " BaB ", " bB", " bBbB ", " bbb")) !== array()) { throw new Exception("Test failed!"); }
}

test();
