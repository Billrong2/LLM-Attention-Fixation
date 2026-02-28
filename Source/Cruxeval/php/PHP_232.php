<?php
function f($text, $changes) {
    $result = '';
    $count = 0;
    $changes = str_split($changes);
    for ($i = 0; $i < strlen($text); $i++) {
        $char = $text[$i];
        $result .= ($char === 'e') ? $char : $changes[$count % count($changes)];
        $count += ($char !== 'e') ? 1 : 0;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("fssnvd", "yes") !== "yesyes") { throw new Exception("Test failed!"); }
}

test();
