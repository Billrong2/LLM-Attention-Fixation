<?php
function f($cities, $name) {
    if (empty($name)) {
        return $cities;
    }
    if ($name && $name !== 'cities') {
        return [];
    }
    return array_map(function($city) use ($name) {
        return $name . $city;
    }, $cities);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("Sydney", "Hong Kong", "Melbourne", "Sao Paolo", "Istanbul", "Boston"), "Somewhere ") !== array()) { throw new Exception("Test failed!"); }
}

test();
