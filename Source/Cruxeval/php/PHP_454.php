<?php
function f($d, $count) {
    $new_dict = [];
    for ($i=0; $i<$count; $i++) {
        $d_copy = $d;
        $new_dict = array_merge($new_dict, $d_copy);
    }
    return $new_dict;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a" => 2, "b" => array(), "c" => array()), 0) !== array()) { throw new Exception("Test failed!"); }
}

test();
