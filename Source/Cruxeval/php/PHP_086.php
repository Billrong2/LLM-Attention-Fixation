<?php
function f($instagram, $imgur, $wins) {
    $photos = array($instagram, $imgur);
    if ($instagram == $imgur) {
        return $wins;
    }
    if ($wins == 1) {
        return array_pop($photos);
    } else {
        $photos = array_reverse($photos);
        return array_pop($photos);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("sdfs", "drcr", "2e"), array("sdfs", "dr2c", "QWERTY"), 0) !== array("sdfs", "drcr", "2e")) { throw new Exception("Test failed!"); }
}

test();
