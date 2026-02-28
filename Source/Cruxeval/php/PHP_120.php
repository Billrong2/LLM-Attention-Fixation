<?php
function f($countries) {
    $language_country = array();
    foreach($countries as $country => $language){
        if (!array_key_exists($language, $language_country)) {
            $language_country[$language] = array();
        }
        $language_country[$language][] = $country;
    }
    return $language_country;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
