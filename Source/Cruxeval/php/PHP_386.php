<?php
function f($concat, $di) {
    $count = count($di);
    for ($i = 0; $i < $count; $i++) {
        if (in_array($di[(string)$i], str_split($concat))) {
            unset($di[(string)$i]);
        }
    }
    return "Done!";
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mid", array("0" => "q", "1" => "f", "2" => "w", "3" => "i")) !== "Done!") { throw new Exception("Test failed!"); }
}

test();
