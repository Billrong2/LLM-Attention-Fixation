<?php
function f($lists) {
    $lists[1] = [];
    $lists[2] = array_merge($lists[2], $lists[1]);
    return $lists[0];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(395, 666, 7, 4), array(), array(4223, 111))) !== array(395, 666, 7, 4)) { throw new Exception("Test failed!"); }
}

test();
