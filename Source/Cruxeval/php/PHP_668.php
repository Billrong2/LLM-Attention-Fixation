<?php
function f($text) {
    return substr($text, -1) . substr($text, 0, -1);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hellomyfriendear") !== "rhellomyfriendea") { throw new Exception("Test failed!"); }
}

test();
