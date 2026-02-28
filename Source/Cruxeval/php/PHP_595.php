<?php
function f($text, $prefix) {
    if (strpos($text, $prefix) === 0) {
        $text = substr($text, strlen($prefix));
    }
    $text = ucfirst($text);
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qdhstudentamxupuihbuztn", "jdm") !== "Qdhstudentamxupuihbuztn") { throw new Exception("Test failed!"); }
}

test();
