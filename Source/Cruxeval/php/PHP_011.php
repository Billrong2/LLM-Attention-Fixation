<?php
function f($a, $b) {
    foreach ($b as $key => $value) {
        if (!array_key_exists($key, $a)) {
            $a[$key] = [$value];
        } else {
            $a[$key][] = $value;
        }
    }
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), array("foo" => "bar")) !== array("foo" => array("bar"))) { throw new Exception("Test failed!"); }
}

test();
