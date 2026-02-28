<?php
function f($chemicals, $num) {
    $fish = array_slice($chemicals, 1);
    $reversedChemicals = array_reverse($chemicals);
    
    for ($i = 0; $i < $num; $i++) {
        array_push($fish, array_splice($reversedChemicals, 1, 1)[0]);
    }
    
    $chemicals = array_reverse($reversedChemicals);
    return $chemicals;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("lsi", "s", "t", "t", "d"), 0) !== array("lsi", "s", "t", "t", "d")) { throw new Exception("Test failed!"); }
}

test();
