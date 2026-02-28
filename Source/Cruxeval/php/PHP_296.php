<?php
function f($url) {
    return str_replace('http://www.', '', $url);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("https://www.www.ekapusta.com/image/url") !== "https://www.www.ekapusta.com/image/url") { throw new Exception("Test failed!"); }
}

test();
