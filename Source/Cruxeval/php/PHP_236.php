<?php
function f($array) {
    if (count($array) == 1) {
        return implode('', $array);
    }
    $result = $array;
    $i = 0;
    while ($i < count($array) - 1) {
        for ($j = 0; $j < 2; $j++) {
            $result[$i * 2] = $array[$i];
            $i++;
        }
    }
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("ac8", "qk6", "9wg")) !== "ac8qk6qk6") { throw new Exception("Test failed!"); }
}

test();
