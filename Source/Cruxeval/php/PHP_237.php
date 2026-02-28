<?php
function f($text, $char) {
    if (strpos($text, $char) !== false) {
        $suff = substr($text, 0, strpos($text, $char));
        $pref = substr($text, strpos($text, $char) + strlen($char));
        $pref = $suff . $char . $pref;
        return $suff . $char . $pref;
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("uzlwaqiaj", "u") !== "uuzlwaqiaj") { throw new Exception("Test failed!"); }
}

test();
