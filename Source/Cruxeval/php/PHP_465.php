<?php
function f($seq, $value) {
    $roles = array_fill_keys($seq, 'north');
    if ($value) {
        foreach (explode(', ', $value) as $key) {
            $roles[$key] = '';
        }
    }
    return $roles;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("wise king", "young king"), "") !== array("wise king" => "north", "young king" => "north")) { throw new Exception("Test failed!"); }
}

test();
