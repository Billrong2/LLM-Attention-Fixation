<?php
function f($text) {
    $words = explode(' ', $text);
    foreach($words as $item) {
        $text = str_replace("-$item", ' ', $text);
        $text = str_replace("$item-", ' ', $text);
    }
    return trim($text, '-');
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("-stew---corn-and-beans-in soup-.-") !== "stew---corn-and-beans-in soup-.") { throw new Exception("Test failed!"); }
}

test();
