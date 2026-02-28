<?php
function f($stg, $tabs) {
    foreach ($tabs as $tab) {
        $stg = rtrim($stg, $tab);
    }
    return $stg;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("31849 let it!31849 pass!", array("3", "1", "8", " ", "1", "9", "2", "d")) !== "31849 let it!31849 pass!") { throw new Exception("Test failed!"); }
}

test();
