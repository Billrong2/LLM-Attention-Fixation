<?php
function f($user) {
    if (count(array_keys($user)) > count(array_values($user))) {
        return array_keys($user);
    }
    return array_values($user);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("eating" => "ja", "books" => "nee", "piano" => "coke", "excitement" => "zoo")) !== array("ja", "nee", "coke", "zoo")) { throw new Exception("Test failed!"); }
}

test();
