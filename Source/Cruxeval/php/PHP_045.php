<?php
function f($text, $letter) {
    $counts = array();
    for ($i = 0; $i < strlen($text); $i++) {
        $char = $text[$i];
        if (!isset($counts[$char])) {
            $counts[$char] = 1;
        } else {
            $counts[$char]++;
        }
    }
    
    return isset($counts[$letter]) ? $counts[$letter] : 0;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("za1fd1as8f7afasdfam97adfa", "7") !== 2) { throw new Exception("Test failed!"); }
}

test();
