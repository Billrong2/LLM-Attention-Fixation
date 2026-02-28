<?php
function f($text, $function) {
    $cites = [strlen(substr($text, strpos($text, $function) + strlen($function)))];
    for ($i = 0; $i < strlen($text); $i++) {
        if ($text[$i] == $function) {
            $cites[] = strlen(substr($text, strpos($text, $function) + strlen($function))) - 1;
        }
    }
    return $cites;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("010100", "010") !== array(3)) { throw new Exception("Test failed!"); }
}

test();
