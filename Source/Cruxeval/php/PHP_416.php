<?php
function f($text, $old, $new) {
    $index = strrpos(substr($text, 0, strpos($text, $old)), $old);
    $result = str_split($text);
    while ($index > 0) {
        array_splice($result, $index, strlen($old), $new);
        $index = strrpos(substr($text, 0, $index), $old);
    }
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("jysrhfm ojwesf xgwwdyr dlrul ymba bpq", "j", "1") !== "jysrhfm ojwesf xgwwdyr dlrul ymba bpq") { throw new Exception("Test failed!"); }
}

test();
