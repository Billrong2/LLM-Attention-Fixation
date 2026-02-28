<?php
function f($dict1, $dict2) {
    $result = $dict1;
    foreach ($dict2 as $key => $value) {
        $result[$key] = $value;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("disface" => 9, "cam" => 7), array("mforce" => 5)) !== array("disface" => 9, "cam" => 7, "mforce" => 5)) { throw new Exception("Test failed!"); }
}

test();
