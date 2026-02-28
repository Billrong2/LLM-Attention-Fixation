<?php
function f($dictionary) {
    $dictionary['1049'] = 55;
    $dictionary[array_key_last($dictionary)] = $dictionary[array_key_last($dictionary)];
    return $dictionary;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("noeohqhk" => 623)) !== array("noeohqhk" => 623, "1049" => 55)) { throw new Exception("Test failed!"); }
}

test();
