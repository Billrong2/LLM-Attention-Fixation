<?php
function f($my_dict) {
    $result = array_flip($my_dict);
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a" => 1, "b" => 2, "c" => 3, "d" => 2)) !== array(1 => "a", 2 => "d", 3 => "c")) { throw new Exception("Test failed!"); }
}

test();
