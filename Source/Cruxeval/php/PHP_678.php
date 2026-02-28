<?php
function f($text) {
    $freq = array();
    $text = strtolower($text);
    for ($i = 0; $i < strlen($text); $i++) {
        $c = $text[$i];
        if (array_key_exists($c, $freq)) {
            $freq[$c]++;
        } else {
            $freq[$c] = 1;
        }
    }
    return $freq;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("HI") !== array("h" => 1, "i" => 1)) { throw new Exception("Test failed!"); }
}

test();
