<?php
function f($text, $m, $n) {
    $text = $text . substr($text, 0, $m) . substr($text, $n);
    $result = "";
    for ($i = $n; $i < strlen($text) - $m; $i++) {
        $result = $text[$i] . $result;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abcdefgabc", 1, 2) !== "bagfedcacbagfedc") { throw new Exception("Test failed!"); }
}

test();
