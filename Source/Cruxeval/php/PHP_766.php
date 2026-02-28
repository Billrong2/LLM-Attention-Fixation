<?php
function f($values, $value) {
    $length = count($values);
    $new_dict = array_fill_keys($values, $value);
    $sorted_values = $values;
    sort($sorted_values);
    $new_dict[implode($sorted_values)] = $value * 3;
    return $new_dict;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("0", "3"), 117) !== array("0" => 117, "3" => 117, "03" => 351)) { throw new Exception("Test failed!"); }
}

test();
