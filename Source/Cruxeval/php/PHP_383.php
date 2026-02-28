<?php
function f($text, $chars) {
    $result = str_split($text);
    while (strpos(implode('', array_slice($result, -3, null, true)), $chars) !== false) {
        unset($result[count($result) - 3]);
        unset($result[count($result) - 3]);
    }
    return trim(implode('', $result), '.');
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ellod!p.nkyp.exa.bi.y.hain", ".n.in.ha.y") !== "ellod!p.nkyp.exa.bi.y.hain") { throw new Exception("Test failed!"); }
}

test();
