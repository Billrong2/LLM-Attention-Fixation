<?php
function f($text) {
    if (!empty($text) && strtoupper($text) === $text) {
        $cs = array_combine(range('A', 'Z'), range('a', 'z'));
        return strtr($text, $cs);
    }
    return strtolower(substr($text, 0, 3));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n") !== "mty") { throw new Exception("Test failed!"); }
}

test();
