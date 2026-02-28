<?php
function f($d, $l) {
    $new_d = array();

    foreach ($l as $k) {
        if (array_key_exists($k, $d)) {
            $new_d[$k] = $d[$k];
        }
    }

    return $new_d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("lorem ipsum" => 12, "dolor" => 23), array("lorem ipsum", "dolor")) !== array("lorem ipsum" => 12, "dolor" => 23)) { throw new Exception("Test failed!"); }
}

test();
