<?php
function f($fields, $update_dict) {
    $di = array_fill_keys($fields, '');
    $di = array_merge($di, $update_dict);
    return $di;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("ct", "c", "ca"), array("ca" => "cx")) !== array("ct" => "", "c" => "", "ca" => "cx")) { throw new Exception("Test failed!"); }
}

test();
