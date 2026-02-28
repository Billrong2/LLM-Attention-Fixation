<?php
function f($text) {
    $patterns = ['acs', 'asp', 'scn'];
    foreach ($patterns as $p) {
        $text = preg_replace("/^$p/", '', $text) . ' ';
    }
    return substr(ltrim($text), 0, -1);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ilfdoirwirmtoibsac") !== "ilfdoirwirmtoibsac  ") { throw new Exception("Test failed!"); }
}

test();
