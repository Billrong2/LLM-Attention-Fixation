<?php
function f($phrase) {
    $result = '';
    for ($i = 0; $i < strlen($phrase); $i++) {
        if (!ctype_lower($phrase[$i])) {
            $result .= $phrase[$i];
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("serjgpoDFdbcA.") !== "DFA.") { throw new Exception("Test failed!"); }
}

test();
