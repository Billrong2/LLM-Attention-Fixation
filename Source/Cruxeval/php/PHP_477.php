<?php
function f($text) {
    $parts = explode('|', $text, 2);
    $topic = '';
    $problem = '';
    if (count($parts) === 2) {
        list($topic, $problem) = $parts;
    } else {
        $topic = $parts[0];
    }
    if ($problem === 'r') {
        $problem = str_replace('u', 'p', $topic);
    }
    return array($topic, $problem);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("|xduaisf") !== array("", "xduaisf")) { throw new Exception("Test failed!"); }
}

test();
