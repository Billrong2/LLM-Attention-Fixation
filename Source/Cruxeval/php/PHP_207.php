<?php
function f($commands) {
    $d = [];
    foreach ($commands as $c) {
        $d = array_merge($d, $c);
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array("brown" => 2), array("blue" => 5), array("bright" => 4))) !== array("brown" => 2, "blue" => 5, "bright" => 4)) { throw new Exception("Test failed!"); }
}

test();
