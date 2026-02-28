<?php
function f($st) {
    if (strrpos(strtolower($st), 'h', strrpos(strtolower($st), 'i')) >= strrpos(strtolower($st), 'i')) {
        return 'Hey';
    } else {
        return 'Hi';
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Hi there") !== "Hey") { throw new Exception("Test failed!"); }
}

test();
