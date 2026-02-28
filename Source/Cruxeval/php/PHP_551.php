<?php
function f($data) {
    $members = [];
    foreach ($data as $item => $values) {
        foreach ($values as $member) {
            if (!in_array($member, $members)) {
                $members[] = $member;
            }
        }
    }
    sort($members);
    return $members;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("inf" => array("a", "b"), "a" => array("inf", "c"), "d" => array("inf"))) !== array("a", "b", "c", "inf")) { throw new Exception("Test failed!"); }
}

test();
