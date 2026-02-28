<?php
function f($d, $get_ary) {
    $result = [];
    foreach ($get_ary as $key) {
        $result[] = isset($d[$key]) ? $d[$key] : null;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3 => "swims like a bull"), array(3, 2, 5)) !== array("swims like a bull", null, null)) { throw new Exception("Test failed!"); }
}

test();
