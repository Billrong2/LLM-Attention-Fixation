<?php
function f($text, $char) {
    $text = str_split($text);
    foreach($text as $key => $item){
        if($item == $char){
            unset($text[$key]);
            return implode('', $text);
        }
    }
    return implode('', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("pn", "p") !== "n") { throw new Exception("Test failed!"); }
}

test();
