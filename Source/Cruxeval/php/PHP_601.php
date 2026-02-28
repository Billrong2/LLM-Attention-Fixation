<?php
function f($text) {
    $t = 5;
    $tab = [];
    for ($i = 0; $i < strlen($text); $i++) {
        if (strpos('aeiouy', strtolower($text[$i])) !== false) {
            $tab[] = strtoupper($text[$i]) . str_repeat(strtoupper($text[$i]), $t-1);
        } else {
            $tab[] = str_repeat($text[$i], $t);
        }
    }
    return implode(' ', $tab);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("csharp") !== "ccccc sssss hhhhh AAAAA rrrrr ppppp") { throw new Exception("Test failed!"); }
}

test();
