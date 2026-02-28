<?php
function f($strings) {
    $occurances = array();
    foreach($strings as $string){
        if (!array_key_exists($string, $occurances)){
            $occurances[$string] = array_count_values($strings)[$string];
        }
    }
    return $occurances;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("La", "Q", "9", "La", "La")) !== array("La" => 3, "Q" => 1, "9" => 1)) { throw new Exception("Test failed!"); }
}

test();
