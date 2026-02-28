<?php
function f($text, $sub) {
    $index = [];
    $starting = 0;
    while ($starting !== false) {
        $starting = strpos($text, $sub, $starting);
        if ($starting !== false) {
            $index[] = $starting;
            $starting += strlen($sub);
        }
    }
    return $index;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("egmdartoa", "good") !== array()) { throw new Exception("Test failed!"); }
}

test();
