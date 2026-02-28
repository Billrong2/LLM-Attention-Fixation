<?php
function f($marks) {
    $highest = 0;
    $lowest = 100;
    foreach ($marks as $value) {
        if ($value > $highest) {
            $highest = $value;
        }
        if ($value < $lowest) {
            $lowest = $value;
        }
    }
    return [$highest, $lowest];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("x" => 67, "v" => 89, "" => 4, "alij" => 11, "kgfsd" => 72, "yafby" => 83)) !== array(89, 4)) { throw new Exception("Test failed!"); }
}

test();
