<?php
function f($sb) {
    $d = array();
    for ($i = 0; $i < strlen($sb); $i++) {
        $s = $sb[$i];
        $d[$s] = isset($d[$s]) ? $d[$s] + 1 : 1;
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("meow meow") !== array("m" => 2, "e" => 2, "o" => 2, "w" => 2, " " => 1)) { throw new Exception("Test failed!"); }
}

test();
