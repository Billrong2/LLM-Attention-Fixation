<?php
function f($messages) {
    $phone_code = "+353";
    $result = [];
    foreach ($messages as $message) {
        $message = array_merge($message, str_split($phone_code));
        $result[] = implode(";", $message);
    }
    return implode(". ", $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array("Marie", "Nelson", "Oscar"))) !== "Marie;Nelson;Oscar;+;3;5;3") { throw new Exception("Test failed!"); }
}

test();
