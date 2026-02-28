<?php
function f($text) {
    $ws = 0;
    for ($i = 0; $i < strlen($text); $i++) {
        if (ctype_space($text[$i])) {
            $ws += 1;
        }
    }
    return array($ws, strlen($text));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("jcle oq wsnibktxpiozyxmopqkfnrfjds") !== array(2, 34)) { throw new Exception("Test failed!"); }
}

test();
