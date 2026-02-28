<?php
function f($text) {
    $text = explode(',', $text);
    array_shift($text);
    $indexT = array_search('T', $text);
    array_unshift($text, array_splice($text, $indexT, 1)[0]);
    return 'T,' . implode(',', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Dmreh,Sspp,T,G ,.tB,Vxk,Cct") !== "T,T,Sspp,G ,.tB,Vxk,Cct") { throw new Exception("Test failed!"); }
}

test();
