<?php
function f($text) {
    $texts = explode(" ", $text);
    if (!empty($texts)) {
        $xtexts = array_filter($texts, function($t) {
            return ctype_print($t) && !in_array($t, ['nada', '0']);
        });
        return $xtexts ? max($xtexts) : 'nada';
    }
    return 'nada';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("") !== "nada") { throw new Exception("Test failed!"); }
}

test();
