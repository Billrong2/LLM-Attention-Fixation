<?php
function f($text) {
    $occ = array();
    foreach(str_split($text) as $ch) {
        $name = array('a' => 'b', 'b' => 'c', 'c' => 'd', 'd' => 'e', 'e' => 'f');
        $name = isset($name[$ch]) ? $name[$ch] : $ch;
        $occ[$name] = isset($occ[$name]) ? $occ[$name] + 1 : 1;
    }
    return array_values($occ);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("URW rNB") !== array(1, 1, 1, 1, 1, 1, 1)) { throw new Exception("Test failed!"); }
}

test();
