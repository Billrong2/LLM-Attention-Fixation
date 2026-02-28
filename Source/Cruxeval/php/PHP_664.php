<?php
function f($tags) {
    $resp = "";
    foreach ($tags as $key => $value) {
        $resp .= $key . " ";
    }
    return $resp;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("3" => "3", "4" => "5")) !== "3 4 ") { throw new Exception("Test failed!"); }
}

test();
