<?php
function f($replace, $text, $hide) {
    while (strpos($text, $hide) !== false) {
        $replace .= 'ax';
        $text = str_replace($hide, $replace, $text);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("###", "ph>t#A#BiEcDefW#ON#iiNCU", ".") !== "ph>t#A#BiEcDefW#ON#iiNCU") { throw new Exception("Test failed!"); }
}

test();
