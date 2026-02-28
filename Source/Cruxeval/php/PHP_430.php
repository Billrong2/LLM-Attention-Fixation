<?php
function f($arr1, $arr2) {
    $new_arr = $arr1;
    foreach($arr2 as $value){
        array_push($new_arr, $value);
    }
    return $new_arr;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, 1, 3, 7, 8), array("", 0, -1, array())) !== array(5, 1, 3, 7, 8, "", 0, -1, array())) { throw new Exception("Test failed!"); }
}

test();
