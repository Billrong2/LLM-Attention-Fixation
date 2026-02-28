<?php
function f($bots) {
    $clean = array();
    foreach ($bots as $username) {
        if (!ctype_upper($username)) {
            $clean[] = substr($username, 0, 2) . substr($username, -3);
        }
    }
    return count($clean);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("yR?TAJhIW?n", "o11BgEFDfoe", "KnHdn2vdEd", "wvwruuqfhXbGis")) !== 4) { throw new Exception("Test failed!"); }
}

test();
